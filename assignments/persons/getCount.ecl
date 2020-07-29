#option('outputlimit', 2000);
getsorted := SORT($.persons,zipcode);

OUTPUT(COUNT(getsorted));

OUTPUT(getSorted,,'~workshop::sorttest',THOR,OVERWRITE);