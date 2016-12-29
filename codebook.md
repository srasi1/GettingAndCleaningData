Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit� degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

#Code to generate code book
```R
Data <- fMergeData
cols <- names(Data)
values <- sapply(cols, function(x) {
	cls <- class(Data[[x]])
	if(cls == "integer") 		  	
		paste(cls, min(Data[x]), "to", max(Data[x]), sep = " : ")				
	else if(cls == "factor")
		paste(unique(Data[[x]]), sep = " : ")
	else  if(cls == "numeric")
		paste(cls, min(Data[x]), max(Data[x]), sep = " : ")

	})
write.table(values, "codebook.csv", row.name = FALSE, sep = ",")
```
column name    |   class    | range
---------------|------------|----------
subject  |integer | 1 : to : 30"
actname | factor  | "LAYING"  "SITTING"  "STANDING"  "WALKING" "WALKING_DOWNSTAIRS" "WALKING_UPSTAIRS"  
tBodyAccmeanX | numeric | 0.22159824394 : 0.3014610196"
tBodyAccmeanY | numeric | -0.0405139534294 : -0.00130828765170213
tBodyAccmeanZ | numeric | -0.152513899520833 : -0.07537846886
tBodyAccstdX  | numeric | -0.996068635384615 : 0.626917070512821
tBodyAccstdY  | numeric | -0.990240946666667 : 0.616937015333333
tBodyAccstdZ  | numeric | -0.987658662307692 : 0.609017879074074
tGravityAccmeanX | numeric | -0.680043155060241 : 0.974508732
tGravityAccmeanY | numeric | -0.479894842941176 : 0.956593814210526
tGravityAccmeanZ | numeric | -0.49508872037037 : 0.9578730416
tGravityAccstdX | numeric | -0.996764227384615 : -0.829554947808219
tGravityAccstdY | numeric | -0.99424764884058 : -0.643578361424658
tGravityAccstdZ | numeric | -0.990957249538462 : -0.610161166287671
tBodyAccJerkmeanX | numeric | 0.0426880986186441 : 0.130193043809524
tBodyAccJerkmeanY | numeric | -0.0386872111282051 : 0.056818586275
tBodyAccJerkmeanZ | numeric | -0.0674583919268293 : 0.0380533591627451
tBodyAccJerkstdX  | numeric | -0.994604542264151 : 0.544273037307692
tBodyAccJerkstdY  | numeric | -0.989513565652174 : 0.355306716915385
BodyAccJerkstdZ  | numeric | -0.993288313333333 : 0.0310157077775926
tBodyGyromeanX | numeric | -0.205775427307692 : 0.19270447595122
tBodyGyromeanY | numeric | -0.204205356087805 : 0.0274707556666667
tBodyGyromeanZ | numeric | -0.0724546025804878 : 0.179102058245614
tBodyGyrostdX | numeric | -0.994276591304348 : 0.267657219333333
tBodyGyrostdY | numeric | -0.994210471914894 : 0.476518714444444
tBodyGyrostdZ | numeric | -0.985538363333333 : 0.564875818162963
tBodyGyroJerkmeanX | numeric | -0.157212539189362 : -0.0220916265065217
tBodyGyroJerkmeanY | numeric | -0.0768089915604167 : -0.0132022768074468
tBodyGyroJerkmeanZ | "numeric | -0.0924998531372549 : -0.00694066389361702
tBodyGyroJerkstdX | numeric | -0.99654254057971 : 0.179148649684615"
tBodyGyroJerkstdY | numeric | -0.997081575652174 : 0.295945926186441
tBodyGyroJerkstdZ | numeric | -0.995380794637681 : 0.193206498960417
tBodyAccMagmean | numeric | -0.986493196666667 : 0.644604325128205
tBodyAccMagstd | numeric | -0.986464542615385 : 0.428405922622222
tGravityAccMagmean | numeric | -0.986493196666667 : 0.644604325128205
tGravityAccMagstd | numeric | -0.986464542615385 : 0.428405922622222
tBodyAccJerkMagmean | numeric | -0.99281471515625 : 0.434490400974359
tBodyAccJerkMagstd | numeric | -0.994646916811594 : 0.450612065720513
tBodyGyroMagmean | numeric | -0.980740846769231 : 0.418004608615385
tBodyGyroMagstd | numeric | -0.981372675614035 : 0.299975979851852
tBodyGyroJerkMagmean | numeric | -0.997322526811594 : 0.0875816618205128
tBodyGyroJerkMagstd | numeric | -0.997666071594203 : 0.250173204117966
fBodyAccmeanX | numeric | -0.995249932641509 : 0.537012022051282
fBodyAccmeanY | numeric | -0.989034304057971 : 0.524187686888889
fBodyAccmeanZ | numeric | -0.989473926666667 : 0.280735952206667
fBodyAccstdX | numeric | -0.996604570307692 : 0.658506543333333
fBodyAccstdY | numeric | -0.990680395362319 : 0.560191344
fBodyAccstdZ | numeric | -0.987224804307692 : 0.687124163703704
fBodyAccmeanFreqX | numeric | -0.635913046346154 : 0.159123629063636
fBodyAccmeanFreqY | numeric | -0.379518455061538 : 0.466528231788462
fBodyAccmeanFreqZ | numeric | -0.520114793584906 : 0.402532553395833
fBodyAccJerkmeanX | numeric | -0.994630797358491 : 0.474317256051282
fBodyAccJerkmeanY | numeric | -0.989398823913043 : 0.276716853307692
fBodyAccJerkmeanZ | numeric | -0.992018447826087 : 0.157775692377778
fBodyAccJerkstdX | numeric | -0.995073759245283 : 0.476803887476923
fBodyAccJerkstdY | numeric | -0.990468082753623 : 0.349771285415897
fBodyAccJerkstdZ | numeric | -0.993107759855072 : -0.00623647528983051
fBodyAccJerkmeanFreqX | numeric | -0.576044001875 : 0.331449281481482
fBodyAccJerkmeanFreqY | numeric | -0.601971415384615 : 0.195677336307692
fBodyAccJerkmeanFreqZ | numeric | -0.62755547372549 : 0.230107945944444
fBodyGyromeanX | numeric | -0.99312260884058 : 0.474962448333333
fBodyGyromeanY | numeric | -0.994025488297872 : 0.328817010088889
fBodyGyromeanZ | numeric | -0.985957788 : 0.492414379822222
fBodyGyrostdX | numeric | -0.994652185217391 : 0.196613286661538
fBodyGyrostdY | numeric | -0.994353086595745 : 0.646233637037037
fBodyGyrostdZ | numeric | -0.986725274871795 : 0.522454216314815
fBodyGyromeanFreqX | numeric | -0.395770150677419 : 0.249209411510602
fBodyGyromeanFreqY | numeric | -0.666814815306122 : 0.273141323315789
fBodyGyromeanFreqZ | numeric | -0.507490866734694 : 0.3770740968
fBodyAccMagmean | numeric | -0.986800645362319 : 0.586637550769231
fBodyAccMagstd | numeric | -0.987648484461539 : 0.178684580868889
fBodyAccMagmeanFreq | numeric | -0.312338030213846 : 0.435846931652174
fBodyBodyAccJerkMagmean | numeric | -0.993998275797101 : 0.538404846128205
fBodyBodyAccJerkMagstd  | numeric | -0.994366667681159 : 0.316346415348718
fBodyBodyAccJerkMagmeanFreq | numeric | -0.125210388757581 : 0.488088499666667
fBodyBodyGyroMagmean | numeric | -0.986535242105263 : 0.203979764835897
fBodyBodyGyroMagstd | numeric | -0.981468841692308 : 0.236659662496296
fBodyBodyGyroMagmeanFreq | numeric | -0.456638670923077 : 0.409521611525424
fBodyBodyGyroJerkMagmean | numeric | -0.997617389275362 : 0.146618569064407
fBodyBodyGyroJerkMagstd | numeric | -0.99758523057971 : 0.287834616098305
fBodyBodyGyroJerkMagmeanFreq | numeric | -0.182923596577778 : 0.426301679855072
angletBodyAccMeangravity | numeric | -0.163042575021277 : 0.129153963587755
angletBodyAccJerkMeangravityMean | numeric | -0.120553975717391 : 0.203259965863014
angletBodyGyroMeangravityMean | numeric | -0.389305120341463 : 0.444101172307692
angletBodyGyroJerkMeangravityMean | numeric | -0.223672056052174 : 0.182384802705085
angleXgravityMean | numeric | -0.947116527659574 : 0.737784354819277
angleYgravityMean | numeric | -0.874567701929825 : 0.42476122745098
angleZgravityMean | numeric | -0.873649367 : 0.390444368518519
