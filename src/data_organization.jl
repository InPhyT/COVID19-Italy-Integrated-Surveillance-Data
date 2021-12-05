# This script assumes you have an /archive top folder, and that the file resulting from downloading https://covid19.infn.it/iss/csv_part/iss.tar.gz has been extracted there. This folder won't be pushed, since "/archive" is in the .gitignore
cd("src")
using Pkg
Pkg.activate(".")
Pkg.instantiate()
cd("..")

using DataFrames
using CSV

# Paths
## Path to folder sructure root
const folder_structure_root_path = "./1_structured_archive" 
## Path to input dir
const input_dir_path = "./2_input"

# Get OS-specific sile path separator
const os_separator = Base.Filesystem.path_separator

# Define association infix => destination folder. The "bydate" infix case is treated separatedly everywhere, since we have to distinguish between stratification by region and by province, the latte rwith rolling means
const regular_infix_folderName_associations_ita = Dict(["_dt2"] => "andamento_della_durata_del_ricovero_prima_del_decesso__daily_deceased_hospital_length_of_stay",["_stack_osp"] => "andamento_di_ricoveri_terapie_intensive_e_decessi__daily_percentage_incidences_by_region_outcome", ["_quantili"] =>  "andamento_età_mediana__daily_age_quantiles_by_status", ["_stack_eta"] =>"andamento_per_fasce_di_età__daily_percentage_incidences_by_age", ["_dt"]=>"distribuzione_della_durata_del_ricovero_prima_del_decesso__deceased_hospital_length_of_stay_distribution_by_region" , ["_age_date"] => "nuovi_casi_giornalieri_per_fasce_di_età_daily_incidences_by_age_date_sex_region_rolling_mean", ["_opsan"] => "operatori_sanitari__daily_incidences_medical_staff_by_region", ["_rt"] => "tasso_di_contagio_Rt__daily_Rt_by_region_province_positive_symptomatic", ["_80plus"] => "ultra_ottantenni__daily_incidences_over80_by_region")

const regular_infix_folderName_associations_en = Dict(["_dt2"] => "temporal_distribution_of_time_delay_from_hospitalization_to_death",["_stack_osp"] => "daily_incidences_percentages_by_region_outcome", ["_quantili"] =>  "daily_age_quantiles_by_status", ["_stack_eta"] =>"daily_incidences_percentages_by_age", ["_dt"]=>"hospital_length_of_stay_distribution_deceased_by_region" , ["_age_date"] => "daily_incidences_by_region_sex_age", ["_opsan"] => "daily_incidences_healthcare_workers_by_region", ["_rt"] => "daily_Rt_by_region_province_status", ["_80plus"] => "daily_incidences_over80_by_region")

# Regular infixes, that is, all infexes except "bydate" and "byage"
const regular_infixes = collect(keys(regular_infix_folderName_associations_en))

# Regions and italy names. See http://en.comuni-italiani.it/regioni.html
const regions_italy_names = ["italia","valle_daosta" , "piemonte" , "liguria", "lombardia", "trentino_alto_adige", "veneto", "friuli_venezia_giulia", "emilia_romagna" , "toscana", "umbria", "marche", "lazio", "abruzzo", "molise", "campania", "puglia", "basilicata", "calabria", "sicilia" ,"sardegna"]

const regions_italy_names_translations = Dict("italia" => "italy", "valle_daosta" => "aosta_valley", "piemonte" => "piedmont", "lombardia" => "lombardy", "toscana" => "tuscany", "marche" => "marches", "puglia" => "apulia",  "sicilia" => "sicily" ,"sardegna" => "sardinia")

const provinces_translations = Dict("genova" => "genoa", "milano" => "milan", "napoli" => "naples", "roma_" => "rome_", "torino" => "turin", "venezia" => "venice" )

const further_translations = Dict("positivi" => "confirmed", "sintomatici" => "symptomatic", "ricoveri" => "hospitalizations", "terapia_intensiva" => "intensive_care", "deceduti" => "deceased", "quantili" => "quantiles", "eta" => "age", "maschi" => "male", "femmine" => "female")

const translations = merge(regions_italy_names_translations,provinces_translations ,further_translations)

# Create folder structure
## Regular cases
for dir in values(regular_infix_folderName_associations_en)
    if !isdir(joinpath(folder_structure_root_path, dir))
        mkdir(joinpath(folder_structure_root_path,dir))
    end
end
## "bydate" folders. csvs with infix may have regional stratification or provice stratification with rolling mean
if !isdir(joinpath(folder_structure_root_path,"daily_incidences_by_province"))
    mkdir(joinpath(folder_structure_root_path,"daily_incidences_by_province"))
end
if !isdir(joinpath(folder_structure_root_path,"daily_incidences_by_region"))
    mkdir(joinpath(folder_structure_root_path,"daily_incidences_by_region"))
end
## "byage" folders.  The infix may be "byage" or a both "byage" and "byage","istat"
if !isdir(joinpath(folder_structure_root_path,"overall_prevalences_by_region_sex_age"))
    mkdir(joinpath(folder_structure_root_path,"overall_prevalences_by_region_sex_age"))
end
if !isdir(joinpath(folder_structure_root_path,"relative_overall_prevalences_distributed_by_sex_age"))
    mkdir(joinpath(folder_structure_root_path,"relative_overall_prevalences_distributed_by_sex_age"))
end

## "ratio" and "ratio_age"
### Ratio
if !isdir(joinpath(folder_structure_root_path,"daily_incidences_ratios_by_region"))
    mkdir(joinpath(folder_structure_root_path,"daily_incidences_ratios_by_region"))
end
### ratio_age
if !isdir(joinpath(folder_structure_root_path,"daily_incidences_ratios_by_age"))
    mkdir(joinpath(folder_structure_root_path,"daily_incidences_ratios_by_age"))
end

# English column names
const column_names_translations = Dict(
# overall_prevalences_by_region_sex_age    
"data" => "date", "tutti" => "all", "maschi" => "male", "femmine" => "female",
# daily_age_quantiles_by_status
"Column1" => "date", 
# daily_incidences_by_region_sex_age
"0-9 anni" => "0_9", "10-19 anni" => "10_19", "20-29 anni" => "20_29", "30-39 anni" => "30_39", "40-49 anni" => "40_49", "50-59 anni" => "50_59", "60-69 anni" => "60_69", "70-79 anni" => "70_79", "80-89 anni" => "80_89", "≥90 anni" => "90_+", 
# daily_incidences_by_province # daily_incidences_by_region
"casi" => "incidence", "casi_media7gg" => "incidence_7_days_moving_average",
# daily_incidences_healthcare_workers_by_region
"operatori sanitari" => "healthcare_workers", "altri" => "others",
# daily_incidences_over80_by_region 
"≥80 anni" => "80_+", 
# daily_incidences_ratios_by_age
"dt_RICOVERO" => "date", "ricoveri" => "hospitalizations", "deceduti" => "deceased", "fascia di età" => "age_class", "deceduti/ricoveri 35gg" => "deceased_/_hospitalizations_35_days_moving_average", "dt_PRELIEVO" => "date","positivi" => "confirmed", "deceduti/positivi 14gg" => "deceased_/_confirmed_14_days_moving_average", "dt_TERAPIAINTENSIVA" => "date", "terapia intensiva" => "intensive_care", "deceduti/terapia intensiva 42gg" => "deceased_/_intensive_care_42_days_moving_average", "ricoveri/positivi 14gg" => "hospitalizations_/_confirmed_14_days_moving_average", "terapia intensiva/positivi 14gg" => "intensive_care_/_confirmed_14_days_moving_average", "terapia intensiva/ricoveri 35gg" => "intensive_care_/_hospitalizations_35_days_moving_average", "sintomatici/positivi 14gg" => "symptomatics_/_confirmed_14_days_moving_average",
# daily_incidences_ratios_by_region
"terapia intensiva/ricoveri 7gg" => "intensive_care_/_hospitalizations_7_days_moving_average", "deceduti/ricoveri 7gg" => "deceased_/_hospitalizations_7_days_moving_average","ricoveri/positivi 7gg" => "hospitalizations_/_confirmed_7_days_moving_average",
# daily_incidences_percentages_by_age
"0-39 anni" => "0_39", "40-59 anni" => "40_59", "60-79 anni" => "60_79",
# daily_incidences_percentages_by_region_outcome
"ospedalizzati" => "hospitalized",
# daily_Rt_by_region_province_status
"rt_positivi" => "Rt_confirmed", "rt_positivi_err68perc" => "Rt_confirmed_err68perc", "rt_sintomatici" => "Rt_symptomatic", "rt_sintomatici_err68perc" => "Rt_symptomatic_err68perc",
# hospital_length_of_stay_distribution_deceased_by_region
"giorni" => "days",
# relative_overall_prevalences_distributed_by_sex_age
"età" => "age",
# temporal_distribution_of_time_delay_from_hospitalization_to_death
"DATADECESSO" => "date")

# English age classes
const age_classes_translations = Dict("0-9 anni" => "0_9", "10-19 anni" => "10_19", "20-29 anni" => "20_29", "30-39 anni" => "30_39", "40-49 anni" => "40_49", "50-59 anni" => "50_59", "60-69 anni" => "60_69", "70-79 anni" => "70_79", "80-89 anni" => "80_89", "≥90 anni" => "90_+")

# Fill folder sructure with files from ./archive.
## Get all file names
const archive_folder = "./0_archive"
matches = Int64[]
for csv_path in readdir(archive_folder; join = true)
    # Count number of matches
    match = 0
    csv_name =  string(split(csv_path, os_separator)[end])
    # Initialize translated name
    translated_name = deepcopy(csv_name)
    for translation in translations
        translated_name = replace(translated_name, translation)
    end
    println("csv_name = $csv_name \t translated_name = $translated_name")

    df = CSV.read(csv_path, DataFrame)

    # Translate column to english
    for col in names(df)
        if col  in keys(column_names_translations)
            rename!(df,Dict( col => column_names_translations[col] ))
        end
    end

    # If there is the "fascia d'età" ("age_class") column in the dataframe, translate its elements to english
    if "age_class" in names(df)
        df.age_class = [age_classes_translations[ita_age_class] for ita_age_class in df.age_class]
    end

    # Deal with excepional cases later
    for regular_infix in regular_infixes
        # If infix occurs in the name of csv, then copy it to the corresponnding folder
        if all(occursin.(regular_infix,Ref(csv_name)))
            CSV.write(joinpath(folder_structure_root_path, regular_infix_folderName_associations_en[regular_infix], translated_name ), df )
            match += 1
            break
        end


    end

    # Exceptional case: "bydate". csvs with infix may have regional stratification or provice stratification with rolling mean
    if occursin("_bydate",csv_name) && any(occursin.(regions_italy_names,Ref(csv_name)))
        CSV.write(joinpath(folder_structure_root_path, "daily_incidences_by_region", translated_name ), df )
        match += 1
    elseif occursin("_bydate",csv_name) && !any(occursin.(regions_italy_names,Ref(csv_name)))
        CSV.write(joinpath(folder_structure_root_path, "daily_incidences_by_province", translated_name ), df )
        match += 1
    end

    # Exceptional case "byage": the infix may be "byage" or a both "byage" and "byage","istat"
    if all(occursin.(["_byage","_istat"],Ref(csv_name)))
        CSV.write(joinpath(folder_structure_root_path, "relative_overall_prevalences_distributed_by_sex_age", translated_name ), df )
        match += 1
    elseif occursin("_byage",csv_name)
        CSV.write(joinpath(folder_structure_root_path, "overall_prevalences_by_region_sex_age", translated_name ), df )
        match += 1
    end

    # Exceptional case "ratio": the infix may be "ratio" or "ratio_age"
    if occursin("ratio",csv_name) && !occursin("ratio_age",csv_name)
        CSV.write(joinpath(folder_structure_root_path, "daily_incidences_ratios_by_region", translated_name ), df )
        match += 1
    elseif occursin("ratio_age",csv_name)
        CSV.write(joinpath(folder_structure_root_path, "daily_incidences_ratios_by_age", translated_name ), df )
        match += 1
    end

    push!(matches,match)
    #println("csv_name = $csv_name, match = $match")
end

#Check that each csv has been copied to one and only one folder
@assert all([match==1 for match in matches])

# Fill the input folder
## Copy regional rolling means
const input_daily_incidences_by_region_sex_age = joinpath(input_dir_path, regular_infix_folderName_associations_en[["_age_date"]])
cp(joinpath(folder_structure_root_path, regular_infix_folderName_associations_en[["_age_date"]]), input_daily_incidences_by_region_sex_age; force=true)
## Copy regional original series
const input_daily_incidences_by_region = joinpath(input_dir_path,"daily_incidences_by_region")
cp(joinpath(folder_structure_root_path, "daily_incidences_by_region"), input_daily_incidences_by_region; force=true)

# Delete the national input files ended in 2_input
const national_paths = filter(path -> occursin("italy",path), vcat(readdir(input_daily_incidences_by_region_sex_age; join = true ), readdir(input_daily_incidences_by_region; join = true ) ))
for path in national_paths
    rm(path)
end
