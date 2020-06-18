
# Codebook

## Data

* activity_labels.txt contains names of activities.
* features.txt contains names of features.
* X_train.txt and X_test.txt contain train and test values.
* y_train.txt and y_test.txt contain train and test activity IDs.
* subject_train.txt and subject_test.txt contain train and test subject IDs.
* Other files do not contain any data needed by the script.

## Operations and Variables

* Download and unzip the file if it is needed.
* Read and merge the train and test data.
&nbsp;
&nbsp;
&nbsp;

  + By merging train and test variables xMerged table is created.
  + By merging train and test activity IDs yMerged table is created.
  + By merging train and test subject IDs subjects table is created.

&nbsp;
&nbsp;

* Activity labels are read from the second column of activity_labels.txt and stored in 'activityLabels'.
* Features are read from the second column of features.txt and stored in 'features'.
* Indices of specific features that contain "-mean()" and "-std() " are found and stored in 'selectFeatures'.
* Other features and corresponding variables in 'xMerged' are excluded.
* "()" and "-" parts are deleted from feature names. All "mean" words are converted to "Mean" and all "std" to "Std"
* 'activities' list is created. This list contains activity names corresponding to activity IDs in 'yMerged'.
* 'subjects', 'activities' and 'xMerged' are all merged together with cbind. The table is stored in the variable 'complete'
* Column names of 'complete' are defined. The first column contains Subjects, the second column contains Activities and other 66 columns correspond to the extracted features.
* aggregate function is then used to find the mean of each variable for each activity and each subject.
* 'tidyTable' is obtained by ordering the result of aggregate function.
* Finally, the program prints 'tidyTable' to tidy_dataset.txt .
