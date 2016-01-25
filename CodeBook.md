Variables:
"subject" refers to the identifier of the experimental subject
"activity" refers to the activity performed by the experimental subject
"t(XXXX)-mean/std()-X/Y/Z" refers to the mean or standard deviation of the measurement taken in the XYZ direction for each activity by a certain experimental subject

Data:
The data sets can be splitted into a test set and a training set. The data could be splitted that way possibly to perform machine learning operations on it.
Within each test and training set, the data is then splitted in the following manner:
1) subject_(XXX).txt: a file that contains the unique identity of each experimental subject (each data point corresponding to a row)
2) Y_(XXX).txt: a file describing the activity the subject was performing
3) X_(XXX).txt: a file containing the various measurements of the subject while performing the activity
4) Inertial Signals: an additional folder containing more measurements of the subject

Other data files:
activity_labels.txt: Links the class labels with their activity name
refer to activity_labels.txt for the list of activities in "labels" files
refer to features.txt for the list of measurement for each activity in "set" files

Transformation performed:
Steps taken to complete the project:
1) load data into R using read.table to get ideas
2) renamed labels (in Y_(XXX).txt) to their activity names instead of numbers
3) combined the subject identifier set, activity set and the measurements of each activity
4) renamed variable headings using features file
5) after steps 2) to 4) was performed for both the test and training sets, the data is merged by row binding
6) logical vector to detect column names for mean and std measurements using regex (make.names is used to convert other symbols to periods to easier apply regex)
7) the logical vector in step 6) is used to create the first data set required by the assignment
8) using two for loops, one for each subject, one for each activity for each subject, the average of all the other measurements was averaged
9) after applying step 8) to the newly created data set in step 7), the second data set required by the assignment is created
10) the data sets created are then saved.
