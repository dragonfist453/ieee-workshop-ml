# Machine Learning on a Distributed Platform

## Prerequisites

Once the HPCC Platform is installed on the host computer with the client tools, make sure to set "**installation folder**\clienttools\bin" to PATH in Windows OS.

Run the following commands on the Command Prompt in Windows or Terminal in Linux ubuntu:

    ecl bundle install https://github.com/hpcc-systems/ML_Core

This installs the core bundle for all ML applications on HPCC Systems

    ecl bundle install https://github.com/hpcc-systems/PBblas

This installs the Parallel Basic Linear Algebra Subprograms for HPCC which is used in many ML applications

    ecl bundle install https://github.com/hpcc-systems/LinearRegression

This is the ECL bundle which has functions to perform Linear Regression on HPCC Systems

    ecl bundle install https://github.com/hpcc-systems/LogisticRegression

This is the ECL bundle which has functions to perform Logistic Regression on HPCC Systems    

    ecl bundle install https://github.com/hpcc-systems/SupportVectorMachines

This is the ECL bundle that has functions to use Decision Trees and Random forests for Regression and Classification on HPCC Systems

    ecl bundle install https://github.com/hpcc-systems/KMeans

This is the ECL bundle that has functions to use KMeans clustering on a dataset using HPCC Systems

    ecl bundle install https://github.com/hpcc-systems/DBSCAN

This is the ECL bundle that contains functions to apply "Density Based Spatial Clustering with Added Noise" (DBSCAN) on a dataset using HPCC Systems   