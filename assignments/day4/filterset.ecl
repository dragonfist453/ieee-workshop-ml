
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
        
ds := DATASET('~workshop::house_prices_data.csv',dsrecord,CSV(HEADING(1)) );


getfiltered(DATASET(dsrecord) d,unsigned minbedrooms,unsigned minbathrooms) := FUNCTION
	return d(bedrooms>minbedrooms and bathrooms>minbathrooms);
END;


//This action must be present to get HPCC Systems to execute
//as actions are what cause HPCC Systems to use the definitions to make a result
OUTPUT( getfiltered(ds,4,5) ,NAMED('myfilter')  );