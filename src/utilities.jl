
"""
    multiple_string_replace(str::String, replacements::Dict{String,String})

Replace `keys(replacements)` with, respectively, `values(replacements)` inside `str` and return the replaced string.
"""
function multiple_string_replace(str::String,
    replacements::Tuple{Vararg{Pair{String,String}}})
    output_string = str

    for replacement in replacements
        output_string = replace(output_string, replacement)
    end

    return output_string
end

"""
    get_aggregated_dataframe_name_from_unaggragated_dataframe(unaggregated_name::String)

Equivalent to `replace(unaggregated_name, "age_date" => "bydate")`.
"""
function get_aggregated_dataframe_name_from_unaggragated_dataframe(
    unaggregated_name::String,
)
    replace(unaggregated_name, "age_date" => "bydate")
end
"""
    get_over80_aggregated_dataframe_name_from_unaggragated_dataframe(unaggregated_name::String)

Equivalent to `replace(unaggregated_name, "age_date" => "80plus")`.
"""
function get_over80_aggregated_dataframe_name_from_unaggragated_dataframe(
    unaggregated_name::String,
)
    replace(unaggregated_name, "age_date" => "80plus")
end

"""
    unroll_iss_infn_csv(iss_infn_dataframe::DataFrame, n₋::Int64, n₊::Int64, horizontal_check_cases::Union{Nothing,Vector{Int64}}; skip_lines::Int64 = 1 )

Reverses all moving averages contained in a .csv file downloaded from https://covid19.infn.it/iss/ (i.p. a regional dataset of the form `age_date`), returning an equivalent datasets with unrolled moving averages as columns.
# Arguments
- `iss_infn_dataframe::DataFrame`: the dataframe whose columns (from the 2nd onward) are the moving averages of the age-stratified incidences;
- `n₋::Int64`: the number of window values before the date the moving average of a window is associated to;
- `n₊::Int64`: the number of window values after the date the moving average of a window is associated to;
- `horizontal_check_cases::Union{Nothing,Vector{Int64}}`: the array of age-disaggregated incidences to perform the **cross-sectional consistency constraint** against. May be left unspecified (nothing), in which case no reconstructed dataframe will be outputted in case of multiple possibilities.
- `skip_lines::Int64 = 1`: the number of dates at the top of `iss_infn_dataframe` whose reconstructed incidences would not be part of the average.
"""
function unroll_iss_infn(iss_infn_dataframe::DataFrame, n₋::Int64, n₊::Int64,
    horizontal_check_cases::Union{Nothing,Vector{Int64}};
    initial_conditions_dataframe::U = nothing,
    assert_positive_integer::Bool = true,
    skip_lines::Int64 = 1) where {U<:Union{DataFrame,Nothing}} #Tuple{Vararg{Union{Int64,Float64}}}

    # Get the names of the columns of `iss_infn_dataframe`
    colnames::Vector{String} = names(iss_infn_dataframe)
    # Get the dates
    dates::Vector{Dates.Date} = iss_infn_dataframe[!, "date"]
    # Get the columns to be deaveraged
    age_classes = filter(x -> x != "date", names(iss_infn_dataframe))
    moving_averages::Vector{Vector{Float64}} = [
        [x
         for x in skipmissing(iss_infn_dataframe[:,
            age_class])]
        for age_class in age_classes
    ]
    initial_conditions::Vector{Union{Nothing,Tuple{Vararg{Int64}}}} = [
        !isnothing(initial_conditions_dataframe) ?
        Tuple(initial_conditions_dataframe[:,
            age_class]) :
        nothing
        for age_class in age_classes
    ]

    #println("minimum_windows_total_cases  =  ", [moving_average[argmin(moving_average)] * (n₋ + n₊ +1 ) for moving_average in moving_averages])
    # Call unroll on each moving average so that it dispatches to `unroll_iterative`
    reconstructed_incidences::Vector{Vector{Vector{Int64}}} = [
        unroll(moving_average,
            n₋ + n₊ + 1;
            initial_conditions = initial_condition,
            assert_positive_integer = assert_positive_integer)
        for (moving_average, initial_condition) in zip(moving_averages,
            initial_conditions)
    ]

    # Check that reconstructed time series have only positive figures
    # for (age_class,moving_average,reconstructed_incidences_age_class) in zip(age_classes,moving_averages,reconstructed_incidences)
    if !isnothing(initial_conditions_dataframe)
        for i in eachindex(reconstructed_incidences)
            # for reconstructed_incidence in reconstructed_incidences[i] #reconstructed_incidences_age_class
            # println( filter( x -> x < 0, reconstructed_incidence) )

            #@assert !(any(reconstructed_incidence .< 0))
            if any(reconstructed_incidences[i][1] .< 0)
                println(
                    "The reconstructed incidence for age_class $(age_classes[i]) has negative values, attempting to unroll it without using ICs...",
                )
                reconstructed_incidences[i] = unroll(moving_averages[i], n₋ + n₊ + 1;
                    assert_positive_integer = assert_positive_integer)
                if length(reconstructed_incidences[i]) ==
                   1 & all(reconstructed_incidences[i][1] .>= 0)
                    println("Incidence successfully reconstructed without using ICs")
                elseif length(reconstructed_incidences[i]) > 1
                    println(
                        "Could not reconstruct one and only incidence without using ICs, got $(length(reconstructed_incidences[i])) possibilities",
                    )
                end
            end
        end
    end

    # Preallocate the array that will contain the accepted combinations of `reconstructed_incidences`
    accepted_possibilities_combinations_flat::Vector{Vector{Union{Missing,Int64}}} = Vector{
        Union{
            Missing,
            Int64,
        },
    }[]

    # If ther are more possibilities for some age class, then run the horizontal check
    if unique(length.(reconstructed_incidences)) != [1] &&
       !isnothing(horizontal_check_cases)
        println(
            "to_be_unrolled Dataframe has some moving averages that cannot be brought back to one and only one reconstructed time series. Lengths of reconstructions are " *
            string(length.(reconstructed_incidences)) *
            "\n trying to select via horizontal check...",
        )
        # Get all combinations of possibilities
        possibilities_combinations_iterator::Base.Iterators.ProductIterator =
            Iterators.product(reconstructed_incidences...)

        # Get the number of such combinations
        l = length(possibilities_combinations_iterator)

        println("horizontal check. Total possibilities combinations = $l")

        # Pre allocated array if accepted combinations. We are not yet sure they can be only one...
        accepted_possibilities_combinations = Vector{Vector{Int64}}[]

        #https://discourse.julialang.org/t/for-loop-optimization/70700/4
        @showprogress 1 for (k, possibilities_combination) in
                            enumerate(possibilities_combinations_iterator)
            # if k%1000000 == 0
            #     println("horizontal check. Done $k \\ $l , ", k/l )
            #     println("length(accepted_possibilities_combinations) = ", length(accepted_possibilities_combinations))
            # end
            success = true
            c_1, c_2, c_3, c_4, c_5, c_6, c_7, c_8, c_9, c_10 = possibilities_combination

            for i in eachindex(horizontal_check_cases)
                if c_1[i] + c_2[i] + c_3[i] + c_4[i] + c_5[i] + c_6[i] + c_7[i] + c_8[i] +
                   c_9[i] + c_10[i] ≠ horizontal_check_cases[i]
                    success = false
                    break
                end
            end
            if success
                push!(accepted_possibilities_combinations,
                    collect(possibilities_combination))
                break
            end
        end

        # If there are more than one combinations that satisfy the total cases check, error
        if length(accepted_possibilities_combinations) != 1
            error(
                "to_be_unrolled Dataframe has some moving averages that cannot be brought back to one and only one reconstructed time series, not even trying to use horizontal check, which yielded ",
                length(accepted_possibilities_combinations), "possibilities_combinations")
        end

        println("After horizontal check, we have ",
            length(accepted_possibilities_combinations),
            " possibilities_combinations left")

        accepted_possibilities_combinations_flat =
            vcat(accepted_possibilities_combinations...)

    elseif unique(length.(reconstructed_incidences)) != [1] &&
           isnothing(horizontal_check_cases)
        error(
            "to_be_unrolled Dataframe has some moving averages that cannot be brought back to one and only one reconstructed time series and there is no horizontal check series available",
        )
    else
        accepted_possibilities_combinations_flat = vcat(reconstructed_incidences...)
    end

    # Add as many missings at the top as skip_lines requires
    for i in 1:length(accepted_possibilities_combinations_flat)
        accepted_possibilities_combinations_flat[i] = vcat(repeat([missing], skip_lines),
            accepted_possibilities_combinations_flat[i]) #pushfirst!(missing,reconstructed_incidences_flat[i])
    end

    # Return the combination as a dataframe identical (in structure) to a iss_infn one
    pairs::Vector{Pair} = [
        colname => col
        for (colname, col) in zip(colnames,
            vcat([dates],
                accepted_possibilities_combinations_flat))
    ]

    output_dataframe::DataFrame = DataFrame(pairs...)

    return output_dataframe
end

# """
#     unroll_iss_infn_recursive(iss_infn_dataframe::DataFrame, n₋::Int64, n₊::Int64, horizontal_check_cases::Union{Nothing,Vector{Int64}}; skip_lines::Int64 = 1 )

# Reverses all moving averages contained in a .csv file downloaded from https://covid19.infn.it/iss/ (i.p. a regional dataset of the form `age_date`), returning an equivalent datasets with unrolled moving averages as columns.
# # Arguments
# - `iss_infn_dataframe::DataFrame`: the dataframe whose columns (from the 2nd onward) are the moving averages of the age-stratified incidences;
# - `n₋::Int64`: the number of window values before the date the moving average of a window is associated to;
# - `n₊::Int64`: the number of window values after the date the moving average of a window is associated to;
# - `horizontal_check_cases::Union{Nothing,Vector{Int64}}`: the array of age-disaggregated incidences to perform the **cross-sectional consistency constraint** against. May be left unspecified (nothing), in which case no reconstructed dataframe will be outputted in case of multiple possibilities.
# - `skip_lines::Int64 = 1`: the number of dates at the top of `iss_infn_dataframe` whose reconstructed incidences would not be part of the average.
# """
# function unroll_iss_infn_recursive(iss_infn_dataframe::DataFrame, n₋::Int64, n₊::Int64, initial_conditions::Tuple{} horizontal_check_cases::Union{Nothing,Vector{Int64}}; skip_lines::Int64 = 1 )

#     # Get the names of the columns of `iss_infn_dataframe`
#     colnames::Vector{String} = names(iss_infn_dataframe)
#     # Get the dates
#     dates::Vector{Dates.Date} = iss_infn_dataframe[!,"date"]
#     # Get the columns to be deaveraged
#     moving_averages::Vector{Vector{Float64}} = [[x  for x in skipmissing(iss_infn_dataframe[!,i]) ] for i in 2:size(iss_infn_dataframe)[2] ]

#     #println("minimum_windows_total_cases  =  ", [moving_average[argmin(moving_average)] * (n₋ + n₊ +1 ) for moving_average in moving_averages])
#     # Call unroll on each moving average so that it dispatches to `unroll_iterative`
#     reconstructed_incidences::Vector{Vector{Vector{Int64}}} = [unroll(moving_average,n₋ + n₊ +1; initila_conditions = true) for moving_average in moving_averages ]

#     # Preallocate the array that will contain the accepted combinations of `reconstructed_incidences`
#     accepted_possibilities_combinations_flat::Vector{Vector{Union{Missing,Int64}}} = Vector{Union{Missing,Int64}}[]

#     # If ther are more possibilities for some age class, then run the horizontal check
#     if unique(length.(reconstructed_incidences)) != [1] && !isnothing(horizontal_check_cases)
#         println("to_be_unrolled Dataframe has some moving averages that cannot be brought back to one and only one reconstructed time series. Lengths of reconstructions are "* string(length.(reconstructed_incidences))* "\n trying to select via horizontal check...")
#         # Get all combinations of possibilities
#         possibilities_combinations_iterator::Base.Iterators.ProductIterator = Iterators.product(reconstructed_incidences...)

#         # Get the number of such combinations
#         l = length(possibilities_combinations_iterator)

#         println("horizontal check. Total possibilities combinations = $l" )

#         # Pre allocated array if accepted combinations. We are not yet sure they can be only one...
#         accepted_possibilities_combinations = Vector{Vector{Int64}}[]

#         #https://discourse.julialang.org/t/for-loop-optimization/70700/4
#         for (k,possibilities_combination) in enumerate(possibilities_combinations_iterator)
#             if k%1000000 == 0
#                 println("horizontal check. Done $k \\ $l , ", k/l )
#                 println("length(accepted_possibilities_combinations) = ", length(accepted_possibilities_combinations))
#             end
#             success = true
#             c_1, c_2, c_3, c_4, c_5, c_6, c_7, c_8, c_9, c_10  = possibilities_combination

#             for i ∈ eachindex(horizontal_check_cases)
#                 if c_1[i] + c_2[i] + c_3[i] + c_4[i] + c_5[i] + c_6[i] + c_7[i] + c_8[i] + c_9[i] + c_10[i]  ≠ horizontal_check_cases[i]
#                     success = false
#                     break
#                 end
#             end
#             if success
#                 push!(accepted_possibilities_combinations, collect(possibilities_combination))
#             end
#         end

#         # If there are more than one combinations that satisfy the total cases check, error
#         if length(accepted_possibilities_combinations) != 1
#             error("to_be_unrolled Dataframe has some moving averages that cannot be brought back to one and only one reconstructed time series, not even trying to use horizontal check, which yielded ", length(accepted_possibilities_combinations), "possibilities_combinations" )
#         end

#         println("After horizontal check, we have ",  length(accepted_possibilities_combinations), " possibilities_combinations left")

#         accepted_possibilities_combinations_flat = vcat(accepted_possibilities_combinations...)

#     elseif unique(length.(reconstructed_incidences)) != [1] && isnothing(horizontal_check_cases)
#         error("to_be_unrolled Dataframe has some moving averages that cannot be brought back to one and only one reconstructed time series and there is no horizontal check series available")
#     else
#         accepted_possibilities_combinations_flat = vcat(reconstructed_incidences...)
#     end

#     # Add as many missings at the top as skip_lines requires
#     for i in 1:length(accepted_possibilities_combinations_flat)
#         accepted_possibilities_combinations_flat[i] = vcat(repeat([missing], skip_lines), accepted_possibilities_combinations_flat[i] ) #pushfirst!(missing,reconstructed_incidences_flat[i])
#     end

#     # Return the combination as a dataframe identical (in structure) to a iss_infn one
#     pairs::Vector{Pair} = [colname => col for (colname,col) in zip(colnames,vcat([dates],accepted_possibilities_combinations_flat) )]

#     output_dataframe::DataFrame = DataFrame(pairs...)

#     return output_dataframe

# end

"""
    save_dataframe_to_csv(dataframe::DataFrame, save_dir_path::String, name::String)

Save DataFrame `dataframe` to directory `dir` with name `name`.
"""
function save_dataframe_to_csv(dataframe::DataFrame, save_dir_path::String, name::String)
    complete_path = joinpath(save_dir_path, name)
    CSV.write(complete_path, dataframe)
end

"""
    get_tidy_dataframe(reconstructed_csvs::Dict{String, DataFrame},regions_italy_names::Dict{String,String} )

Return the tidy version of the datasets, as requested by https://github.com/epiforecasts/covidregionaldata/issues/463#issuecomment-1066127594. 
"""
function get_tidy_dataframe(reconstructed_csvs::Dict{String,DataFrame},
    regions_italy_names::Dict{String,String})

    # Preallocate output
    tidy_dataframe = DataFrame(date = Date[], region = String[], gender = String[],
        age_cohort = String[], indicator = String[], count = Int64[])
    # Gender conversions
    genders_conversion = Dict("female" => "F", "male" => "M")
    # Indicators and their explicitations
    indicators = ("symptomatic", "hospitalizations", "deceased", "confirmed",
        "intensive_care")
    indicators_explicit = Dict("symptomatic" => "symptomatic",
        "hospitalizations" => "ordinary_hospital_admission",
        "deceased" => "deceased", "confirmed" => "confirmed",
        "intensive_care" => "ICU_admission")
    # Loop over each deconvolved dataset
    for (file_name, dataframe) in collect(reconstructed_csvs)
        ncols = length(names(dataframe)) - 1
        age_classes = collect(names(dataframe)[2:end])
        file_name_splitted = split(file_name, "_")
        region = filter(x -> occursin(x, file_name), collect(keys(regions_italy_names)))
        if length(region) != 1
            error("region = $region, \tfile_name = $file_name")
        end
        region_col = repeat([regions_italy_names[region[1]]], ncols * size(dataframe, 1))
        gender = file_name_splitted[end][1:(end-4)]
        gender_col = repeat([genders_conversion[gender]], ncols * size(dataframe, 1))
        indicator = filter(x -> occursin(x, file_name), indicators)
        @assert length(indicator) == 1
        indicator_col = repeat([indicators_explicit[indicator[1]]],
            ncols * size(dataframe, 1))
        age_cohort_col = vcat([repeat([age_class], size(dataframe, 1))
              for age_class in age_classes]...)
        date_col = vcat(repeat(dataframe.date, ncols))
        count_col = vcat([dataframe[!, col] for col in age_classes]...)
        append!(tidy_dataframe,
            DataFrame(date = date_col, region = region_col, gender = gender_col,
                age_cohort = age_cohort_col, indicator = indicator_col,
                count = count_col))
    end

    # Remove rows where count == 0
    tidy_dataframe = tidy_dataframe[tidy_dataframe.count.!=0, :]

    return tidy_dataframe
end