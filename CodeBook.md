
Course Project - Data Dictionary
======================================================================
###   Coursera - Getting and Cleaning Data
###   Derek M Wilson 14.10.20

This document contains the data dictionary for the TinyData results

These results are derived from the data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#)



####SUBJECT  *Integer*

    [1...30]: A unique identifier for each study participant 



####ACTIVITY  *Factor of 6 levels*

    Denotes the activity for which the variables were calculated.

    1.Lying
    2.Sitting
    3.Standing   
    4.Walking
    5.Walking\\_Downstairs
	6.Walking\\_Upstairs



####FEATURE VECTORS  *Real Number*

The last 65 columns are the mean values of the mean and standard deviation of the recorded feature vectors

Each column carries a descriptive name relating to the information captured. The following is a summary of descriptive information provided with the UCI HAR dataset.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals. Time domain signals were captured then filtered with a corner frequency to remove noise, identified with prefix label time. Acceleration signals were separated into body and gravity acceleration signals. The body linear acceleration and angular velocity were derived in time to obtain Jerk signals. Also, the magnitude of these three-dimensional signals were calculated. Fast Fourier Transform (FFT) was applied to some of these signals, identified with prefix label time. These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions. Further, two statistical measures, mean and standard deviation, are provided for each of the feature vectors.  

Example: frequency.body.gyroscope.standard_deviation.x_direction
