:: Use this to install all the bundles in one go %

:: If you have 32 bit this will work %
cd C:\Program Files\HPCCSystems\8.0.8\clienttools\bin
:: This will fail, but we'll remain there
cd "C:\Program Files (x86)\HPCCSystems\8.0.8\clienttools\bin"


ecl bundle install https://github.com/hpcc-systems/ML_Core
ecl bundle install https://github.com/hpcc-systems/PBblas
ecl bundle install https://github.com/hpcc-systems/LinearRegression
ecl bundle install https://github.com/hpcc-systems/LogisticRegression
ecl bundle install https://github.com/hpcc-systems/LearningTrees
ecl bundle install https://github.com/hpcc-systems/KMeans
ecl bundle install https://github.com/hpcc-systems/DBSCAN
ecl bundle install https://github.com/hpcc-systems/Visualizer

PAUSE
