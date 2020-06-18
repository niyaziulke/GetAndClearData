## Getting and Cleaning Data


This project uses the data set from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#


As the name suggests, the aim of this project is getting and cleaning data.
&nbsp;
&nbsp;


* run_analysis.R performs the following tasks:
 
    1.  Download and unzip the data if it is needed.
    2.  Merge the training and test data.
    3.  Extract features which are features of mean and standard deviation.
    4.  Extract variables which are related to the extracted features.
    5.  Delete parantheses and hyphens in feature names to improve readability.
    6.  Merge subjects, activities and features to obtain a single table.
    7.  Find average of each variable for each activity and each subject. Using these average values, create a tidy and  more compact table.
    8.  Print the tidy table to tidy_dataset.txt.
    <br /><br />


* tidy_dataset.txt contains the tidy table obtained by running run_analysis.R

* For detailed explanation of the code, please read CodeBook.md

