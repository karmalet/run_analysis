run_analysis
============
<title>Coursera GCD Course Project</title>
the tidy data set created in step 5

<b>run_analysis.R :</b> R scripts for extracting tidy data from Samsung dataset.<br>
<b>GCD_projcet.txt :</b> the tidy data text file <br>

<b>Code Book</b>
<p>5 variables = {subject, activity, type, measure, value, average, group_n"} </p>

<b>subject:</b> the subject who performed the activity for each window sample (1-30 numeric) <br>
<b>activity :</b> 6 activity names (character) <br>
<b>type :</b> feature type, i.e. "tBodyAcc", "fBodyGyro", etc. (character) <br>
<b>measure :</b> standard measure, i.e. mean or standard deviation (character) <br>
<b>value :</b> the observations associated with the former variables (numeric) <br>
<b>average :</b> the average of values in each group. grouping was based on 4 factors(subject, activity, type, measure) <br>
<b>group_n :</b> the number of each subgroup. provided for reference.
