# Download.R
# Bastiaan Quast
# bquast@gmail.com
#-------------------------

# specify the source and destination of the download
destination.file <- "Coursera-SwiftKey.zip"
source.file <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"

# execute the download
download.file(source.file, destination.file)

# extract the files from the zip file
unzip(destination.file)
