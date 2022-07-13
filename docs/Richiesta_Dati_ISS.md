# Richiesta Dati di Sorveglianza COVID-19 ISS 
## Contenuti

| Sezione                       | Sommario                                                     |
| ----------------------------- | ------------------------------------------------------------ |
| [1. Incidenze](#1.-Incidenze) | Descrive la richiesta di un dataset contenente incidenze giornaliere di casi confermati, casi sintomatici, ammissioni ospedaliere ordinarie, ammissioni ospedaliere intensive e decessi ulteriormente stratificati per status vaccinale, variante genetica e prodotto vaccinale (oltre alla disaggregazione per sesso, età e regione attualmente disponibile). |
| [2. Referenze](#2.-Referenze) | Contiene risorse utili a contestualizzare le richieste.      |

## 1. Incidenze 

Si considerino i dati di incidenza disponibili su [CovidStat](https://covid19.infn.it/iss/) elaborati a partire dal dataset individuale anonimizzato fornito dall'Istituto Superiore di Sanità: 

* Serie temporali in media mobile settimanale di **casi sintomatici per data di inizio sintomi** disaggregati per regione, sesso ed età;
* Serie temporali in media mobile settimanale di **casi confermati per data di diagnosi** disaggregati per regione, sesso ed età;
* Serie temporali in media mobile settimanale di **ammisioni ordinarie per data di ammissione** disaggregati per regione, sesso ed età;
* Serie temporali in media mobile settimanale di **ammisioni intensive per data di ammissione** disaggregati per regione, sesso ed età;
* Serie temporali in media mobile settimanale di **casi deceduti per data di decesso** disaggregati per regione, sesso ed età.

La nostra richiesta consiste nell'ulteriore stratificazione delle incidenze riportate sopra rispetto alle seguenti variabili di interesse. 

### Status vaccinale

* `0_positività_0_dosi`: casi a cui è stata diagnosticata COVID-19 `0` volte e sono state somministrate `0` dosi da almeno 14 giorni dalla data di evento notevole (i.e. `inizio_sintomi`, `diagnosi`, `ammissione_ordinaria`, `ammissione_intensiva`, `decesso`); 
* `0_positività_1_dosi`: casi a cui è stata diagnosticata COVID-19 `0` volte ed è stata somministrata `1` dose da almeno 14 giorni dalla data di evento notevole (i.e. `inizio_sintomi`, `diagnosi`, `ammissione_ordinaria`, `ammissione_intensiva`, `decesso`); 
* `0_positività_2_dosi`: casi a cui è stata diagnosticata COVID-19 `0` volte e sono state somministrate `2` dosi da almeno 14 giorni dalla data di evento notevole (i.e. `inizio_sintomi`, `diagnosi`, `ammissione_ordinaria`, `ammissione_intensiva`, `decesso`); 
* `0_positività_3_dosi`: casi a cui è stata diagnosticata COVID-19 `0` volte e sono state somministrate `3` dosi da almeno 14 giorni dalla data di evento notevole (i.e. `inizio_sintomi`, `diagnosi`, `ammissione_ordinaria`, `ammissione_intensiva`, `decesso`); 
* `0_positività_4_dosi`: casi a cui è stata diagnosticata COVID-19 `0` volte e sono state somministrate `4` dosi da almeno 14 giorni dalla data di evento notevole (i.e. `inizio_sintomi`, `diagnosi`, `ammissione_ordinaria`, `ammissione_intensiva`, `decesso`); 
* `1_positività_0_dosi`: casi a cui è stata diagnosticata COVID-19 `1` volta e sono state somministrate `0` dosi da almeno 14 giorni dalla data di evento notevole (i.e. `inizio_sintomi`, `diagnosi`, `ammissione_ordinaria`, `ammissione_intensiva`, `decesso`); 
* `1_positività_1_dosi`: casi a cui è stata diagnosticata COVID-19 `1` volta ed è stata somministrata  `1` dose da almeno 14 giorni dalla data di evento notevole (i.e. `inizio_sintomi`, `diagnosi`, `ammissione_ordinaria`, `ammissione_intensiva`, `decesso`); 
* `1_positività_2_dosi`: casi a cui è stata diagnosticata COVID-19 `1` volta e sono state somministrate `2` dosi da almeno 14 giorni dalla data di evento notevole (i.e. `inizio_sintomi`, `diagnosi`, `ammissione_ordinaria`, `ammissione_intensiva`, `decesso`); 
* `1_positività_3_dosi`: casi a cui è stata diagnosticata COVID-19 `1` volta e sono state somministrate `3` dosi da almeno 14 giorni dalla data di evento notevole (i.e. `inizio_sintomi`, `diagnosi`, `ammissione_ordinaria`, `ammissione_intensiva`, `decesso`);
* `1_positività_4_dosi`: casi a cui è stata diagnosticata COVID-19 `1` volta e sono state somministrate `4` dosi da almeno 14 giorni dalla data di evento notevole (i.e. `inizio_sintomi`, `diagnosi`, `ammissione_ordinaria`, `ammissione_intensiva`, `decesso`).

### Variante genetica 

* `B.1.1.7`: casi genotipizzati appartenenti al lignaggio B.1.1.7 (**Alpha**); 
* `B.1.1.7 + E484K`: casi genotipizzati appartenenti al lignaggio B.1.1.7 + E484K (**Alpha**); 
* `B.1.351`: casi genotipizzati appartenenti al lignaggio B.1.351 (**Beta**); 
* `P.1`: casi genotipizzati appartenenti al lignaggio P.1 (**Gamma**); 
* `B.1.617.2`: casi genotipizzati appartenenti al lignaggio B.1.617.2 (**Delta**); 
* `B.1.1.529`: casi genotipizzati appartenenti al lignaggio B.1.1.529 (**Omicron**); 
* `B.1.525`: casi genotipizzati appartenenti al lignaggio B.1.525 (**Non disponibile**); 
* `B.1.617.1`: casi genotipizzati appartenenti al lignaggio B.1.617.1 (**Non disponibile**); 
* `B.1.617.3`: casi genotipizzati appartenenti al lignaggio B.1.617.3 (**Non disponibile**); 
* `P.2`: casi genotipizzati appartenenti al lignaggio P.2 (**Non disponibile**); 
* `Altro lignaggio / non indicato`: casi genotipizzati appartenenti ad altro lignaggio oppure ad un lignaggio non indicato dalle Regioni/PA.

### Prodotto vaccinale

* `Comirnaty`: casi vaccinati la cui prima, seconda o terza dose somministrata è stata prodotta da BioNTech/Pfizer; 
* `Spikevax`: casi vaccinati la cui prima, seconda o terza dose somministrata è stata prodotta da Moderna; 
* `Vaxzevria`: casi vaccinati la cui prima, seconda o terza dose somministrata è stata prodotta da AstraZeneca; 
* `Janssen`: casi vaccinati la cui prima, seconda o terza dose somministrata è stata prodotta da Janssen Biotech; 

### Dataset richiesto 

Pertanto, qualora la nostra richiesta venisse accettata, le incidenze che risulterebbero pubblicamente disponibili al serivizio della comunità scientifica nazionale e internazionale sarebbero i seguenti: 

* Incidenze giornaliere di **casi sintomatici, casi confermati, ammissioni ordinarie, ammissioni intensive e decessi** stratificati per regione, sesso ed età (come già disponibili su [CovidStat](https://covid19.infn.it/iss/)) ulteriormente disaggregati per status vaccinale, prodotto vaccinale;
* Incidenze giornaliere di **casi genotipizzati sintomatici, casi confermati, ammissioni ordinarie, ammissioni intensive e decessi** stratificati per regione, sesso ed età ulteriormente disaggregati per status vaccinale, prodotto vaccinale e variante genetica.

### Motivazione

La pubblicazione di dati di sorveglianza epidemiologica ad alta risoluzione e stratificazione come quelli richiesti qui porterebbe un notevole valore epistemico aggiunto permettendo, ad esempio, a ricercatori nazionali ed internazionali di condurre:

* più robuste analisi di scenario (si veda https://covid19scenariomodelinghub.org per gli USA);
* più accurate analisi previsionali (si veda https://covid19forecasthub.eu per EU/EEA e https://covid19forecasthub.org per USA).

### Algoritmo di aggregazione 

Se (e solo se) la nostra richiesta non potesse venire completamente soddisfatta, proponiamo l'applicazione del seguente algoritmo iterativo di aggregazione: 

1. Produrre: 

   * Incidenze giornaliere di casi sintomatici, casi confermati, ammissioni ordinarie, ammissioni intensive e decessi stratificati per regione, sesso ed età (come già disponibili su [CovidStat](https://covid19.infn.it/iss/)) ulteriormente disaggregati per **status vaccinale, prodotto vaccinale**;
   * Incidenze giornaliere di casi genotipizzati sintomatici, casi confermati, ammissioni ordinarie, ammissioni intensive e decessi stratificati per regione, sesso ed età ulteriormente disaggregati per **status vaccinale, prodotto vaccinale e variante genetica**.

   In seguito valutare se sia pubblicabile (anche in forma aggregata mediante media mobile settimanale come su [CovidStat](https://covid19.infn.it/iss/)). Se sì, non considerare i prossimi punti, altrimenti passare al punto 2.; 

2. Produrre: 

   * Incidenze giornaliere di casi sintomatici, casi confermati, ammissioni ordinarie, ammissioni intensive e decessi stratificati per regione, sesso ed età (come già disponibili su [CovidStat](https://covid19.infn.it/iss/)) ulteriormente disaggregati per **status vaccinale, prodotto vaccinale**;
   * Incidenze giornaliere di casi genotipizzati sintomatici, casi confermati, ammissioni ordinarie, ammissioni intensive e decessi stratificati per regione, sesso ed età ulteriormente disaggregati per **status vaccinale, prodotto vaccinale e variante genetica di preoccupazione**.

   In seguito valutare se sia pubblicabile (anche in forma aggregata mediante media mobile settimanale come su [CovidStat](https://covid19.infn.it/iss/)). Se sì, non considerare i prossimi punti, altrimenti passare al punto 3.; 

3. Produrre le incidenze giornaliere di casi sintomatici, casi confermati, ammissioni ordinarie, ammissioni intensive e decessi stratificati per regione, sesso ed età (come già disponibili su [CovidStat](https://covid19.infn.it/iss/)) ulteriormente disaggregati per **status vaccinale, prodotto vaccinale**.

   In seguito valutare se sia pubblicabile (anche in forma aggregata mediante media mobile settimanale come su [CovidStat](https://covid19.infn.it/iss/)). Se sì, non considerare i prossimi punti, altrimenti passare al punto 4.; 

4. Produrre le incidenze giornaliere di casi sintomatici, casi confermati, ammissioni ordinarie, ammissioni intensive e decessi stratificati per regione, sesso ed età (come già disponibili su [CovidStat](https://covid19.infn.it/iss/)) ulteriormente disaggregati per **status vaccinale**.

   In seguito valutare se sia pubblicabile (anche in forma aggregata mediante media mobile settimanale come su [CovidStat](https://covid19.infn.it/iss/)). 

## 2. Referenze

### Dati 

#### Sorveglianza integrata ISS 

* [Piattaforma Web della Sorveglianza Integrata dei casi di COVID-19](https://covid-19.iss.it): Piattaforma di sorveglianza integrata COVID-19 che è stata predisposta per raccogliere i dati epidemiologici sui casi positivi al SARSCoV-2 diagnosticati nei laboratori di riferimento regionale ([schema XML](https://covid-19.iss.it/XMLSchema/0.1/covid-19.xsd));
* [La sorveglianza integrata Covid-19 in Italia: output e attività correlate](https://doi.org/10.19191/EP20.5-6.S2.105): Articolo di ricerca di Del Manso et al. (2020) in cui viene descritto il sistema di sorveglianza integrato dell’epidemia di COVID-19 in Italia;
* [maxdevblock/covid_iss_vaccini_reports](https://github.com/maxdevblock/covid_iss_vaccini_reports): Repository GitHub contenente i dati dei rapporti ISS su campagna vaccinale COVID-19; 
* [InPhyT/COVID19-Italy-Integrated-Surveillance-Data](https://github.com/InPhyT/COVID19-Italy-Integrated-Surveillance-Data): Repository GitHub contenente i dati di sorveglianza integrata COVID-19 forniti dall'Istituto Superiore di Sanità ed elaborati tramite [UnrollingAverages.jl](https://github.com/InPhyT/UnrollingAverages.jl) per deconvolvere le medie mobili settimanali.

#### Sorveglianza per status vaccinale in altri paesi

| Location         | Source                                | Data available by vaccination status                         |
| ---------------- | ------------------------------------- | ------------------------------------------------------------ |
| Australia        | New South Wales Government            | [Cases in New South Wales](https://www.health.nsw.gov.au/Infectious/covid-19/Pages/weekly-reports.aspx) |
| Chile            | Ministry of Health                    | [Cases + ICU admissions + deaths, by age group](https://github.com/MinCiencia/Datos-COVID19/tree/master/output/producto89) |
| England          | Office for National Statistics        | [Deaths by age group](https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/deathsbyvaccinationstatusengland) |
| Finland          | Department of Health and Welfare      | [Hospitalizations, by age group](https://thl.fi/fi/web/infektiotaudit-ja-rokotukset/ajankohtaista/ajankohtaista-koronaviruksesta-covid-19/tilannekatsaus-koronaviruksesta/koronaviruksen-seuranta) |
| France           | Ministry of Solidarity and Health     | [Cases + hospital & ICU admissions + deaths, national level](https://data.drees.solidarites-sante.gouv.fr/explore/dataset/covid-19-resultats-issus-des-appariements-entre-si-vic-si-dep-et-vac-si/information/?disjunctive.vac_statut) [Cases + hospital & ICU admissions, regional level](https://data.drees.solidarites-sante.gouv.fr/explore/dataset/covid-19-resultats-par-age-issus-des-appariements-entre-si-vic-si-dep-et-vac-si/information/) |
| Germany          | Robert Koch Institute                 | [Hospitalizations + deaths](https://www.rki.de/DE/Content/InfAZ/N/Neuartiges_Coronavirus/Daten/Inzidenz_Impfstatus.html) |
| Liechtenstein    | Federal Office of Public Health       | [Hospitalizations + deaths, by vaccine type](https://www.covid19.admin.ch/en/vaccination/status?devViewTotal=areas&vaccStatusDevRel=inz100) |
| Malaysia         | Ministry of Health                    | [Cases](https://covidnow.moh.gov.my/cases), [deaths](https://covidnow.moh.gov.my/deaths) |
| Northern Ireland | Department of Health                  | [Hospitalizations + deaths](https://www.health-ni.gov.uk/articles/covid-19-vaccination-status) |
| Singapore        | Ministry of Health                    | [ICU admissions, by age](https://data.gov.sg/dataset/covid-19-case-numbers?resource_id=60c679fc-8c3c-49dc-beaf-95008619d5df) [Deaths, by age](https://data.gov.sg/dataset/covid-19-case-numbers?resource_id=3c6c43ca-9703-48e4-a288-0d2d24a1946a) |
| Slovenia         | Government of Slovenia, via Sledilnik | [Cases, hospital & ICU admissions](https://covid-19.sledilnik.org/en/stats#vaccine-effect-chart) |
| Spain            | Ministry of Health                    | [Cases + hospitalizations + deaths, by age group](https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov/situacionActual.htm) |
| Switzerland      | Federal Office of Public Health       | [Hospitalizations + deaths, by vaccine type](https://www.covid19.admin.ch/en/vaccination/status?devViewTotal=areas&vaccStatusDevRel=inz100) |
| United States    | US CDC                                | [Cases + deaths, by age group](https://data.cdc.gov/Public-Health-Surveillance/Rates-of-COVID-19-Cases-or-Deaths-by-Age-Group-and/3rge-nu2a/data) |

#### Vaccini 

* [italia/covid19-opendata-vaccini](https://github.com/italia/covid19-opendata-vaccini): Repository GitHub contenente i dati su consegna e somministrazione dei vaccini anti COVID-19 in Italia. 

#### Privacy

* [Regole deontologiche per trattamenti a fini statistici o di ricerca scientifica](https://www.garanteprivacy.it/home/docweb/-/docweb-display/docweb/9069637);
* [Accordo tra ISS e Accademia dei Lincei](https://www.lincei.it/sites/default/files/documenti/Articles/Accordo_ISS_LINCEI_COVID19.pdf);
* [OCDPC n. 640 del 27 febbraio 2020](https://www.protezionecivile.gov.it/it/normativa/ocdpc-n--640-del-27-febbraio-2020--ulteriori-interventi-urgenti-di-protezione-civile-in-relazione-all-emergenza-relativa-al-rischio-sanitario-connesso);
* [OCDPC n. 691 del 4 agosto 2020](https://www.protezionecivile.gov.it/it/normativa/ocdpc-n--691-del-4-agosto-2020---ulteriori-interventi-urgenti-di-protezione-civile-in-relazione-all-emergenza-relativa-al-rischio-sanitario-connesso-a);
* [Informazioni privacy per la sorveglianza sanitaria integrata COVID-19](https://www.epicentro.iss.it/coronavirus/pdf/informazioni-privacy-iss-sorveglianza-integrata-covid-19.pdf).

#### Possibili Applicazioni 

* [US COVID-19 Scenario Modeling Hub](https://covid19scenariomodelinghub.org)
* [US COVID-19 Forecast Modeling Hub](https://covid19forecasthub.org )
* [European Covid-19 Forecast Hub](https://covid19forecasthub.eu)
* [German and Polish COVID-19 Forecast Hub](https://kitmetricslab.github.io/forecasthub/forecast)
* [German Hospitalization Nowcast Hub](https://covid19nowcasthub.de)
