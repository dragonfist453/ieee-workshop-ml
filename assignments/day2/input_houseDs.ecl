dsrecord := RECORD
    UNSIGNED bedrooms;
    REAL bathrooms;
    REAL sqft_living;
    REAL sqft_lot;
    UNSIGNED floors;
    UNSIGNED condition;
    UNSIGNED grade;
    REAL sqft_above;
    REAL sqft_basement;
    UNSIGNED yr_built;
    REAL sqft_living15;
    REAL sqft_lot15;
    REAL price;
END;

Ds := DATASET('~workshop::house_prices_data.csv',
                dsrecord,
                CSV(HEADING(1),
                    SEPARATOR(','),
                    TERMINATOR(['\n','\r\n','\n\r'])));

Ds;                    