dsrecord := RECORD
    UNSIGNED Age;
    INTEGER EstimatedSalary;
    INTEGER purchased;
END;

Ds := DATASET('~workshop::social_network_ads.csv',
                dsrecord,
                CSV(HEADING(1),
                    SEPARATOR(','),
                    TERMINATOR(['\n','\r\n','\n\r'])));

Ds;                    