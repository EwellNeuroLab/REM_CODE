clear all;
close all;
saveDir='C:\Users\admin\Desktop\207\outputs'; %you set this to where you want to save output data

saveFile = '207_12_SleepOutput'; %you set this to what you want to call output data
cd(saveDir)
load('207_12_SleepOutput.mat'); % this is the file generated by 'getThetaDeltaRatio'
threshold=2; %you set
chNum=1; %you set
disp(['Analyzing ', saveFile, '......'])

plot(ts,M(:,chNum),'m')
hold on;
box off
ylim([-500 500])

ylim([-500 500])
box off
title(['Mouse ', saveFile(1:3)])

if find(thDltRatio>threshold);
R=find(thDltRatio>threshold);
dR=diff(R);
if ~isempty(dR)
    R=[0 R];
    clear dR
    dR=diff(R);

    if length(find(dR==1)) == length(dR) %if the bout is at the beginning only
starts_s = 0;
stops_s = R(end)*60;
    else
starts=R(find(dR>1)+1);
stops = [];
for i=2:length(starts)
    stops(i-1)=R(find(R==starts(i))-1);
end
    stops=[stops starts(end)];

   starts_s=(starts-1)*60;
   
  
    stops_s= stops*60;
    end
 else
    starts_s=(find(thDltRatio>threshold)-1)*60
    stops_s=find(thDltRatio>threshold)*60
end

    
    duration= stops_s-starts_s;
    
    goodREM= find(duration>60);

    REMbouts=[starts_s',stops_s'];

for i = 1:length(duration)
plot([starts_s(i) starts_s(i)], [-500 400],'k')
plot([stops_s(i) stops_s(i)], [-500 400],'c')
end

xlabel('Time, S')
ylabel('Voltage, microV')


disp(['Using a threshold of ', num2str(threshold), ', found ', num2str(length(duration)), ' bouts for a total duration of ', num2str(sum(duration)), ' seconds'])
save(saveFile, 'thDltRatio','ts','M','REMbouts')
else
    disp(['Using a threshold of ', num2str(threshold), ', found 0 bouts! '])
end