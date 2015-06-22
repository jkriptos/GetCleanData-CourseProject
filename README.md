
###Usage

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
