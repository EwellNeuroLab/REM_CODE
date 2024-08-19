This code segments EEG data into minute long epochs and calculates theta delta ratios for each minute. It is designed to run on periods of EEG that were previously video scored as comprising mostly sleeping behavior. Thus, epochs with high theta to delta ratios are putative REM epochs. After identifying putative REM epochs, it is recommended that the analyzer go back and rewatch those minutes of video to confirm that the identified periods occur during sleeping behavior.

You will need Chronux to run this package. 

[1] Run GetThetaDeltaRatio 
* make sure the fs variable (sample rate) is set correctly for your  data 

[2] Run FindREM