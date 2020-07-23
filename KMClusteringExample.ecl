IMPORT ML_Core;
IMPORT KMeans;
IMPORT Visualizer;

KMDs := KMeans.Test.Datasets.DSIris.ds;

ML_Core.AppendSeqID(KMDs, id, newKMDs);
ML_Core.ToField(newKMDs, KMNF);

Centroids := KMNF(id IN [1, 51, 101]);

Pre_Model := KMeans.KMeans(30, 0.03);

Model := Pre_Model.Fit(KMNF(number < 5), Centroids(number < 5));

Centers := KMeans.KMeans().Centers(Model);
OUTPUT(Centers);

Labels := KMeans.KMeans().Predict(Model, KMNF);
OUTPUT(Labels);