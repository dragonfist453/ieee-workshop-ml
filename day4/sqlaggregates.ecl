IMPORT $.dataMod;



// visibility
OUTPUT(dataMod.ds1  ,NAMED('data'));
//OUTPUT(dataMod.ds2);
myDataSet := dataMod.ds1;




// common aggregates - count, sort, sum, min,max,avg

// count
OUTPUT(COUNT(mydataset) ,named('COUNT'));


// sorts
// ascending
sortasc := SORT(mydataset,bedrooms);
// descending
sortdesc:= SORT(mydataset,-bedrooms);


OUTPUT(sortasc,NAMED('ascending'));
OUTPUT(sortdesc,NAMED('descending'));


//max no. of bedrooms
maxBedrooms := MAX(mydataset,bedrooms);
OUTPUT(maxBedrooms,NAMED('max'));


//similarly, minimum area of 
//minArea := <???>
//OUTPUT(minArea,NAMED('min');

//avg number of bedrooms
avgBedrooms := ave(mydataset,bedrooms);
OUTPUT(avgBedrooms,NAMED('avg'));


// okay one final thing - random()
// suppose we need some source of randomness to do something
// we can try this
// returns pseudo-random non-negative integer value between 0 and 2^32-1 = 4,294,967,295
OUTPUT( RANDOM() , NAMED('someRandom') );



