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

ds1 := DATASET('~workshop::house_prices_data.csv',dsrecord,CSV(HEADING(1)));	
ds2 := DATASET([{1,2,3,4,5,6,7,8,9,10,11,12,13},{14,15,16,17,18,19,20,21,22,23,24,25,26}],dsrecord);


//a function that returns only those house info which have a given number of bedrooms
getroomwords(DATASET(dsrecord) dset,integer number_bedrooms) := FUNCTION
		part := dset(bedrooms=number_bedrooms);
		return part;
END;


//call the function
OUTPUT( getroomwords(ds1,1)  ,NAMED('FunctionOut'));
getroomwords(ds1,2);

getroomwords(ds2,14);
