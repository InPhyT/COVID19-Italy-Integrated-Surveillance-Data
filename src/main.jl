# Activate Julia environment then return to root folder
cd("src")
using Pkg
Pkg.activate(".")
Pkg.instantiate()
cd("..")

# Imports
using Dates
using UnrollingAverages
using DataFrames, CSV
using Plots
using ProgressMeter
# using LoopVectorization # To be implemented
# using IfElse

# Switch backend
pyplot()

# Include functionalities
include("utilities.jl")

# Set script-wise parameters 
## Number of data points considered in the moving average widow before the time it is associated to 
const n₋ = 2
## Number of data points considered in the moving average widow after the time it is associated to 
const n₊ = 4
## Number of top data points not considered during averages 
const skip_lines = 0

# Paths
## Path to input folder
const input_dir_path = raw"2_input/daily_incidences_by_region_sex_age"
## Path to initial_conditions
const path_to_initial_conditions = raw"./2_input/initial_conditions"
## Path to regional incidences, for total cases check
const region_incidences_dir = raw"2_input/daily_incidences_by_region"
## Path to over80 incidences. Currently unused, it would allow for a slightly better total cases check.
# const over80_horizontal_checks_dir_path = raw"./original_organized\ultra_ottantenni__daily_incidences_over80_by_region"
## Path to output folder
const output_files_dir_path = raw"./3_output/data/"
## Get OS-specific file path separator
const os_separator = Base.Filesystem.path_separator
## Path to processed ground truths
# const path_to_processed_ground_truths = "./processed_ground_truths"

const input_paths = readdir(input_dir_path; join = true, sort = false)
# As per methodology, get all paths that contain "male" and "female", except those regarding italy (all incidences) or positive and symptomatic incidences in lombardy. These we know to cause problems, Those that can't be uniquely determined are saved in a failed array, later used to try the corresponding non-sex stratified ones.
# const female_male_paths_without_lombardy_positives_symptomatics = [path for path in input_paths if ((!occursin("lombardy",path) && (occursin("male", path) || occursin("female", path))) || (occursin("lombardy",path) && (!occursin("symptomatic", path) && !occursin("confirmed",path)) && (occursin("male", path) || occursin("female", path)) )) && !occursin(".gitkeep",path) ] # && !occursin("italy",path)
const female_male_paths = [path
 for path in input_paths
 if (occursin("male", path) || occursin("female", path))] #(!occursin("sintomatici", path) && !occursin("positivi",path)) && && !occursin("italy",path) 
#const lombardy_paths = [path for path in input_paths if (occursin("male", path) || occursin("female", path)) && occursin("lombardy",path)]
#const lombardy_positive_symptomatics_paths = reverse([path for path in input_paths if !occursin("maschi", path) && !occursin("femmine", path) && occursin("lombardia",path) && (occursin("positivi",path) || occursin("sintomatici",path))])
const total_female_male_paths = length(female_male_paths)

# Store the paths pointing to the csv that were not able to be reduced to a single time series. These will be later attempted to be recovered from the sex-aggregated time series. Since we use multithreading, we instantiate failed_paths_multithread as suggested in https://stackoverflow.com/a/65715547/13110508
failed_paths_multithread = [String[] for i in 1:Threads.nthreads()]
reconstructed_csvs = Dict{String,DataFrame}()

# Multithreaded loop
# Loop over all sex-disaggregated paths except the nationals
include("utilities.jl")
for i in eachindex(female_male_paths)   #Threads.@threads 
    input_path = female_male_paths[i]
    output_name = string(split(input_path, os_separator)[end])
    println("\nUnrolling $output_name ( $i \\ $total_female_male_paths) ...")

    # Reconstruct the time series
    incidence_dataframe = CSV.read(input_path, DataFrame)
    initial_conditions_dataframe = CSV.read(joinpath(path_to_initial_conditions,
            output_name), DataFrame)
    reconstructed_df::DataFrame = DataFrame()
    try
        reconstructed_df = unroll_iss_infn(incidence_dataframe, n₋, n₊, nothing;
            initial_conditions_dataframe = initial_conditions_dataframe,
            skip_lines = skip_lines)
        push!(reconstructed_csvs, output_name => reconstructed_df)
        #println("saving to $(joinpath(output_files_dir_path,output_name))")
        #CSV.write(joinpath( raw"E:\GitHub\COVID19-Italy-Integrated-Surveillance-Data\3_output\data",output_name), reconstructed_df)

        save_dataframe_to_csv(reconstructed_df, output_files_dir_path, output_name)
    catch e
        if isa(e, ErrorException)
            println(e.msg)
            push!(failed_paths_multithread[Threads.threadid()], input_path)
            continue
        else
            throw(e)
        end
        continue
    end
end

# Flatten 
const failed_paths = vcat(failed_paths_multithread...)

# const failed_paths = [
# "./2_input/daily_incidences_by_age_date_sex_region\\iss_age_date_emilia_romagna_confirmed_female.csv"
# ,"./2_input/daily_incidences_by_age_date_sex_region\\iss_age_date_emilia_romagna_confirmed_male.csv"
# ,"./2_input/daily_incidences_by_age_date_sex_region\\iss_age_date_lombardy_confirmed_female.csv"
# ,"./2_input/daily_incidences_by_age_date_sex_region\\iss_age_date_lombardy_confirmed_male.csv"
# ,"./2_input/daily_incidences_by_age_date_sex_region\\iss_age_date_lombardy_symptomatic_female.csv"
# ,"./2_input/daily_incidences_by_age_date_sex_region\\iss_age_date_lombardy_symptomatic_male.csv"
# ]

reconstructed_h_csvs = Dict{String,DataFrame}()
# Attempt unrolling of sex-aggregated time series for the datasets that couldn't be brought back to a single time series
## Aggregate paths by sex
sex_aggregated_paths = unique([
    multiple_string_replace(failed_path,
        ("_male" => "", "_female" => ""))
    for failed_path in failed_paths
])
## Compute total sex-aggregated paths to be unrolled
const total_sex_aggregated_paths = length(sex_aggregated_paths)
## Loop over the sex aggregated paths
for i in eachindex(sex_aggregated_paths) #Threads.@threads 
    sex_aggregated_path = reverse(sex_aggregated_paths)[i]
    # Name to be given to the output file
    output_name = string(split(sex_aggregated_path, os_separator)[end])
    println("\nUnrolling $output_name ( $i \\ $total_sex_aggregated_paths) ...")
    # Load horizontal check (if it exists)

    horizontal_check_cases::Union{Nothing,Vector{Int64}} = nothing
    try
        horizontal_check_cases = CSV.read(
            joinpath(region_incidences_dir,
                get_aggregated_dataframe_name_from_unaggragated_dataframe(output_name),
            ),
            DataFrame)[
            !,
            "incidence",
        ][(1+skip_lines):end]

        println("Horizontal check series found")
    catch e
        println("Horizontal check series NOT found")
    end
    # Reconstruct the time series, optionally making use of the total cases check
    sex_aggregated_dataframe = CSV.read(sex_aggregated_path, DataFrame)
    female_output_name = split(output_name, ".")[1] * "_female.csv"
    male_output_name = split(output_name, ".")[1] * "_male.csv"
    initial_conditions_female = CSV.read(joinpath(path_to_initial_conditions,
            female_output_name), DataFrame)
    initial_conditions_male = CSV.read(joinpath(path_to_initial_conditions,
            male_output_name), DataFrame)
    initial_conditions_dataframe = DataFrame(
        Dict(
            col => initial_conditions_female[!,
                col] .+
                   initial_conditions_male[!, col]
            for col in names(initial_conditions_female)
            if col ∉ ["date"]
        ),
    )
    println(initial_conditions_dataframe, "\n")
    reconstructed_df::DataFrame = DataFrame()
    try
        reconstructed_df = unroll_iss_infn(sex_aggregated_dataframe, n₋, n₊,
            horizontal_check_cases;
            initial_conditions_dataframe = initial_conditions_dataframe,
            skip_lines = skip_lines)
        push!(reconstructed_h_csvs, output_name => reconstructed_df)
        #save_dataframe_to_csv(reconstructed_df,output_files_dir_path,output_name)
    catch e
        if isa(e, ErrorException)
            println(e.msg)
            continue
        else
            throw(e)
        end
        continue
    end
end

# Tidy the dataset to satisfy https://github.com/epiforecasts/covidregionaldata/issues/463#issuecomment-1066127594
## Translated names of regions
const regions_italy_names = Dict("abruzzo" => "Abruzzo", "aosta_valley" => "Valle d'Aosta",
    "apulia" => "Puglia", "basilicata" => "Basilicata",
    "calabria" => "Calabria", "campania" => "Campania",
    "emilia_romagna" => "Emilia-Romagna",
    "friuli_venice_giulia" => "Friuli Venezia Giulia",
    "lazio" => "Lazio", "liguria" => "Liguria",
    "lombardy" => "Lombardia", "marches" => "Marche",
    "molise" => "Molise", "pa_bolzano" => "P.A. Bolzano",
    "pa_trento" => "P.A. Trento", "piedmont" => "Piemonte",
    "sardinia" => "Sardegna", "sicily" => "Sicilia",
    "trentino_alto_adige" => "Trentino-Alto Adige",
    "tuscany" => "Toscana", "umbria" => "Umbria",
    "veneto" => "Veneto", "italy" => "Italia")
## Output dataframe
const tidy_dataframe = get_tidy_dataframe(reconstructed_csvs, regions_italy_names)

## Save tidied dataframe
save_dataframe_to_csv(tidy_dataframe, "epiforecasts_covidregionaldata",
    "COVID19-Italy-Integrated-Surveillance-Data.csv")

# Paths to outputted .csvs with OS-specific file separators
const output_paths = [
    replace(path, "/" => os_separator)
    for path in readdir(output_files_dir_path; join = true)
    if !occursin(".gitkeep", path)
]

## Plot each unrolled csv together with averaged data
const output_plots_dir_path = "3_output/figures/"
# Loop over all outputted paths
for output_path in output_paths

    # Discard males since for every female path we also consider the corresponding male
    if occursin("_male", output_path)
        continue
    end

    # Extract .csv file name
    output_female_name = string(split(output_path, os_separator)[end])
    println(output_female_name)

    # Load female and male output dataframes
    female_out_df = CSV.read(output_path, DataFrame)
    male_out_df = CSV.read(replace(output_path, "female" => "male"), DataFrame)

    intersect_dates_out = intersect(female_out_df[!, "date"], male_out_df[!, "date"])

    # load load female and male input dataframes
    ## Construct input path
    input_female_path = joinpath(input_dir_path, output_female_name)

    female_inp_df = CSV.read(input_female_path, DataFrame)
    male_inp_df = CSV.read(replace(input_female_path, "female" => "male"), DataFrame)

    # Get maximum of minima dates, and minimum of maxima
    intersect_dates_inp = intersect(female_inp_df[!, "date"], male_inp_df[!, "date"])

    # Get dates common to input and output. These will be the dates used for plotting
    dates = intersect(intersect_dates_out, intersect_dates_inp)

    # Subplots
    plots = []
    ## Sex-aggregated dataframe to be saved to 3_output/data
    sex_aggregated_out_df = DataFrame(date = intersect_dates_out)
    for (col, color) in zip(names(female_out_df[!, Not("date")]), palette(:tab20))
        subplot_title = multiple_string_replace(col, ("_+" => "+", "_" => "-"))
        col_sym = Symbol(col)
        aggregated_column =
            female_out_df[in.(female_out_df.date, Ref(intersect_dates_out)),
                col] .+
            male_out_df[in.(male_out_df.date, Ref(intersect_dates_out)),
                col]
        @eval $sex_aggregated_out_df.$col_sym = $aggregated_column
        p = plot(title = subplot_title, size = (2500, 1500), legend = :topleft)
        plot!(intersect_dates_out, eval(:($sex_aggregated_out_df.$col)),
            label = "Reconstructed Series", seriestype = :scatter, color = color,
            markerstrokewidth = 0.3, fillalpha = 0.1) #xrotation=45  
        plot!(intersect_dates_inp,
            female_inp_df[in.(female_inp_df.date, Ref(intersect_dates_inp)), col] .+
            male_inp_df[in.(male_inp_df.date, Ref(intersect_dates_inp)), col],
            label = "Moving Average", color = color, lw = 4)
        push!(plots, p)
    end
    grid = plot(plots..., layout = (11, 1),
        plot_title = multiple_string_replace(output_female_name,
            ("_female" => "", ".csv" => "")))#dpi = 100
    savefig(grid,
        joinpath(output_plots_dir_path,
            multiple_string_replace(output_female_name,
                ("_female" => "", ".csv" => ""))))
    # Save the sex_aggregated_dataframe
    save_dataframe_to_csv(sex_aggregated_out_df, output_files_dir_path,
        replace(output_female_name, "_female" => ""))
end

## using over80 data for a stratified (over and under 80y) horizontal check
## load the dataframe with the averaged time series to deconvolve
# averaged_df = CSV.read( input_path, DataFrame)

## load the corresponding over80 dataset
# horizontal_check_cases_df = CSV.read( joinpath(over80_horizontal_checks_dir_path, get_over80_aggregated_dataframe_name_from_unaggregated_dataframe(output_name)), DataFrame) 
## sort such  dataframe by date
# sort!(horizontal_check_cases_df, [:data])

## compute row index (in horizontal_check_cases_df) of the first and last date required by averaged_df for validation
# minimum_row_idx = findfirst(x -> x == averaged_df[!, "data"][1 + skip_lines],  horizontal_check_cases_df[!, "data"])
# maximum_row_idx = findfirst(x -> x == averaged_df[!, "data"][end],  horizontal_check_cases_df[!, "data"])

## select portion of horizontal_check_cases within those two dates
# horizontal_check_cases = [x for x in skipmissing(horizontal_check_cases_df[!,"≥80 anni"][minimum_row_idx:maximum_row_idx])].+ [x for x in skipmissing(horizontal_check_cases_df[!,"altri"][minimum_row_idx:maximum_row_idx])]