<h1 align="center">
  COVID-19 Integrated Surveillance Data in Italy
</h1> 

[![language-italian](https://img.shields.io/badge/Language-italian-blue.svg)](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/README-ITA.md) [![language-english](https://img.shields.io/badge/Language-english-red.svg)](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/README.md) [![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.5748141.svg)](https://doi.org/10.5281/zenodo.5748141)

Every week the National Institute for Nuclear Physics ([INFN](https://home.infn.it/it/)) imports an anonymous individual-level dataset from the Italian National Institute of Health ([ISS](https://www.iss.it)) and converts it into an incidence time series data organized by date of event and disaggregated by sex, age and administrative level with a consolidation period of approximately two weeks. The information available to the [INFN](https://home.infn.it/it/) is summarised in the following [meta-table](https://covid19.infn.it/iss/campi-iss.pdf):

| Variable Name                 | Description                                                  | Code / Format                          | Missing |
| ----------------------------- | ------------------------------------------------------------ | -------------------------------------- | ------- |
| `REGIONEDIAGNOSI`             | Region of diagnosis                                          | ISTAT regional code                    | No      |
| `ETA`                         | Age of the patient in years at the date of symptoms onset or diagnosis |                                        | Yes     |
| `SESSO`                       | Sex                                                          | `F`= female; `M` = male; `U` = unknown | No      |
| `NAZIONALITA`                 | Nationality                                                  | ISO3166-1                              | Yes     |
| `PROVINCIADOMICILIORESIDENZA` | Province of domicile or residence if missing                 | ISTAT provincial code                  | Yes     |
| `OPERATORESANITARIO`          | Healthcare worker                                            | `Y` = yes; `N` = no; `U` = unknown     | No      |
| `DATAPRELIEVO`                | Date of sample collection                                    | dd/mm/yyyy                             | Yes     |
| `DATADIAGNOSI`                | Date of diagnosis                                            | dd/mm/yyyy                             | Yes     |
| `SINTOMATICO`                 | Presence of symptoms                                         | `Y` = yes; `N` = no; `U` = unknown     | No      |
| `DATAINIZIOSINTOMI`           | Date of symptoms onset                                       | dd/mm/yyyy                             | Yes     |
| `RICOVERO`                    | Hospitalization                                              | `Y` = yes; `N` = no; `U` = unknown     | No      |
| `DATARICOVERO`                | Date of admission to hospital                                | dd/mm/yyyy                             | Yes     |
| `TERAPIAINTENSIVA`            | Intensive care unit                                          | `Y` = yes; `N` = no; `U` = unknown     | No      |
| `DATATERAPIAINTENSIVA`        | Date of admission to intensive care unit                     | dd/mm/yyyy                             | Yes     |
| `DECEDUTO`                    | Deceased with COVID-19                                       | `Y` = yes; `N` = no; `U` = unknown     | No      |
| `DATADECESSO`                 | Date of death                                                | dd/mm/yyyy                             | Yes     |
| `CASOIMPORTATO`               | Imported case from abroad                                    | `Y` = yes; `N` = no; `U` = unknown     | No      |

## Data 

### Archive

The original [data](https://covid19.infn.it/iss/) has been stored [here](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/0_archive), reorganised [here](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive) and its contents are summarised in the following table: 

| Collection                                                   | Symptomatic cases | Confirmed cases | Ordinary hospital admissions | Intensive hospital admission | Deceased cases | National level | Regional level | Provincial level | Age stratification | Sex stratification | Raw  time series | Averaged time series |
| ------------------------------------------------------------ | :---------------: | :-------------: | :--------------------------: | :--------------------------: | :------------: | :------------: | :------------: | :--------------: | :----------------: | :----------------: | :--------------: | :------------------: |
| [Daily incidences at national and regional level](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/daily_incidences_by_region) |                   |        ✅        |              ✅               |              ✅               |       ✅        |       ✅        |       ✅        |                  |                    |                    |        ✅         |          ✅           |
| [Daily incidences at provincial level](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/daily_incidences_by_province) |                   |        ✅        |              ✅               |              ✅               |       ✅        |                |                |        ✅         |                    |                    |        ✅         |          ✅           |
| [Daily incidences of healthcare workers](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/daily_incidences_healthcare_workers_by_region) |         ✅         |                 |              ✅               |              ✅               |                |       ✅        |       ✅        |                  |                    |                    |        ✅         |                      |
| [Daily incidences of over-80](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/daily_incidences_over80_by_region) |         ✅         |                 |              ✅               |              ✅               |       ✅        |       ✅        |       ✅        |                  |                    |                    |        ✅         |                      |
| [Daily incidences by sex and age](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/daily_incidences_by_region_sex_age) |         ✅         |        ✅        |              ✅               |              ✅               |       ✅        |       ✅        |       ✅        |                  |         ✅          |         ✅          |                  |          ✅           |
| [Daily incidences ratios](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/daily_incidences_ratios_by_region) |                   |                 |                              |                              |                |                |                |                  |         ✅          |                    |                  |          ✅           |
| [Daily Rₜ](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/daily_Rt_by_region_province_status) |                   |                 |                              |                              |                |       ✅        |       ✅        |        ✅         |                    |                    |        ✅         |                      |
| [Absolute overall prevalences](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/overall_prevalences_by_region_sex_age) |                   |        ✅        |              ✅               |              ✅               |       ✅        |       ✅        |       ✅        |                  |                    |                    |                  |                      |
| [Relative overall prevalences](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/relative_overall_prevalences_distributed_by_sex_age) |                   |        ✅        |              ✅               |              ✅               |       ✅        |       ✅        |                |                  |         ✅          |         ✅          |                  |                      |
| [Daily age distribution](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/daily_age_quantiles_by_status) |         ✅         |        ✅        |              ✅               |              ✅               |       ✅        |       ✅        |                |                  |         ✅          |                    |                  |          ✅           |
| [Daily incidences percentages by age](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/daily_incidences_percentages_by_age) |         ✅         |        ✅        |              ✅               |              ✅               |       ✅        |       ✅        |                |                  |                    |                    |        ✅         |                      |
| [Daily incidences percentages by outcome](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/daily_incidences_percentages_by_region_outcome) |                   |                 |              ✅               |              ✅               |       ✅        |       ✅        |       ✅        |                  |                    |                    |        ✅         |                      |
| [Distribution of time delay from hospitalization to death](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/hospital_length_of_stay_distribution_deceased_by_region) |                   |                 |                              |                              |                |       ✅        |       ✅        |                  |                    |                    |                  |                      |
| [Temporal distribution of time delay from hospitalization to death](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/temporal_distribution_of_time_delay_from_hospitalization_to_death) |                   |                 |                              |                              |                |       ✅        |                |                  |                    |                    |                  |                      |

### Input 

The input data has been stored [here](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/2_input) and contain the following information:
- Aggregated data in the [`daily_incidences_by_region`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/2_input/daily_incidences_by_region) folder:
  * Weekly moving average and daily time series of **confirmed cases by date of diagnosis** at the regional level;
  * Weekly moving average and daily time series of **ordinary hospital admissions by date of admission** at the regional level;
  * Weekly moving average and daily time series of **intensive hospital admissions by date of admission** at regional level;
  * Weekly moving average and daily time series of **deceased cases by date of death** at the regional level.
- Disaggregated data in the [`daily_incidences_by_region_sex_age`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/2_input/daily_incidences_by_region_sex_age) folder:
  - Weekly moving average time series of **symptomatic cases by date of symptoms onset** stratified by sex and age at the regional level;
  - Weekly moving average time series of **confirmed cases by date of diagnosis** stratified by sex and age at the regional level;
  - Weekly moving average time series of **ordinary hospital admissions by date of admission** stratified by sex and age at the regional level;
  - Weekly moving average time series of **intensive hospital admissions by date of admission** stratified by sex and age at the regional level;
  - Weekly moving average time series of **deceased cases by date of death** stratified by sex and age at the regional level.
  

### Output 

The output data has been stored [here](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/3_output/data) and contain the following information:

* Reconstructed daily time series of **confirmed cases by date of diagnosis** stratified by sex and age at the regional level;

![lombardy-confirmed](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/blob/main/3_output/figures/iss_age_date_lombardy_confirmed.png)

* Reconstructed daily time series of **symptomatic cases by date of symptoms onset** stratified by sex and age at the regional level;

![lombardy-symptomatic](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/blob/main/3_output/figures/iss_age_date_lombardy_symptomatic.png)

* Reconstructed daily time series of **ordinary hospital admissions** by date of admission stratified by sex and age at the regional level;

![lombardy-hospitalized](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/blob/main/3_output/figures/iss_age_date_lombardy_hospitalizations.png)

* Reconstructed daily time series of **intensive hospital admissions** by date of admission stratified by sex and age at the regional level;

![lombardy-icu](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/blob/main/3_output/figures/iss_age_date_lombardy_intensive_care.png)

* Reconstructed daily time series of **deceased cases by date of death** stratified by sex and age at the regional level.

![lombardy-deceased](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/blob/main/3_output/figures/iss_age_date_lombardy_deceased.png)

## Methodology 

### Data Organization

Raw data are downloaded from the [INFN](https://covid19.infn.it/iss/) (direct download [here](https://covid19.infn.it/iss/csv_part/iss.tar.gz)), decompressed, stored in the [`0_archive`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/0_archive) folder and then organized into the  [`1_structured_archive`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive) folder via the execution of the [data_organization.jl](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/blob/main/src/data_organization.jl) script. 

### Data Processing 

In general, given the moving average (or rolling mean) of a time series, it's not possible to recover the original series unless *n* original points are known where *n* is the width of the window adopted in the moving average, but since epidemiological surveillance incidence series are strictly composed of natural numbers, we can leverage this property to come up with a finite number of candidate original series, and then prune these down to as little as possible, hopefully only one, final recovered series.

The whole procedure is performed via the execution of the [main.jl](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/blob/main/src/main.jl) script and the related technical details can be found the documentation of [UnrollingAverages.jl](https://github.com/InPhyT/UnrollingAverages.jl) package. 

The averaged time series to be **unrolled** (i.e. recovered, reconstructed or de-averaged) are those stored in the [`2_input/daily_incidences_by_region_sex_age`](https://github.com/COVID19-Italy-Integrated-Surveillance-Data/tree/main/2_input/daily_incidences_by_region_sex_age) folder: they are organized in .csv files, each of which reporting the 10 age-specific time series of a particular incidence in a particular region. Each dataset has two counterparts that are further stratified by sex.

Since the smaller the numbers involved the better UnrollingAverages.jl seems to perform, we opted for unrolling the sex-stratified series first and then aggregate them later. Since not all the age and sex stratified averaged series allows UnrollingAverages.jl to find an unique original series and no further sex-stratified information is provided by INFN, we attempted to directly unroll the sex-aggregated time series for which CovidStat provides additional information in the form of age-aggregated original time series, that we employed to select that combination of age-disaggregated series proposed by UnrollingAverages.jl which summed to the age-aggregated original time series provided by INFN. The utilized age and sex-aggregated may be found in the [`2_input/daily_incidences_by_region`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/2_input/daily_incidences_by_region) folder. We'll refer to the last selection algorithm as the **cross-sectional consistency constraint**. 

The successfully reconstructed time series are then saved in the [`3_output/data`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/3_output/data) folder (both aggregated and disaggregated by sex), while the visualisations of those that are age-stratified and sex-aggregated may be found in [`3_output/figures`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/3_output/figures).

### Future Developments

We may improve the cross-sectional consistency constraint in one of the following ways:

* By multi-threading its loop, drawing inspiration from [this Julia Discourse post](https://discourse.julialang.org/t/multithreading-for-nested-loops/36002);
* By using [LoopVectorization.jl](https://github.com/JuliaSIMD/LoopVectorization.jl) in the main loop;
* By implementing a multi-objective optimization problem, where the objectives are the 10 moving averages and the cross-sectional consistency constraint, for which we may use [BlackBoxOptim.jl](https://github.com/robertfeldt/BlackBoxOptim.jl)'s implementation of [Borg-MOEA](http://borgmoea.org/), or an algorithm from [Metaheuristics.jl](https://github.com/jmejia8/Metaheuristics.jl) .

## How to Contribute

If you wish to change or add some functionality, please file an [issue](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/issues). Some suggestions may be found in the [Future Developments](#Future-Developments) section.

## How to Cite 

If you use this data in your work, please cite this repository using the following metadata: 

```bib
@dataset{Monticone_Moroni_COVID-19_Integrated_Surveillance_Data_Italy_2021,
         abstract     = {COVID-19 integrated surveillance data provided by the Italian Institute of Health and processed via UnrollingAverages.jl to remove the weekly moving averages.},
         author       = {Monticone, Pietro and Moroni, Claudio},
         doi          = {10.5281/zenodo.5748142},
         institution  = {University of Turin (UniTO)},
         keywords     = {Data, Data Analysis, Statistics, Time Series, Time Series Analysis, Epidemiological Data, Surveillance, Surveillance Data, Incidence Data, Open Data, Epidemiology, Mathematical Epidemiology, Computational Epidemiology, COVID-19, SARS-CoV-2, Italy, COVID-19 Data, SARS-CoV-2 Data},
         license      = {CC BY-SA 4.0},
         organization = {Interdisciplinary Physics Team (InPhyT)},
         title        = {COVID-19 Integrated Surveillance Data in Italy},
         url          = {https://doi.org/10.5281/zenodo.5748142},
         year         = {2021}
         }
```

## References 

### Data 

Istituto Superiore di Sanità. [COVID-19 Integrated Surveillance Data in Italy](https://covid19.infn.it/iss/). 

### Software 

1. Pietro Monticone, Claudio Moroni, UnrollingAverages.jl (2021) https://doi.org/10.5281/zenodo.5725301.
2. Tom Breloff, Plots.jl (2021) https://doi.org/10.5281/zenodo.5747251.

### Scientific Literature 

* Polosky et al. (2019) [Outbreak analytics: a developing data science for informing the response to emerging pathogens](https://doi.org/10.1098/rstb.2018.0276). *Philosophical Transactions of the Royal Society B*
* Jackson et al. (2019) [Value of Information: Sensitivity Analysis and Research Design in Bayesian Evidence Synthesis](https://doi.org/10.1080/01621459.2018.1562932) *Journal of the American Statistical Association*
* Pearce et al. (2020) [Accurate Statistics on COVID-19 Are Essential for Policy Guidance and Decisions](https://ajph.aphapublications.org/doi/abs/10.2105/AJPH.2020.305708) *American Journal of Public Health*
* Del Manso et al. (2020) [COVID-19 integrated surveillance in Italy: outputs and related activities](https://doi.org/10.19191/EP20.5-6.S2.105). *Epidemiologia & Prevenzione*
* Sherratt et al. (2021) [Exploring surveillance data biases when estimating the reproduction number: with insights into subpopulation transmission of COVID-19 in England](http://doi.org/10.1098/rstb.2020.0283) *Philosophical Transactions of the Royal Society B*
* Starnini et al. (2021) [Impact of data accuracy on the evaluation of COVID-19 mitigation policies](https://www.doi.org/10.1017/dap.2021.25). *Data & Policy*, 3, E28. 
* Zhang et al. (2021) [Data science approaches to confronting the COVID-19 pandemic: a narrative review](https://doi.org/10.1098/rsta.2021.0127). *Philosophical Transactions of the Royal Society A*
* Vasiliauskaite et al. (2021) [On some fundamental challenges in monitoring epidemics](https://doi.org/10.1098/rsta.2021.0117). *Philosophical Transactions of the Royal Society A*
* Badker et al. (2021) [Challenges in reported COVID-19 data: best practices and recommendations for future epidemics](http://dx.doi.org/10.1136/bmjgh-2021-005542. *BMJ Global Health*
* Kozlov (2022) [NIH issues a seismic mandate: share data publicly](https://doi.org/10.1038/d41586-022-00402-1). *Nature News*
* Mathieu (2022) [Commit to transparent pandemic data — not fancy dashboards](https://doi.org/10.1038/d41586-022-00424-9). *Nature News*
* Pooley et al. (2022) [Estimation of age-stratified contact rates during the COVID-19 pandemic using a novel inference algorithm](https://doi.org/10.1101/2022.01.12.22269157). *medRxiv*
* Shadbolt et al. (2022) [The Challenges of Data in Future Pandemics](https://api.newton.ac.uk/website/v0/events/preprints/NI20013). *Isaac Newton Institute for Mathematical Science, IDP*