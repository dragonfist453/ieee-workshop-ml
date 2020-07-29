
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




//new record extending the older one by adding an id field
dsrecwithrnd:= RECORD
	integer id;
	dsrecord;
end;

//use the id column as a random field
//This is a shorthand for transform
//self, left, counter are predefined in this scope
dswithrnd:= project(ds, TRANSFORM(dsrecwithrnd, SELF.id:= RANDOM(),SELF:=LEFT) );


//sort it according to the random column. This, will essentially shuffle it.
dsshuffled:= sort(dswithrnd,id);

//now to set the id properly
dsshuffledids := project(dsshuffled, TRANSFORM(dsrecwithrnd,SELF.id:=COUNTER,SELF:=LEFT) );


OUTPUT(dsshuffledids);