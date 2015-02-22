# Assignment for the course Getting and Cleaning Data
## Description of the work

### The script

The script "run_analysis.R" reflects the tasks that are to be performed in this assignment.

It begins by reading in the feature names from the provided "features.txt". Once this is done, the names are made clearer and conforming to R's naming rules by replacing characters using the function `gsub'. In particular, parenthesis are removed, as are commas and dashes. The feature names pertaining to time or frequency domain information are also made to reflect this more clearly by changing the single "f" and "t" characters that identify them.

The raw data is then read in using the `read.table' function and passing the modified feature names as column values. This is done for the "X_train.txt" and "X_test.txt" files, adding another column to the data frame such that their source, train or test, is identified. This column is called "Data_set". The activity labels for the observations are then read from the provided "y_train.txt" and "y_test.txt" files, and added as a column called "Activity_label" to the data frame.

The data is then merged using the function `rbind' into one single data frame.

In the next step, the data related to standard deviation and mean values is extracted by filtering the column label names and overwriting the variable.

The activities are then switched from their numerical to descriptive versions, as indicated in the provided "activity_labels.txt" file.

Finally, the data is made tidy using the `ddply' function, and written to a text file called "Tidy_data.txt" using the function `write.table'.

### Running the script

Running the single script "run_analysis.R" is sufficient to create the tidy data text file and runs all necessary procedures to successfully do that.

The location of the original data must be a folder level down of the location of this script, under a folder called "/UCI HAR Dataset".

Required files inside this folder are:
* features.txt
* train/X_train.txt
* train/y_train.txt
* test/X_test.txt
* test/y_test.txt
* activity_labels.txt

### Variables

* labels: contains the column names, formatted
* X_train: contains the train raw data
* y_train: contains the train activity labels
* X_test: contains the test raw data
* y_test: contains the test activity labels
* merged_data: contains the train and test merged data, with only the std and mean variables
* std_labels: labels with the word "std" found in them, for filtering later
* mean_labels: labels with the word "mean" found in them, for filtering later
* activity_labels: the descriptive activity labels
* tidy_data: the tidy data of the merged_data data frame

