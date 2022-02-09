# This script assumes you have an /archive top folder, and that the file resulting from downloading https://covid19.infn.it/iss/csv_part/iss.tar.gz has been extracted there. This folder won't be pushed, since "/archive" is in the .gitignore
cd("src")
using Pkg
Pkg.activate(".")
Pkg.instantiate()
cd("..")

using DataFrames
using CSV

# Get OS-specific sile path separator
const os_separator = Base.Filesystem.path_separator

## Path to input dir
const path_to_processed_initial_conditions = "./2_input/initial_conditions"

## Path to raw initial conditions
const path_to_raw_initial_conditions = "./raw_initial_conditions"

#const path_to_processed_initial_conditions = "2"


# Regions and italy names. See http://en.comuni-italiani.it/regioni.html
const regions_italy_names_translations = Dict("italia" => "italy", "valle_daosta" => "aosta_valley", "piemonte" => "piedmont", "lombardia" => "lombardy", "toscana" => "tuscany", "marche" => "marches", "puglia" => "apulia",  "sicilia" => "sicily" ,"sardegna" => "sardinia")

const provinces_translations = Dict("genova" => "genoa", "milano" => "milan", "napoli" => "naples", "roma_" => "rome_", "torino" => "turin", "venezia" => "venice" )

const further_translations = Dict("positivi" => "confirmed", "sintomatici" => "symptomatic", "ricoveri" => "hospitalizations", "terapia_intensiva" => "intensive_care", "deceduti" => "deceased", "quantili" => "quantiles", "eta" => "age", "maschi" => "male", "femmine" => "female")

const translations = merge(regions_italy_names_translations,provinces_translations ,further_translations)


const column_names_translations = Dict(
# overall_prevalences_by_region_sex_age    
"data" => "date",
#daily_incidences_by_region_sex_age
"0-9 anni" => "0_9", "10-19 anni" => "10_19", "20-29 anni" => "20_29", "30-39 anni" => "30_39", "40-49 anni" => "40_49", "50-59 anni" => "50_59", "60-69 anni" => "60_69", "70-79 anni" => "70_79", "80-89 anni" => "80_89", "≥90 anni" => "90_+"
                                      )


for csv_path in [path for path in readdir(path_to_raw_initial_conditions; join = true) if occursin("maschi", path) || occursin("femmine", path)]

    csv_name =  string(split(csv_path, os_separator)[end])
    # Initialize translated name
    translated_name = deepcopy(csv_name)
    for translation in translations
        translated_name = replace(translated_name, translation)
    end
    println("csv_name = $csv_name \t translated_name = $translated_name")

    # Consider just  the first seven intensities
    df = CSV.read(csv_path, DataFrame)[1:7, :]
    
    # Translate columns to english
    for col in names(df)
        if col  in keys(column_names_translations)
            rename!(df,Dict( col => column_names_translations[col] ))
        end
    end

    CSV.write(joinpath(path_to_processed_initial_conditions, translated_name ), df )

end