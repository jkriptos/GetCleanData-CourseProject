####Usage

The scripts are intented to run in any environment as long as two conditions are met:

* The working directory is set to the directory that contains the scripts
* The function getRepositorySource in the file setup.R is modified so that it returns the path where the UCI HAR Dataset folder is located.

After these conditions, the analysis is run by sourcing the file and executing the runAnalisi function, as especified in the following snippet.

```{r}
> source("run_analysis.R")
> tidySet <- runAnalisis()
[1] "Extracting Test set..."
[1] "Extracting Training set..."
[1] "Merging training and test sets..."
[1] "Grouping and summarizing complete set..."
[1] "Analysis complete."
> dim(tidySet)
[1] 180  68
> View(tidySet)
> save(tidySet) #saves the set to a file named analized-set.txt
```

####File Structure

The project script structure is divided in three files: setup.R, datasource-common.R, and run_analysis.R. 

#####**setup.R**
This script file contains all the operations necessary for environment and setup. It also contains miscellaneous functions to load 	proper labels for features and activities, provided originally in the dataset.

It is extremely important to modify this file at convenience. This script plays a role of configuration, and the rest of the files rely heavily on the **getRepositorySource** function, thus, it is imperative to modify it accordingly.

Below there's a quick list of the functions listed in this file:

* **setupEnvironment**: sets the working directory based on a variable.
* **getRepositorySource**: returns the folder path to the data downloaded for the project.
* **loadFeatures**: returns a data frame with the features originally provided by the data authors.
* **loadActivityLabels**: returns a data frame with the activity labels originally provided by the data authors.

#####**datasource-common.R**

This file provides generic utilities to load the data sets, subjects and activities for both the train and test sets. These functions rely on the *groupName* variable to determine if it will load the train or test set. Because of this, it is necessary to call these functions with **"test"** or **"train"** as parameters.

The functions shared in this script file are:

* **dataset.get**: returns the data set with the 561 measures for either the test or the training set. The data set assigns the column names for the measures based on the *features.txt* file.
* **subject.get**: returns the subject data for the test or training set. The dataset contains only one column and it prefixes each subject with the word *"Subject-"*, which makes a more distinctive label for the subjects. 
* **activity.get**: returns the activity data for the test or training set. The dataset modifies the numbers from the raw data for more descriptive names, as provided by the data author in the *activity_labels.txt* file.

#####**run_analysis.R**

Performs merging between the data, subject and activity sets. It also selects the most relevant columns for our analysis, forms one single data set (instead of one for Test and one for Training), groups the info by Subject and Activity and performs a summary on the averages for each measurement. Finally, it also provides an utility to save the results to disk.

The functions listed in this script are:

* **dataset.getMerged**:  merges the activities, subjects and data sets for the Test or Train group into one single data frame. It also discards any unnecessary measurement (column) and cleans up the names for each column. 
* **getCleanColNames**: returns a list of clean, curated, column names for the final, tidy data-ed data frame. It fetches the curated list from the file *col-names.txt* located at the project root.
* **save**: saves the data frame passed by argument to a file named *analized-set.txt* located at the project root.
* **dataset.SummarizeAverages**: receives a data frame, composes groups by Subject and Activity and applies mean summaries for each column (measurement) on that data frame. At the end, it returns a new dataset with the mean summaries by Subject and Activity.
* **runAnalisis** (sic): loads the Test set, loads the Training set, combines them into one single big set and summarizes the means based on the Subject and Activity. It returns tidy data set with the average of each variable for each activity and each subject.
