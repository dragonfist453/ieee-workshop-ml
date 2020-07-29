dsrecord := RECORD
    UNSIGNED age;
    UNSIGNED sex;
    UNSIGNED cp;
    UNSIGNED trestbps;
    UNSIGNED chol;
    UNSIGNED fbs;
    UNSIGNED restecg;
    UNSIGNED thalach;
    UNSIGNED exang;
    UNSIGNED oldpeak;
    UNSIGNED slope;
    UNSIGNED ca;
    UNSIGNED thal;
    UNSIGNED target;
END;

Ds := DATASET('~workshop::heart_failure.csv',
                dsrecord,
                CSV(HEADING(1),
                    SEPARATOR(','),
                    TERMINATOR(['\n','\r\n','\n\r'])));

Ds;                    