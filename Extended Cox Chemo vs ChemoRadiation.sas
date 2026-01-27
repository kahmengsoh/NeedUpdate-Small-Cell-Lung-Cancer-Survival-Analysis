libname mydata "C:/Users/ksoh/Desktop";

proc import datafile="C:/Users/ksoh/Desktop/data_version2_long.csv"
    out=long_data
    dbms=csv
    replace;
    guessingrows=max;
run;

data mydata.data_version2_long;
    set long_data;

    /* status = 1 ? death (event)
       status = 0 ? alive / censored */
    if Vital_Status = "Dead" then status = 1;
    else status = 0;
run;


proc phreg data=mydata.data_version2_long;
    class Treatment_Type(ref='chemo') Sex(ref='Female') Surgery(ref='Lobar');
    model (Start, Stop)*status(0) = Treatment_Type Age Sex Surgery/ ties=efron rl;
run;

/* At any given time t, among patients with the same age, sex, and surgery type, 
Chemoradiation has higher hazard rate than Chemotherapy (HR = 1.23). 
However, chemoradiation and chemotherapy is not statistically different. 95% CI 0.94–1.62, pvalue = 0.125,
Therefore there is no statistically significant evidence that chemoradiation improves survival compared with chemotherapy.
