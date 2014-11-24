# download_data.R
# Bastiaan Quast
# bquast@gmail.com
#-------------------------

# specify the source and destination of the download
destination_file <- "Coursera-SwiftKey.zip"
source_file <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"

# execute the download
download.file(source_file, destination_file)

# extract the files from the zip file
unzip(destination_file)