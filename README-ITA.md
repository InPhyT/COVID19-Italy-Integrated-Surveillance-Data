<h1 align="center">
  Dati Sorveglianza Integrata COVID-19 in Italia 
</h1> 

[![language-italian](https://img.shields.io/badge/Language-english-red.svg)](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/README.md) [![language-italian](https://img.shields.io/badge/Language-italian-blue.svg)](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/README-ITA.md) [![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)

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
| [Incidenze giornaliere a livello nazionale e regionale](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/daily_incidences_by_region) |                  |        ✅        |                ✅                 |                ✅                 |       ✅       |         ✅         |         ✅         |                     |                         |                           |           ✅            |            ✅            |
| [Incidenze giornaliere a livello provinciale](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/daily_incidences_by_province) |                  |        ✅        |                ✅                 |                ✅                 |       ✅       |                   |                   |          ✅          |                         |                           |           ✅            |            ✅            |
| [incidenze giornaliere di operatori sanitari](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/daily_incidences_healthcare_workers_by_region) |        ✅         |                 |                ✅                 |                ✅                 |               |         ✅         |         ✅         |                     |                         |                           |           ✅            |                         |
| [Incidenze giornaliere di over-80](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/daily_incidences_over80_by_region) |        ✅         |                 |                ✅                 |                ✅                 |       ✅       |         ✅         |         ✅         |                     |                         |                           |           ✅            |                         |
| [Incidenze giornaliere stratificate per sesso ed età](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/daily_incidences_by_region_sex_age) |        ✅         |        ✅        |                ✅                 |                ✅                 |       ✅       |         ✅         |         ✅         |                     |            ✅            |             ✅             |                        |            ✅            |
| [Tassi di incidenze giornaliere](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/daily_incidences_ratios_by_region) |                  |                 |                                  |                                  |               |                   |                   |                     |            ✅            |                           |                        |            ✅            |
| [Rₜ giornaliero](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/daily_Rt_by_region_province_status) |                  |                 |                                  |                                  |               |         ✅         |         ✅         |          ✅          |                         |                           |           ✅            |                         |
| [Prevalenze assolute sull'intero periodo](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/overall_prevalences_by_region_sex_age) |                  |        ✅        |                ✅                 |                ✅                 |       ✅       |         ✅         |         ✅         |                     |                         |                           |                        |                         |
| [Prevalenze relative sull'intero periodo](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/relative_overall_prevalences_distributed_by_sex_age) |                  |        ✅        |                ✅                 |                ✅                 |       ✅       |         ✅         |                   |                     |            ✅            |             ✅             |                        |                         |
| [Distribuzione d'età giornaliera](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/daily_age_quantiles_by_status) |        ✅         |        ✅        |                ✅                 |                ✅                 |       ✅       |         ✅         |                   |                     |            ✅            |                           |                        |            ✅            |
| [Tassi percentuali di incidenze giornaliere](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/daily_incidences_percentages_by_age) |        ✅         |        ✅        |                ✅                 |                ✅                 |       ✅       |         ✅         |                   |                     |                         |                           |           ✅            |                         |
| [Tassi percentuali di incidenze giornaliere per esito finale](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/daily_incidences_percentages_by_region_outcome) |                  |                 |                ✅                 |                ✅                 |       ✅       |         ✅         |         ✅         |                     |                         |                           |           ✅            |                         |
| [Distribuzione del periodo dall'ospedalizzazione al decesso](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/hospital_length_of_stay_distribution_deceased_by_region) |                  |                 |                                  |                                  |               |         ✅         |         ✅         |                     |                         |                           |                        |                         |
| [Distribuzione temporale del periodo dall'ospedalizzazione al decesso](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/temporal_distribution_of_time_delay_from_hospitalization_to_death) |                  |                 |                                  |                                  |               |         ✅         |                   |                     |                         |                           |                        |                         |

### Input

I dati di input sono stati archiviati [qui](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/2_input/daily_incidences_by_region_sex_age) e contengono le seguenti informazioni: 

* Dati aggregati nella cartella [`daily_incidences_by_region`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/2_input/daily_incidences_by_region):
  * Serie temporali giornaliere e in media mobile settimanale di **casi confermati per data di inizio sintomi** a livello regionale;
  * Serie temporali giornaliere e in media mobile settimanale di **ammisioni ordinarie per data di ammissione** a livello regionale;
  * Serie temporali giornaliere e in media mobile settimanale di **ammisioni intensive per data di ammissione** a livello regionale;
  * Serie temporali giornaliere e in media mobile settimanale di **casi deceduti per data di decesso** a livello regionale.
* Dati disaggregati nella cartella [`daily_incidences_by_region_sex_age`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/2_input/daily_incidences_by_region_sex_age):
  * Serie temporali in media mobile settimanale di **casi sintomatici per data di inizio sintomi** a livello regionale;
  * Serie temporali in media mobile settimanale di **casi confermati per data di diagnosi** a livello regionale;
  * Serie temporali in media mobile settimanale di **ammisioni ordinarie per data di ammissione** a livello regionale;
  * Serie temporali in media mobile settimanale di **ammisioni intensive per data di ammissione** a livello regionale;
  * Serie temporali in media mobile settimanale di **casi deceduti per data di decesso** a livello regionale.

### Ouput 

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

**NB**: Tutti i dati presenti in questo repository verranno aggiornati ogni qualvolta saranno aggiornati quelli forniti da INFN.

## Metodologia

### Organizzazione Dati 

I dati grezzi sono scaricati dall'[INFN](https://covid19.infn.it/iss/) (download diretto [qui](https://covid19.infn.it/iss/csv_part/iss.tar.gz)), decompressi, archiviati nella cartella [`0_archive`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/0_archive) e poi organizzati nella cartella [`1_structured_archive`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/1_structured_archive) mediante l'esecuzione dello script [data_organization.jl](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/blob/main/src/data_organization.jl). 

### Elaborazione Dati 

In generale, data una media mobile di una serie temporale, non è possibile recuperare la serie originale almeno che non siano noti *n* punti originali dove *n* è l'ampiezza della finestra adottata nella media mobile, ma dal momento che le serie di incidenza della sorveglianza epidemiologica sono composte strettamente da numeri naturali, possiamo sfruttare questa proprietà per arrivare ad un numero finito di potenziali serie originali, poi sfoltirle il più possibile, sperabilmente ad una unica che sarebbe la serie originale esattamente ricostruita.

L'intera procedura è effettuata mediante l'esecuzione dello script [main.jl](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/blob/main/src/main.jl) e i dettagli tecnici rilevanti si possono trovare nella documentazione del pacchetto [Unrolling.jl](). 

Le serie temporali mediate che devono essere **srotolate** (i.e. recuperate, ricostruite) sono quelle archiviate nella cartella [`2_input/daily_incidences_by_region_sex_age`](https://github.com/COVID19-Italy-Integrated-Surveillance-Data/tree/main/2_input/daily_incidences_by_region_sex_age): sono organizzate in file in formato .csv, ognuno dei quali contenente le 10 serie specifiche per le classi d'età di una particolare incidenza in una particolare regione. Ogni dataset ha altri due datasets associati che sono ulteriormente stratificati per sesso.

Dal momento che minore sono i numeri coinvolti e meglio sembra performare Unrolling.jl, abbiamo optato per ricostruire prima le serie stratificate per sesso ed aggregarle in seguito. Poiché non tutte le serie mediate stratificate per sesso ed età permettono ad Unrolling.jl di trovare un'unica serie originale e poiché INFN non fornisce alcuna ulteriore informazione stratificata per sesso, abbiamo provato a ricostruire direttamente le serie aggregate per sesso per cui INFN fornisce informazioni addizionali nella forma di serie originali aggregate per età, che abbiamo utilizzato per selezionare la combinazione di serie disaggregate per età proposte da Unrolling.jl che sommasse a quella aggregata per età. I datasets aggregati così utilizzati si trovano nella cartella [`2_input/daily_incidences_by_region`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/2_input/daily_incidences_by_region) folder. Ci riferiremo all'algoritmo di selezione appena descritto con **vincolo di consistenza sezionale**. 

Le serie temporali esattamente ricostruite sono poi salvate nella cartella [`3_output/data`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/3_output/data), mentre le visualizzazioni di quelle stratificate per età ed aggregate per sesso si trovano nella cartella [`3_output/figures`](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data/tree/main/3_output/figures).

### Limitazioni 

Le serie temporali mediate startificate per sesso che Unrolling.jl non è riuscito a restringere ad un unica serie originale sono le seguenti: 

* `iss_age_date_lombardy_positive_female`: serie temporali giornaliere di **casi femminili confermati per data di diagnosi** stratificate per età in Lombardia ;
* `iss_age_date_lombardy_positive_male`: serie temporali giornaliere di **casi maschili confermati per data di diagnosi** stratificate per età in Lombardia ;
* `iss_age_date_lombardy_symptomatic_female`: serie temporali giornaliere di **casi femminili sintomatici per data di inizio sintomi** stratificate per età in Lombardia ;
* `iss_age_date_lombardy_symptomatic_male`: serie temporali giornaliere di **casi maschili sintomatici per data di inizio sintomi** stratificate per età in Lombardia ;
* `iss_age_date_emilia_romagna_positive_female`: serie temporali giornaliere di **casi femminili confermati per data di diagnosi** stratificate per età in Emilia Romagna;
* `iss_age_date_emilia_romagna_positive_male`: serie temporali giornaliere di **casi maschili confermati per data di diagnosi** stratificate per età in Emilia Romagna .

Sfortunatamente, per tutti i datasets aggregati per sesso corrispondenti:

* `iss_age_date_lombardy_positive`;
* `iss_age_date_lombardy_symptomatic`;
* `iss_age_date_emilia_romagna_positive` 

il vincolo di consistenza sezionale al momento fallisce, dal momento che il numero di combinazioni selezionate da Unrolling.jl necessiterebbe di troppo tempo per essere effettivamente processate nonostante i numerosi miglioramenti di performance già implementati (e.g. si vedano i seguenti posts su Julia Discourse: [For loop optimization](https://discourse.julialang.org/t/for-loop-optimization/70700) and [How to improve performance in nested loops](https://discourse.julialang.org/t/how-to-improve-performance-in-nested-loops/70407)).

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
@dataset{COVID19-Italy-Integrated-Surveillance-Data,
	author   = {Pietro Monticone, Claudio Moroni},
	title    = {COVID-19 Integrated Surveillance Data in Italy},
	url      = {https://doi.org/},
	doi      = {}, 
	keywords = {Epidemiology, Surveillance, Data, Data Analysis, COVID-19},
	year     = {2021},
	month    = {11}
}
```

## Fonte Dati 

Istituto Superiore di Sanità. [COVID-19 Integrated Surveillance Data](https://covid19.infn.it/iss/). 

## Referenze Rilevanti

* Katharine et al. (2021) [Exploring surveillance data biases when estimating the reproduction number: with insights into subpopulation transmission of COVID-19 in England](http://doi.org/10.1098/rstb.2020.0283) *Phil. Trans. R. Soc. B*.
* Starnini, M., Aleta, A., Tizzoni, M., & Moreno, Y. (2021) [Impact of data accuracy on the evaluation of COVID-19 mitigation policies](https://www.doi.org/10.1017/dap.2021.25). *Data & Policy*, 3, E28. 
