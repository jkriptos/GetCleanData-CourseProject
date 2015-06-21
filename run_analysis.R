library(dplyr, verbose = FALSE)
source("setup.R")
source("datasource-common.R")

runAnalisis <- function() {
    print("Extracting Test set...")
    testSet <- dataset.getMerged("test")
    print("Extracting Training set...")
    trainSet <- dataset.getMerged("train")
    
    print("Merging training and test sets...")
    completeSet <- rbind(testSet, trainSet)
    
    print("Grouping and summarizing complete set...")
    summarizedSet <- dataset.SummarizeAverages(completeSet) %>%
        arrange(Subject, Activity)
    
    print("Analysis complete.")
    
    summarizedSet
}

save <- function(dataset) {
    filename <- "analized-set.txt"
    
    write.table(dataset, filename, row.names = FALSE)
}

dataset.getMerged <- function(groupName) {
    activities <- activity.get(groupName)
    subjects <- subject.get(groupName)
    set <- dataset.get(groupName)
    
    tMerged <- cbind(subjects, activities, set)
    tdf <- tbl_df(tMerged)
    
    dtf <- tdf %>% 
        select(Subject, Activity, contains("mean"), contains("std")) %>%
        select(-contains("angle"), -contains("meanFreq"))
    
    colnames <- getCleanColNames()
    names(dtf) <- colnames$Name
    
    dtf
}

dataset.SummarizeAverages <- function(df) {
    #summarizes the data and applies a mean function to all columns
    
    df %>%
        arrange(Subject, Activity) %>%
        group_by(Subject, Activity) %>%
        summarise_each(funs(mean))
}

getCleanColNames <- function() {
    uri <- file.path("col-names.txt")
    df <- read.table(uri, stringsAsFactors = FALSE)
    names(df) <- c("Name")
    
    df
}