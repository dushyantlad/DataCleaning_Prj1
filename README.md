# Steps for generating the output
#
1. Load libraries plyr and dplyr to Workspace 
2. Create data frame from activity_labels.txt and feature.txt
3. Create data frame test_df for test data 
  a. create data frame subject_test_df from  Subject_test.txt 
  b. create data frame y_test_df from y_test.txt
  c. create data frame x_test_df from X_test.txt
  d. rename column for subject_test_df and as "Subject"
  e. merge y_test_df with activity_label_df to generate y_test_df with column Name "Activity" and numeric values for
     Activities replaced by Activity labels
  f. rename the columns on x_test_df with values from feature_labels_df
  g. Use cbind to merge Subject_test_df, y_test_df and x_test_df to create test_df
4. Repeate all steps for files in train folder to create data frame train_df
5. User rbind to merge the data frame test_df and train_df into data_df
6. Extract the Activity,Subject and all the columns which have mean() or std() in their names, in to tidy_df
7. Group the data frame by (Subject,Activity) and calculate avgerage measurement for each measurement for each combination       in to tidy_mean_df
8. Write the tidy_mean_df into file "tidy_mean_df.txt"

Note: clear environment variable as their usage is over to free memory spaces
