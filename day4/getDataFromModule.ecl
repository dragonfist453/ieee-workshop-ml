IMPORT $.dataMod;

// visibility
OUTPUT(dataMod.ds1  ,NAMED('data'));
//OUTPUT(dataMod.ds2);
myDataSet := dataMod.ds1;




// aggregates

//count
OUTPUT(COUNT(mydataset) ,named('COUNT'));


//sorts
// ascending
sortasc := SORT(mydataset,bedrooms);
//descending
sortdesc:= SORT(mydataset,-bedrooms);




OUTPUT(sortasc,NAMED('ascending'));
OUTPUT(sortdesc,NAMED('descending'));






