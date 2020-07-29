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

    ecl bundle install https://github.com/hpcc-systems/LearningTrees

This is the ECL bundle that has functions to use Decision Trees and Random forests for Regression and Classification on HPCC Systems

    ecl bundle install https://github.com/hpcc-systems/KMeans

This is the ECL bundle that has functions to use KMeans clustering on a dataset using HPCC Systems

    ecl bundle install https://github.com/hpcc-systems/DBSCAN

This is the ECL bundle that contains functions to apply "Density Based Spatial Clustering with Added Noise" (DBSCAN) on a dataset using HPCC Systems   

    ecl bundle install https://github.com/hpcc-systems/Visualizer

This is an ECL bundle which helps to generate visualisations of outputs that are obtained to understand our results better on HPCC Systems.

You may also use `install.sh`(Linux) or `install.bat`(Windows) to run these commands in sequence.
It assumes HPCC Systems 7.10.6 is used and installed in the default directories.

## Workshop files

```
.
├── .gitignore
├── assignments
│   ├── day2
│   │   ├── input_heartDs.ecl
│   │   ├── input_houseDs.ecl
│   │   ├── input_salaryDs.ecl
│   │   ├── input_socialDs.ecl
│   │   └── README.md
│   ├── day4
│   │   ├── filterset.ecl
│   │   ├── README.md
│   │   └── shuffle.ecl
│   └── persons
│       ├── getCount.ecl
│       └── persons.ecl
├── data
│   ├── heart_failure.csv
│   ├── house_prices_data.csv
│   ├── README.md
│   ├── Salary_Data.csv
│   └── Social_Network_Ads.csv
├── day4
│   ├── dataMod.ecl
│   ├── datasetManips.ecl
│   ├── functioneg.ecl
│   ├── sqlaggregates.ecl
│   └── transformeg.ecl
├── day5
│   ├── Datasets.ecl
│   ├── DBSCANExample.ecl
│   ├── KMClusteringExample.ecl
│   ├── LinRegExample.ecl
│   ├── LogRegExample.ecl
│   ├── README.md
│   ├── RFClassification.ecl
│   └── RFRegression.ecl
├── install.bat
├── install.sh
└── README.md
```

+ data -> This folder contains all the datasets that we use for our operations in order to understand ECL and use it for machine learning
+ assignments -> The assignments prescribed following the lab sessions are added onto this folder with description
+ day4 -> The programs primarily used on day 4 to show how ECL language can be used to manipulate data is added in this folder
+ day5 -> The programs used on day 5 to implement various machine learning algorithms on HPCC Systems using ECL are added onto this folder