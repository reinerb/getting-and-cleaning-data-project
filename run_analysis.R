library(dplyr)

# The files for this script are located in the Data folder.

# First, we'll get the labels for each activity.
# We'll make them a little tidier by removing underscores
# and making them lowercase.
activity_labels <- read.table('Data/activity_labels.txt',
			      col.names = c('ID', 'Label'))
activity_labels$Label <- tolower(activity_labels$Label)
activity_labels$Label <- gsub('_', ' ', activity_labels$Label)

# We can use this to identify the activity of each data point.
test_activities <- 'Data/test/y_test.txt' %>% 
	read.table(col.names = 'Activity') %>%
	sapply(function(x) activity_labels[x, 'Label'])

training_activities <- 'Data/train/y_train.txt' %>% 
	read.table(col.names = 'Activity') %>%
	sapply(function(x) activity_labels[x, 'Label'])

# We read in the feature vector. 
features <- read.table('Data/features.txt', 
		       col.names = c('ID', 'Label'))

# The features we care about are the ones that contain mean() and std().
# We'll add another column to the table to reflect this and make filtering
# relevant results easier later.
features$MeanOrStD <- grepl(x = features$Label, 
			    pattern = '(.*mean[(][)])|(.*std[(][)])')

# We also need the subject IDs.
test_subjects <- read.table('Data/test/subject_test.txt',
			    col.names = 'SubjectID')
training_subjects <- read.table('Data/train/subject_train.txt',
				col.names = 'SubjectID')

# We now read in the test and training data sets with the correct column
# names.
test_data <- read.table('Data/test/X_test.txt',
			col.names = features$Label) %>%
	subset(select = features$MeanOrStD)
training_data <- read.table('Data/train/X_train.txt',
			    col.names = features$Label) %>%
	subset(select = features$MeanOrStD)

# Now, we combine test and training data.
test <- cbind(test_subjects,
	      test_activities,
	      test_data)
training <- cbind(training_subjects,
		  training_activities,
		  training_data)

# And finally, combine the data into one set.
phonedata <- rbind(test, training) %>%
	arrange(SubjectID, Activity)

# We don't need anything other than the data above now, so we can clear out
# the working memory.
rm(activity_labels, features, test, test_activities, test_data, test_subjects,
   training, training_activities, training_data, training_subjects)