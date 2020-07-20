IMPORT ML_Core;
IMPORT KMeans;
IMPORT Visualizer;

KMDs := KMeans.Test.Datasets.DSIris.ds;

ML_Core.AppendSeqID(KMDs, id, newKMDs);
OUTPUT(newKMDs, NAMED('mainDs'));
ML_Core.ToField(newKMDs, KMNF);

Centroids := KMNF(id IN [1, 51, 101]);

Pre_Model := KMeans.KMeans(30, 0.03);

Model := Pre_Model.Fit(KMNF(number < 5), Centroids(number < 5));

Centers := KMeans.KMeans().Centers(Model);
OUTPUT(Centers);

Labels := KMeans.KMeans().Predict(Model, KMNF);
OUTPUT(Labels);

cluster1_set := SET(Labels(label = 1), id);
cluster2_set := SET(Labels(label = 51), id);
cluster3_set := SET(Labels(label = 101), id);

cluster1 := newKMDs(id IN cluster1_set);
OUTPUT(cluster1, NAMED('cluster1_out'));
cluster2 := newKMDs(id IN cluster2_set);
OUTPUT(cluster2, NAMED('cluster2_out'));
cluster3 := newKMDs(id IN cluster3_set);
OUTPUT(cluster3, NAMED('cluster3_out'));

viz_alldata := Visualizer.MultiD.Scatter('alldata',,'mainDs');
viz_alldata;

viz_cluster1 := Visualizer.MultiD.Scatter('cluster1',,'cluster1_out');
viz_cluster2 := Visualizer.MultiD.Scatter('cluster2',,'cluster2_out');
viz_cluster3 := Visualizer.MultiD.Scatter('cluster3',,'cluster3_out');
viz_cluster1;
viz_cluster2;
viz_cluster3;