data(mtcars)

labels <- c(
  "Miles/(US) gallon",
  "Number of cylinders",
  "Displacement (cu.in.)",
  "Gross horsepower",
  "Rear axle ratio",
  "Weight (lb/1000)",
  "1/4 mile time",
  "V/S",
  "Transmission",
  "Number of forward gears",
  "Number of carburetors"
)

values <- names(mtcars)
names(values) <- labels

# For use in the drop down box, add "<Select>" option as first choice
brandnames <- c("<Select Car Model>",sort(rownames(mtcars)))


varlabel <- function(x) {
  names(which(values==x))[1]
}

##Utility functions

## ltrim removes any leading spaces from a string
ltrim <- function(s) {
  gsub("^\\s+","",s)
}

## rtrim removes any trailing spaces from a string
rtrim <- function(s) {
  gsub("\\s+$","",s)
}

## trim removes any leading and trailing spaces from a string
trim <- function(s) {
  rtrim(ltrim(s))
}

## Shortcut to the factor variables in the mtcars dataset
factorVars <- c("cyl","vs","am","gear","carb")

isfactor <- function(x) {
  length(which(factorVars==x)) > 0
}

## Modify data frame: replace non-numerical factor columns with factor variablea
##   incuding labels
mtcars$am <- factor(mtcars$am, labels=c("Automatic", "Manual"))
mtcars$vs <- factor(mtcars$am, labels=c("V", "S"))

mtcars$cyl  <- factor(mtcars$cyl)
mtcars$gear <- factor(mtcars$gear)
mtcars$carb <- factor(mtcars$carb)
