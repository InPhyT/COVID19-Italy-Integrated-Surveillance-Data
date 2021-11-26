"""
    multiple_string_replace(str::String, replacements::Dict{String,String})

Replace `keys(replacements)` with, respectively, `values(replacements)` inside `str` and return the replaced string.
"""
function multiple_string_replace(str::String, replacements::Tuple{Vararg{Pair{String,String}}})
    output_string = str
    
    for replacement in replacements
        output_string = replace(output_string,replacement)
    end

    return output_string
end

"""
    get_aggregated_dataframe_name_from_unaggragated_dataframe(unaggregated_name::String)

Equivalent to `replace(unaggregated_name, "age_date" => "bydate")`.
"""
get_aggregated_dataframe_name_from_unaggragated_dataframe(unaggregated_name::String) = replace(unaggregated_name, "age_date" => "bydate")
"""
    get_over80_aggregated_dataframe_name_from_unaggragated_dataframe(unaggregated_name::String)

Equivalent to `replace(unaggregated_name, "age_date" => "80plus")`.
"""
get_over80_aggregated_dataframe_name_from_unaggragated_dataframe(unaggregated_name::String) = replace(unaggregated_name, "age_date" => "80plus")

"""
    unroll_iss_infn_csv(iss_infn_dataset::DataFrame, n₋::Int64, n₊::Int64, horizontal_check_cases::Union{Nothing,Vector{Int64}}; skip_lines::Int64 = 1 )

Reverses all moving averages contained in a .csv file downloaded from https://covid19.infn.it/iss/ (i.p. a regional dataset of the form `age_date`), returning an equivalent datasets with unrolled moving averages as columns.
# Arguments
- `iss_infn_dataset::DataFrame`: the dataframe whose columns (from the 2nd onward) are the moving averages of the age-stratified incidences;
- `n₋::Int64`: the number of window values before the date the moving average of a window is associated to;
- `n₊::Int64`: the number of window values after the date the moving average of a window is associated to;
- `horizontal_check_cases::Union{Nothing,Vector{Int64}}`: the array of age-disaggregated incidences to perform the **cross-sectional consistency constraint** against. May be left unspecified (nothing), in which case no reconstructed dataframe will be outputted in case of multiple possibilities.
- `skip_lines::Int64 = 1`: the number of dates at the top of `iss_infn_dataset` whose recosntructed incidences would not be part of the average.
"""
function unroll_iss_infn(iss_infn_dataset::DataFrame, n₋::Int64, n₊::Int64, horizontal_check_cases::Union{Nothing,Vector{Int64}}; skip_lines::Int64 = 1 )

    # Get the names of the columns of `iss_infn_dataset`
    colnames::Vector{String} = names(iss_infn_dataset)
    # Get the dates
    dates::Vector{Dates.Date} = iss_infn_dataset[!,"date"]
    # Get the columns to be deaveraged
    moving_averages::Vector{Vector{Float64}} = [[x  for x in skipmissing(iss_infn_dataset[!,i]) ] for i in 2:size(iss_infn_dataset)[2] ]

    #println("minimum_windows_total_cases  =  ", [moving_average[argmin(moving_average)] * (n₋ + n₊ +1 ) for moving_average in moving_averages])
    # Call unroll on each moving average so that it dispatches to `unroll_iterative`
    reconstructed_incidences::Vector{Vector{Vector{Int64}}} = [unroll(moving_average,n₋ + n₊ +1; assert_positive_integer = true) for moving_average in moving_averages ]

    # Preallocate the array that will contain the accepted combinations of `reconstructed_incidences`
    accepted_possibilities_combinations_flat::Vector{Vector{Union{Missing,Int64}}} = Vector{Union{Missing,Int64}}[]

    # If ther are more possibilities for some age class, then run the horizontal check
    if unique(length.(reconstructed_incidences)) != [1] && !isnothing(horizontal_check_cases)
        println("to_be_unrolled Dataframe has some moving averages that cannot be brought back to one and only one reconstructed time series. Lengths of reconstructions are "* string(length.(reconstructed_incidences))* "\n trying to select via horizontal check...")
        # Get all combinations of possibilities
        possibilities_combinations_iterator::Base.Iterators.ProductIterator = Iterators.product(reconstructed_incidences...)

        # Get the number of such combinations
        l = length(possibilities_combinations_iterator)

        println("horizontal check. Total possibilities combinations = $l" )

        # Pre allocated array if accepted combinations. We are not yet sure they can be only one...
        accepted_possibilities_combinations = Vector{Vector{Int64}}[]
        
        #https://discourse.julialang.org/t/for-loop-optimization/70700/4
        for (k,possibilities_combination) in enumerate(possibilities_combinations_iterator)
            if k%1000000 == 0
                println("horizontal check. Done $k \\ $l , ", k/l )
                println("length(accepted_possibilities_combinations) = ", length(accepted_possibilities_combinations))
            end
            success = true
            c_1, c_2, c_3, c_4, c_5, c_6, c_7, c_8, c_9, c_10  = possibilities_combination
            
            for i ∈ eachindex(horizontal_check_cases)
                if c_1[i] + c_2[i] + c_3[i] + c_4[i] + c_5[i] + c_6[i] + c_7[i] + c_8[i] + c_9[i] + c_10[i]  ≠ horizontal_check_cases[i]
                    success = false
                    break
                end
            end
            if success
                push!(accepted_possibilities_combinations, collect(possibilities_combination))
            end
        end


        # If there are more than one combinations that satisfy the total cases check, error
        if length(accepted_possibilities_combinations) != 1
            error("to_be_unrolled Dataframe has some moving averages that cannot be brought back to one and only one reconstructed time series, not even trying to use horizontal check, which yielded ", length(accepted_possibilities_combinations), "possibilities_combinations" )
        end

        println("After horizontal check, we have ",  length(accepted_possibilities_combinations), " possibilities_combinations left")

        accepted_possibilities_combinations_flat = vcat(accepted_possibilities_combinations...)
    
    elseif unique(length.(reconstructed_incidences)) != [1] && isnothing(horizontal_check_cases)
        error("to_be_unrolled Dataframe has some moving averages that cannot be brought back to one and only one reconstructed time series and there is no horizontal check series available")
    else
        accepted_possibilities_combinations_flat = vcat(reconstructed_incidences...)
    end

    # Add as many missings at the top as skip_lines requires
    for i in 1:length(accepted_possibilities_combinations_flat)
        accepted_possibilities_combinations_flat[i] = vcat(repeat([missing], skip_lines), accepted_possibilities_combinations_flat[i] ) #pushfirst!(missing,reconstructed_incidences_flat[i])
    end

    # Return the combination as a dataframe identical (in structure) to a iss_infn one
    pairs::Vector{Pair} = [colname => col for (colname,col) in zip(colnames,vcat([dates],accepted_possibilities_combinations_flat) )]

    output_dataframe::DataFrame = DataFrame(pairs...)

    return output_dataframe


end

"""
    save_dataframe_to_csv(dataframe::DataFrame, save_dir_path::String, name::String)

Save DataFrame `dataframe` to directory `dir` with name `name`.
"""
function save_dataframe_to_csv( dataframe::DataFrame,save_dir_path::String, name::String)
    complete_path::String = joinpath(save_dir_path, name)
    CSV.write(complete_path, dataframe)
end