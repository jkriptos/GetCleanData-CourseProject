setupEnvironment <- function() {
    workingDirectory <- "C:\\usr\\coursera\\CleaningData\\Project"
    setwd(workingDirectory)
}

getRepositorySource <- function() {
    source <- "./repository/UCI HAR Dataset"
    source
}

loadFeatures <- function() {
    uri <- file.path(getRepositorySource(), "features.txt")
    fs <- read.table(uri)
    names(fs) <- c("Position", "Name")
    
    fs
}

loadActivityLabels <- function() {
    uri <- file.path(getRepositorySource(), "activity_labels.txt")
    df <- read.table(uri, stringsAsFactors = FALSE)
    names(df) <- c("Id", "Label")
    
    df
}


