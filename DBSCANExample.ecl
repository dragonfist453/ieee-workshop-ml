IMPORT ML_Core;
IMPORT DBSCAN;
IMPORT DBSCAN.tests.datasets.frogDS_Small AS frog_data;

//Import raw data
ds := frog_data.ds;

//sequence your data that needs to be sequenced
ML_Core.AppendSeqID(ds,id,dsID);
// Convert raw data to NumericField format
ML_Core.ToField(dsID,dsNF);

//Train DBSCAN model 
mod := DBSCAN.DBSCAN(0.3,10).Fit(dsNF);

NumberOfClusters := DBSCAN.DBSCAN().Num_Clusters(mod);
NumberOfOutliers := DBSCAN.DBSCAN().Num_Outliers(mod);

OUTPUT(NumberOfClusters, NAMED('NumberOfClusters'));
OUTPUT(NumberOfOutliers, NAMED('NumberOfOutliers'));

//Analysis
SSS       := ML_Core.Analysis.Clustering.SilhouetteScore(dsNF,mod);
OUTPUT(sss,NAMED('Analysis'));
