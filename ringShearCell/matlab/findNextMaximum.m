function [maxVal] = findNextMaximum(direc,timeFile)

%readData
lngd = ['v_forceInZ'; 'v_normalShearStress'; 'v_absForce'; 'v_absNormalShearStress'; 'v_absMoment'; 'v_tangentialShearStress'; 'v_lidHeight'];
data = loaddata([direc '/shearExperiment.dat'],10,2);
shear = data(9,:);
#timeFile='FP2.txt';
searchTime = loaddata([timeFile],2,1);

#search for startTime
i = 1;
while data(2,i) < searchTime(1,1);
	i = i+1;
end

#find Maximum
window=0.1;%s
outPTS=data(2,2)-data(2,1);
win=round(window/outPTS);

shearStressFilt=filter(ones(win,1)./win,1,shear);
#keyboard;
while ((shearStressFilt(i+1)-shearStressFilt(i)) >= -1e-4) || (abs(shearStressFilt(i)/max(shearStressFilt(i:end))-1)>0.4)
	i++;
end

#keyboard
maxVal = shearStressFilt(i);

end
