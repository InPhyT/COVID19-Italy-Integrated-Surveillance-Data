<h1 align="center">
  Dati Sorveglianza Integrata COVID-19 in Italia 
</h1> 

[![language-italian](https://img.shields.io/badge/Language-english-red.svg)](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/README.md) [![language-italian](https://img.shields.io/badge/Language-italian-blue.svg)](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/README-ITA.md) [![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.5748141.svg)](https://doi.org/10.5281/zenodo.5748141)

Ogni settimana l'Istituto Nazionale di Fisica Nucleare ([INFN](https://home.infn.it/it/)) importa un dataset anonimo a livello individuale dall'Istituto Superiore di Sanità ([ISS](https://www.iss.it)) e lo converte in serie temporali di incidenza organizzate per data di evento e disaggregate per sesso, età e livello amministrativo con un periodo di consolidamento di circa due settimane. L'informazione disponibile all'[INFN](https://home.infn.it/it/) è riassunta nella seguente [meta-tabella](https://covid19.infn.it/iss/campi-iss.pdf):

| Nome variabile                | Descrizione                                                  | Codice / Formato                               | Mancante |
| ----------------------------- | ------------------------------------------------------------ | ---------------------------------------------- | -------- |
| `REGIONEDIAGNOSI`             | Regione di diagnosi                                          | Codice regionale ISTAT                         | No       |
| `ETA`                         | Età del paziente in anni alla data di inizio dei sintomi o della diagnosi |                                                | Sì       |
| `SESSO`                       | Sesso                                                        | `F`= femmina; `M` = maschio; `U` = sconosciuto | No       |
| `NAZIONALITA`                 | Nazionalità                                                  | ISO3166-1                                      | Sì       |
| `PROVINCIADOMICILIORESIDENZA` | Provincia di domicilio o di residenza se mancante            | Codice provinciale ISTAT                       | Sì       |
| `OPERATORESANITARIO`          | Operatore sanitario                                          | `Y` = sì; `N` = no; `U` = sconosciuto          | No       |
| `DATAPRELIEVO`                | Data prelievo del tampone                                    | gg/mm/aaaa                                     | Sì       |
| `DATADIAGNOSI`                | Data della diagnosi                                          | gg/mm/aaaa                                     | Sì       |
| `SINTOMATICO`                 | Presenza di sintomi                                          | `Y` = sì; `N` = no; `U` = sconosciuto          | No       |
| `DATAINIZIOSINTOMI`           | Data di inizio sintomi                                       | gg/mm/aaaa                                     | Sì       |
| `RICOVERO`                    | Ricovero                                                     | `Y` = sì; `N` = no; `U` = sconosciuto          | No       |
| `DATARICOVERO`                | Data di ricovero                                             | gg/mm/aaaa                                     | Sì       |
| `TERAPIAINTENSIVA`            | Terapia intensiva                                            | `Y` = sì; `N` = no; `U` = sconosciuto          | No       |
| `DATATERAPIAINTENSIVA`        | Data di ricovero in terapia intensiva                        | gg/mm/aaaa                                     | Sì       |
| `DECEDUTO`                    | Deceduto con Covid-19                                        | `Y` = sì; `N` = no; `U` = sconosciuto          | No       |
| `DATADECESSO`                 | Data del decesso                                             | gg/mm/aaaa                                     | Sì       |
| `CASOIMPORTATO`               | Caso importato da estero                                     | `Y` = sì; `N` = no; `U` = sconosciuto          | No       |

## Dati 

### Archivio

I [dati](https://covid19.infn.it/iss/) originali sono stati archiviati [qui](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/0_archive), riorganizzati [qui](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive) e i relativi contenuti sono riassunti nella seguente tabella:

| Collezione                                                   | Casi sintomatici | Casi confermati | Ammissioni ospedaliere ordinarie | Ammissioni ospedaliere intensive | Casi deceduti | Livello nazionale | Livello regionale | Livello provinciale | Stratificazione per età | Stratificazione per sesso | Serie temporale grezza | Serie temporale mediata |
| ------------------------------------------------------------ | :--------------: | :-------------: | :------------------------------: | :------------------------------: | :-----------: | :---------------: | :---------------: | :-----------------: | :---------------------: | :-----------------------: | :--------------------: | :---------------------: |
| [Incidenze giornaliere a livello nazionale e regionale](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/daily_incidences_by_region) |                  |        ✅        |                ✅                 |                ✅                 |       ✅       |         ✅         |         ✅         |                     |                         |                           |           ✅            |            ✅            |
| [Incidenze giornaliere a livello provinciale](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/daily_incidences_by_province) |                  |        ✅        |                ✅                 |                ✅                 |       ✅       |                   |                   |          ✅          |                         |                           |           ✅            |            ✅            |
| [incidenze giornaliere di operatori sanitari](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/daily_incidences_healthcare_workers_by_region) |        ✅         |                 |                ✅                 |                ✅                 |               |         ✅         |         ✅         |                     |                         |                           |           ✅            |                         |
| [Incidenze giornaliere di over-80](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/daily_incidences_over80_by_region) |        ✅         |                 |                ✅                 |                ✅                 |       ✅       |         ✅         |         ✅         |                     |                         |                           |           ✅            |                         |
| [Incidenze giornaliere stratificate per sesso ed età](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/daily_incidences_by_region_sex_age) |        ✅         |        ✅        |                ✅                 |                ✅                 |       ✅       |         ✅         |         ✅         |                     |            ✅            |             ✅             |                        |            ✅            |
| [Tassi di incidenze giornaliere](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/daily_incidences_ratios_by_region) |                  |                 |                                  |                                  |               |                   |                   |                     |            ✅            |                           |                        |            ✅            |
| [Rₜ giornaliero](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/daily_Rt_by_region_province_status) |                  |                 |                                  |                                  |               |         ✅         |         ✅         |          ✅          |                         |                           |           ✅            |                         |
| [Prevalenze assolute sull'intero periodo](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/overall_prevalences_by_region_sex_age) |                  |        ✅        |                ✅                 |                ✅                 |       ✅       |         ✅         |         ✅         |                     |                         |                           |                        |                         |
| [Prevalenze relative sull'intero periodo](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/relative_overall_prevalences_distributed_by_sex_age) |                  |        ✅        |                ✅                 |                ✅                 |       ✅       |         ✅         |                   |                     |            ✅            |             ✅             |                        |                         |
| [Distribuzione d'età giornaliera](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/daily_age_quantiles_by_status) |        ✅         |        ✅        |                ✅                 |                ✅                 |       ✅       |         ✅         |                   |                     |            ✅            |                           |                        |            ✅            |
| [Tassi percentuali di incidenze giornaliere](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/daily_incidences_percentages_by_age) |        ✅         |        ✅        |                ✅                 |                ✅                 |       ✅       |         ✅         |                   |                     |                         |                           |           ✅            |                         |
| [Tassi percentuali di incidenze giornaliere per esito finale](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/daily_incidences_percentages_by_region_outcome) |                  |                 |                ✅                 |                ✅                 |       ✅       |         ✅         |         ✅         |                     |                         |                           |           ✅            |                         |
| [Distribuzione del periodo dall'ospedalizzazione al decesso](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/hospital_length_of_stay_distribution_deceased_by_region) |                  |                 |                                  |                                  |               |         ✅         |         ✅         |                     |                         |                           |                        |                         |
| [Distribuzione temporale del periodo dall'ospedalizzazione al decesso](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive/temporal_distribution_of_time_delay_from_hospitalization_to_death) |                  |                 |                                  |                                  |               |         ✅         |                   |                     |                         |                           |                        |                         |

### Input

I dati di input sono stati archiviati [qui](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/2_input/daily_incidences_by_region_sex_age) e contengono le seguenti informazioni: 

* Dati aggregati nella cartella [`daily_incidences_by_region`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/2_input/daily_incidences_by_region):
  * Serie temporali giornaliere e in media mobile settimanale di **casi confermati per data di inizio sintomi** a livello regionale;
  * Serie temporali giornaliere e in media mobile settimanale di **ammisioni ordinarie per data di ammissione** a livello regionale;
  * Serie temporali giornaliere e in media mobile settimanale di **ammisioni intensive per data di ammissione** a livello regionale;
  * Serie temporali giornaliere e in media mobile settimanale di **casi deceduti per data di decesso** a livello regionale.
* Dati disaggregati nella cartella [`daily_incidences_by_region_sex_age`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/2_input/daily_incidences_by_region_sex_age):
  * Serie temporali in media mobile settimanale di **casi sintomatici per data di inizio sintomi** stratificati per sesso ed età a livello regionale;
  * Serie temporali in media mobile settimanale di **casi confermati per data di diagnosi** stratificati per sesso ed età a livello regionale;
  * Serie temporali in media mobile settimanale di **ammisioni ordinarie per data di ammissione** stratificati per sesso ed età a livello regionale;
  * Serie temporali in media mobile settimanale di **ammisioni intensive per data di ammissione** stratificati per sesso ed età a livello regionale;
  * Serie temporali in media mobile settimanale di **casi deceduti per data di decesso** stratificati per sesso ed età a livello regionale.

### Output 

I dati di output sono stati archiviati [qui](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/3_output/data) e contengono le seguenti informazioni: 

* Serie temporali giornaliere ricostruite di **casi confermati per data di diagnosi** stratificati per sesso ed età a livello regionale;

![lazio-confermati](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/blob/main/3_output/figures/iss_age_date_lazio_confirmed.png)

* Serie temporali giornaliere ricostruite di **casi sintomatici per data di inizio sintomi** stratificati per sesso ed età a livello regionale;

![lazio-sintomatici](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/blob/main/3_output/figures/iss_age_date_lazio_symptomatic.png)

* Serie temporali giornaliere ricostruite di **ammissioni ospedaliere ordinarie per data di ammissione** stratificati per sesso ed età a livello regionale;

![lazio-ospedalizzati](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/blob/main/3_output/figures/iss_age_date_lazio_hospitalizations.png)

* Serie temporali giornaliere ricostruite di **ammissioni ospedaliere intensive per data di ammissione** stratificati per sesso ed età a livello regionale;

![lazio-icu](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/blob/main/3_output/figures/iss_age_date_lazio_intensive_care.png)

* Serie temporali giornaliere ricostruite di **casi deceduti per data di decesso** stratificati per sesso ed età a livello regionale.

![lazio-deceduti](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/blob/main/3_output/figures/iss_age_date_lazio_deceased.png)

## Metodologia

### Organizzazione Dati 

I dati grezzi sono scaricati dall'[INFN](https://covid19.infn.it/iss/) (download diretto [qui](https://covid19.infn.it/iss/csv_part/iss.tar.gz)), decompressi, archiviati nella cartella [`0_archive`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/0_archive) e poi organizzati nella cartella [`1_structured_archive`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive) mediante l'esecuzione dello script [data_organization.jl](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/blob/main/src/data_organization.jl). 

### Elaborazione Dati 

In generale, data una media mobile di una serie temporale, non è possibile recuperare la serie originale almeno che non siano noti *n* punti originali dove *n* è l'ampiezza della finestra adottata nella media mobile, ma dal momento che le serie di incidenza della sorveglianza epidemiologica sono composte strettamente da numeri naturali, possiamo sfruttare questa proprietà per arrivare ad un numero finito di potenziali serie originali, poi sfoltirle il più possibile, sperabilmente ad una unica che sarebbe la serie originale esattamente ricostruita.

L'intera procedura è effettuata mediante l'esecuzione dello script [main.jl](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/blob/main/src/main.jl) e i dettagli tecnici rilevanti si possono trovare nella documentazione del pacchetto [UnrollingAverages.jl](https://github.com/InPhyT/UnrollingAverages.jl). 

Le serie temporali mediate che devono essere **srotolate** (i.e. recuperate, ricostruite) sono quelle archiviate nella cartella [`2_input/daily_incidences_by_region_sex_age`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/2_input/daily_incidences_by_region_sex_age): sono organizzate in file in formato .csv, ognuno dei quali contenente le 10 serie specifiche per le classi d'età di una particolare incidenza in una particolare regione. Ogni dataset ha altri due datasets associati che sono ulteriormente stratificati per sesso.

Dal momento che minore sono i numeri coinvolti e meglio sembra performare UnrollingAverages.jl, abbiamo optato per ricostruire prima le serie stratificate per sesso ed aggregarle in seguito. Poiché non tutte le serie mediate stratificate per sesso ed età permettono ad UnrollingAverages.jl di trovare un'unica serie originale e poiché INFN non fornisce alcuna ulteriore informazione stratificata per sesso, abbiamo provato a ricostruire direttamente le serie aggregate per sesso per cui INFN fornisce informazioni addizionali nella forma di serie originali aggregate per età, che abbiamo utilizzato per selezionare la combinazione di serie disaggregate per età proposte da UnrollingAverages.jl che sommasse a quella aggregata per età. I datasets aggregati così utilizzati si trovano nella cartella [`2_input/daily_incidences_by_region`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/2_input/daily_incidences_by_region) folder. Ci riferiremo all'algoritmo di selezione appena descritto con **vincolo di consistenza sezionale**. 

Le serie temporali esattamente ricostruite sono poi salvate nella cartella [`3_output/data`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/3_output/data), mentre le visualizzazioni di quelle stratificate per età ed aggregate per sesso si trovano nella cartella [`3_output/figures`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/3_output/figures).

### Limitazioni 

Attualmente il dataset in output non presenta limitazioni. Aggiorneremo questa sezione nel caso se ne manifestassero.

### Sviluppi Futuri 

Il vincolo di consistenza sezionale potrebbe essere migliorato in uno dei seguenti modi: 

* Utilizzando cicli in modalità multi-threading, prendendo ispirazione da [questo post su Julia Discourse](https://discourse.julialang.org/t/multithreading-for-nested-loops/36002);
* Utilizzando [LoopVectorization.jl](https://github.com/JuliaSIMD/LoopVectorization.jl) nel ciclo for principale;
* Implementando un problema multi-obiettivo dove gli obiettivi sono le 10 medie mobili e where the objectives are the 10 moving averages e il vincolo di consistenza sezionale, per cui potremmo fare uso dell'implementazione del [Borg-MOEA](http://borgmoea.org/) di [BlackBoxOptim.jl](https://github.com/robertfeldt/BlackBoxOptim.jl) o un algoritmo di [Metaheuristics.jl](https://github.com/jmejia8/Metaheuristics.jl) .

## Come Contribuire

Se volete modificare o aggiungere qualche funzionalità siete pregati di aprire una [issue](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/issues). Alcune indicazioni si possono trovare nella sezione [Sviluppi Futuri](#Sviluppi-Futuri). 

## Come Citare

Se usate questi dati nel vostro lavoro siete pregati di citare questo repository usando i seguenti metadati: 

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

## Referenze 

### Dati 

Istituto Superiore di Sanità. [Dati Sorveglianza Integrata COVID-19 in Italia](https://covid19.infn.it/iss/). 

### Software 

1. Pietro Monticone, Claudio Moroni, UnrollingAverages.jl (2021) https://doi.org/10.5281/zenodo.5725301.
2. Tom Breloff, Plots.jl (2021) https://doi.org/10.5281/zenodo.5747251.

### Letteratura Scientifica

* Pearce et al. (2020) [Accurate Statistics on COVID-19 Are Essential for Policy Guidance and Decisions](https://ajph.aphapublications.org/doi/abs/10.2105/AJPH.2020.305708) *American Journal of Public Health*
* Del Manso et al. (2020) [COVID-19 integrated surveillance in Italy: outputs and related activities](https://doi.org/10.19191/EP20.5-6.S2.105). *Epidemiologia & Prevenzione*
* Sherratt et al. (2021) [Exploring surveillance data biases when estimating the reproduction number: with insights into subpopulation transmission of COVID-19 in England](http://doi.org/10.1098/rstb.2020.0283) *Philosophical Transactions of the Royal Society B*
* Starnini et al. (2021) [Impact of data accuracy on the evaluation of COVID-19 mitigation policies](https://www.doi.org/10.1017/dap.2021.25). *Data & Policy*, 3, E28. 
* Zhang et al. (2021) [Data science approaches to confronting the COVID-19 pandemic: a narrative review](https://doi.org/10.1098/rsta.2021.0127). *Philosophical Transactions of the Royal Society A*
* Vasiliauskaite et al. (2021) [On some fundamental challenges in monitoring epidemics](https://doi.org/10.1098/rsta.2021.0117). *Philosophical Transactions of the Royal Society A*
* Kozlov (2022) [NIH issues a seismic mandate: share data publicly](https://doi.org/10.1038/d41586-022-00402-1). *Nature News*
* Mathieu (2022) [Commit to transparent pandemic data — not fancy dashboards](https://doi.org/10.1038/d41586-022-00424-9). *Nature News*