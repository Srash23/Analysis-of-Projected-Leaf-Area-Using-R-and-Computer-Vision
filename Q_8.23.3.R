# Load the necessary library
library(EBImage)

# Adjust the path to source getArea.R from the desktop
source("/Users/srashtibajpai/Desktop/getArea.R")

# Create a data frame to record results
results <- data.frame(JPG = character(), area = numeric(), stringsAsFactors = FALSE)

# Adjust the path to list files from the leafarea folder on the desktop
files <- list.files("/Users/srashtibajpai/Desktop/leafarea", pattern = ".JPG")

# Run function getArea on all images and store the results
for (f in files) {
  area <- getArea(f)
  results[nrow(results) + 1, ] <- c(f, area)
}
results$area <- as.numeric(results$area)

# Extract time point information
results$tp <- substr(results$JPG, 1, 2)
results$tp <- as.factor(results$tp)

# Extract plant information
results$plant <- sapply(results$JPG, function(x) unlist(strsplit(x, "[_]|[.]"))[2])
results$plant <- as.factor(results$plant)

# Rearrange data to analyze by time point
tp1 <- results[results$tp == "t1", ]$area
tp2 <- results[results$tp == "t2", ]$area
plot(tp2 ~ tp1, xlab = "Projected leaf area, tp1", ylab = "Projected leaf area, tp2")
abline(c(0,1)) # add the 1-to-1 line

# Run the t-test
t.test(tp1, tp2, paired = TRUE, alternative = "less")

