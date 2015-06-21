library(dplyr, verbose = FALSE)
source("setup.R")

dataset.get <- function(groupName) {
    uri <- file.path(getRepositorySource(), groupName, paste("X_", groupName, ".txt", sep = ""))
    
    set <- read.table(uri)
    features <- loadFeatures()
    names(set) <- make.names(names = features$Name, unique = TRUE, allow_ = TRUE)
    
    set
}

subject.get <- function(groupName) {
    uri <- file.path(getRepositorySource(), groupName, paste("subject_", groupName, ".txt", sep = ""))
    subjects <- read.table(uri)
    names(subjects) <- c("Subject")
    
    subjects[, 1] <- sapply(subjects[, 1], function(e){
        if(e < 10){
            paste("Subject", e, sep = "-0")
        }else {
            paste("Subject", e, sep = "-")
        }
    })
    subjects[, 1] <- data.frame(apply(subjects[1], 2, as.factor))
    
    subjects
}

activity.get <- function(groupName) {
    uri <- file.path(getRepositorySource(), groupName, paste("y_", groupName, ".txt", sep = ""))
    activities <- read.table(uri)
    names(activities) <- c("Activity")
    
    #setup activity lookup label
    actLabels <- loadActivityLabels()
    activities[, 1] <- data.frame(apply(activities[1], 2, as.factor))
    levels(activities$Activity) <- actLabels$Label
    
    
    activities
}