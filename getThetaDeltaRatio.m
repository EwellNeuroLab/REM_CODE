clear all;
runDir='C:\Users\admin\Desktop\207' %you set this to where your data are
fileName = '207_12_Sleep.csv'; % you set this to what your data file name is
 
saveDir='C:\Users\admin\Desktop\207\outputs' %you set this to where you want to save output data
saveFile = '207_12_SleepOutput'; %you set this to what you want to call output data

chNum = 1; %you set this to which channel you want to use

cd(runDir); %setting matlabs current path to where my data are

M=csvread(fileName); % read in the excel file (current directory is where the file lives which I call runDir - in my case on the dekstop)
fs= 400; % this is the sample rate of the EEG data 
fullLength=length(M(:,chNum))/fs; %gives us the recording length in seconds
ts = 0:1/fs:fullLength-1/fs; %create a timescale in seconds

% % can plot the chunk of data in seconds - (the second
%variable is the channel number)

numMin = floor(fullLength/60);

pts = fs*60; %number of points in a minut long epoch
 
inds = 1:pts:(numMin)*pts; %minute long epochs starts

for j = 1:(length(inds)-1) %loops through epochs
self.dat = M(inds(j):inds(j+1),chNum); %gets the LFP for the epoch that we are currently looking at
self.sampFreq = fs; %gets the sampling rate
[a_peak_av, f_peak, ThetaDeltaR] = plot_lfp_spectrum(self,10,9,[0 20],0,1); %function calculates theta/delta ratio (theta 5-11) and (delta 2-4). %change last value to 4 if you want plots
minIndex(j,1)=inds(j);
minIndex(j,2)=inds(j+1);
%close all;
thDltRatio(j) = ThetaDeltaR; %making the thDltRatio for each minute
f_peakAll(j) = f_peak;
% if thDltRatio(j)>2
%     figure;
% plot(self.dat);
% title(['Minute',num2str(j)])
%close all;        
end

m_ind=ts(minIndex);
cd(saveDir);
save(saveFile, 'thDltRatio','ts','M','m_ind')
plot(thDltRatio)
figure;
plot(ts,M(:,chNum))