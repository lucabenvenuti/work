% mainPressure
% Pressure Measurement - Preassure Drop in a Packed Bed 
% % Data Aquisition script; testetd with NI USB 6008 + NI9211 under matlab 2013, x32.
% 2 amplifiers used
% interpolation linear and polynomial 2
% By Nikolaus Doppelhammer & Luca Benvenuti
% July 2014
% v12
%%
% P.A. run tempControlAndMeasurement.m FIRST!!!!!!!
%%

% clear workspace
clear all; 
close all; 
clearDAQ;
clc;

%global meanoff

%% ### user input #########################################################
% 
% %function [y1,...,yN] = myfun(x1,...,xM)
% trota2=1;
% [trota1] = myfun(trota2);

%%
% Plot settings 
lineWidth = 2;
axesSize = 13;
labelSize = 13;

%% Initialising and Measuring 

[indata] = inputPar();
sampleTime = indata.sampleTime;
offsetSampleTime = indata.offsetSampleTime;
sampleFrequency = indata.sampleFrequency;
%indata.sampleFrequencyForTemp
dTuyMeasure = indata.dTuyMeasure;
dTuyKnow = indata.dTuyKnow;
rho = indata.rho;
particletype = indata.particleType;
particleType = indata.particleType;
name = indata.name;
particleweight = indata.particleWeight;
p0 = indata.p0;
h0 = indata.h0;
h = indata.h; 
R = indata.R;
fileName = indata.fileName;
fanspeed = indata.fanspeed;
pVelMax = indata.pVelMax; % [Pa]
VMax = indata.VMax;    % [V] 
tempcorr = indata.tempcorr;
saveFlag = indata.saveFlag;
%saveFlag=1;
% Save data to excel file 

%offset
    ai = startAI4PressureDrop('nidaq','Dev2',sampleFrequency,offsetSampleTime);
    disp(['Measuring offset:' blanks(1) strcat(num2str(offsetSampleTime),' seconds remaining ...')]);
    start(ai);
    trigger(ai); 
    wait(ai,offsetSampleTime+3)
    off = getdata(ai); %rand(25,6)*0.3;%
    disp('Mean offset values of channels: '); 
    %mean(off)
    k=1;
    for k=1:6 %number of channels
        meanoff(k) = mean(off(:,k));
    end
    disp('Offset measured. Power-on raceway and press any key to continue measuring.')
    pause;

%create folder
add = pwd;
caracter = [name,'_', particleType];
add2 = [add,'\',caracter,'\'];
mkdir(caracter);

%save offset
save([add2 [caracter, '_', num2str(0),'.mat']]);%,'name','off', 'fanspeed', 'indata', 'meanoff', '-mat'); %

%%
%for restart
% load mat file
% i = imax + 1;
% fanspeed2perc = input('new speed of the fan in % \n'); % 1.0;
% fanspeed(i) = fanspeed2perc/100;
%%

%main measuring loop
i=1;

fanspeed2perc = input('new speed of the fan in % \n'); % 1.0;
        fanspeed(i) = fanspeed2perc/100;

fanspeedl(i)= fanspeed; 

continuetest=1;

while continuetest==1
    disp(['Starting measurment:' blanks(1) strcat(num2str(sampleTime),' seconds remaining ...')]);
    ai = startAI4PressureDrop('nidaq','Dev2',sampleFrequency,sampleTime);
    disp('measuring ...')
    start(ai)
    trigger(ai)
    wait(ai,sampleTime+3)
    data = getdata(ai);
    disp('finished.')
    datasaved(:,:,i)= data; %rand(25,6)*i*1.3;%

    datasavedlenght(i) = length(datasaved(:,1,i));
  

    %velocity check & offset calculation
    %Offset correction, "V" stands for voltage 
    pDiffV(:,i) = datasaved(:,1,i) - mean(off(:,1)); %c(:,1,j) - a(:,1);  %data(:,1) - mean(off(:,1));  %
    %pDiffPa(:,i) = pDiffV(:,i)*pVelMax/VMax; % Differetial pressure [Pa] 
    %pDiffPaMean(i) = mean(pDiffPa(:,i));
    pDiffVMean(i) = mean(pDiffV(:,i));
    disp(pDiffVMean(i));
    if (pDiffVMean(i)) > 0.95*VMax
        warning('Sensor for veloctiy measurement has reached over 95% of its measuring range'); 
    end 

    save([add2 [caracter, '_', num2str(i),'.mat']]);%,'name','datasaved', 'fanspeed', 'indata', 'pDiffV','off',...
         %       'meanoff', '-mat'); %

    continuetest = input('Do you wish to continue the test? \n 0 = no \n 1 = yes \n');

    if continuetest==1
        i=i+1;
        fanspeed2perc = input('new speed of the fan in % \n'); % 1.0;
        fanspeed(i) = fanspeed2perc/100;
    else
    end

end

imax=i;
i=1;
datasavedlenghtmax = max(datasavedlenght);

%% Calculating Velocity 

pDiffPa = pDiffV*pVelMax/VMax; % Differetial pressure [Pa] %vector of vector = matrix
pDiffPaMean = pDiffVMean*pVelMax/VMax; %mean(pDiffPa(:,j));  % vector of scalar = vector
pDiffVMeanPlot = pDiffVMean/VMax*100;
v1 = sqrt(2*abs(pDiffPa)/rho); % [m/s] 
t = zeros(datasavedlenghtmax, imax);

save([add2 [caracter, '_', num2str(imax+1),'.mat']]);%,'name','datasaved', 'fanspeed', 'indata', 'pDiffV','off',...
          %      'meanoff', 'pDiffPa','pDiffPaMean','pDiffVMeanPlot','v1','t','-mat'); %


j=1;

for j=1:imax
    
%     length(v1(:,j))
%     pDiffPa(:,j) = pDiffV(:,j)*pVelMax/VMax; % Differetial pressure [Pa] %vector of vector = matrix
%     pDiffPaMean(j) = pDiffVMean(j)*pVelMax/VMax; %mean(pDiffPa(:,j));  % vector of scalar = vector
% (1:length(v1(:,j)))./sampleFrequency
%((1:datasavedlenght(i))/sampleFrequency)'

    % evaluation of velocity without temperatur compensation 
    t(:,j) = ((1:datasavedlenght(i))/sampleFrequency);%((1:length(v1(:,j)))./sampleFrequency)';
    
    data3 = datasaved(:,:,j);
    pDiffPa1 = pDiffPa(:,j);
    pDiffPaMean1 = pDiffPaMean(j);
    
    corrFunData(j) = corrFun( data3, indata, pDiffPa1, pDiffPaMean1, meanoff);
    
    vTuyKnowMean(j) = abs(corrFunData(j).vTuyKnowMean) ; 
    vflMean(j) = abs(corrFunData(j).vflMean);
% 
% %dP9MMean
%saveFlag=1;
% Save data to excel file 
if saveFlag == 1 

    if exist([add,fileName],'file')
        %copyfile('source','destination')
        %[num2, txt2,raw2] = xlsread([pwd,'\',fileName],1,'A17:E43');    % read file
        [num2, txt2,raw2] = xlsread([add,'\',fileName],1,'A17:E43');    % read file
        if length(num2)==0
            messNr=1;
        else
        assignin('base',char(txt2(1,1)),num2(:,1));    % assign numbers to variables
        messNr=length(vSup1DM)+1;
        end
    else
        messNr=1;
    end
    messNr=messNr+16;
    bedPressureDataHead={'vSup1DM','deltaP1 (1m)','deltaP2 (0.9m)','deltaP3 (0.8m)','deltaP4 (0.5m)';'[m/s]','[Pa]','[Pa]','[Pa]','[Pa]'};
    bedPressure=[corrFunData(j).vTuyKnowMean,corrFunData(j).dP1MMean,corrFunData(j).dP9MMean,corrFunData(j).dP8MMean,corrFunData(j).dP5MMean];
    xlswrite([add,'\',fileName],bedPressureDataHead,'A17:E18');
    xlswrite([add,'\',fileName],bedPressure,['A',int2str(messNr+2),':E',int2str(messNr+2)]);
    
    
end 



    
   % calcHydDiamData(j) = calcHydDiam( data3, indata, pDiffPa1, pDiffPaMean1, meanoff, corrFunData(j) );
    ReLinCorrOver1mNoD(j)   = abs(corrFunData(j).ReLinCorrOver1mNoD);
    ReNLinCorrOver1mNoD(j)  = abs(corrFunData(j).ReNLinCorrOver1mNoD);
    ReLinCorrOver09mNoD(j)  = abs(corrFunData(j).ReLinCorrOver09mNoD);
    ReNLinCorrOver09mNoD(j) = abs(corrFunData(j).ReNLinCorrOver09mNoD);
    ReLinCorrOver08mNoD(j)  = abs(corrFunData(j).ReLinCorrOver08mNoD);
    ReNLinCorrOver08mNoD(j) = abs(corrFunData(j).ReNLinCorrOver08mNoD);
    ReLinCorrOver05mNoD(j)  = abs(corrFunData(j).ReLinCorrOver05mNoD);
    ReNLinCorrOver05mNoD(j) = abs(corrFunData(j).ReNLinCorrOver05mNoD);
    
    fDaExpLinCorrOver1mNoD(j)   = abs(corrFunData(j).fDaExpLinCorrOver1mNoD);
    fDaExpNLinCorrOver1mNoD(j)  = abs(corrFunData(j).fDaExpNLinCorrOver1mNoD);
    fDaExpLinCorrOver09mNoD(j)  = abs(corrFunData(j).fDaExpLinCorrOver09mNoD);
    fDaExpNLinCorrOver09mNoD(j) = abs(corrFunData(j).fDaExpNLinCorrOver09mNoD);
    fDaExpLinCorrOver08mNoD(j)  = abs(corrFunData(j).fDaExpLinCorrOver08mNoD);
    fDaExpNLinCorrOver08mNoD(j) = abs(corrFunData(j).fDaExpNLinCorrOver08mNoD);
    fDaExpLinCorrOver05mNoD(j)  = abs(corrFunData(j).fDaExpLinCorrOver05mNoD);
    fDaExpNLinCorrOver05mNoD(j) = abs(corrFunData(j).fDaExpNLinCorrOver05mNoD);
    
    
    %%    
    %for plotting
    %figure1
    ReLinCorrOver1m(j) = abs(corrFunData(j).ReLinCorrOver1m);
    fDaExpLinCorrOver1m(j) = abs(corrFunData(j).fDaExpLinCorrOver1m);
    fDaErgunLinCorrOver1m(j) = abs(corrFunData(j).fDaErgunLinCorrOver1m);
    fDaKaysLinCorrOver1m(j) = abs(corrFunData(j).fDaKaysLinCorrOver1m);
    fDaCarmanLinCorrOver1m(j) = abs(corrFunData(j).fDaCarmanLinCorrOver1m);
    fDaBrauerLinCorrOver1m(j) = abs(corrFunData(j).fDaBrauerLinCorrOver1m);
    fDaKrierLinCorrOver1m(j) = abs(corrFunData(j).fDaKrierLinCorrOver1m);
    fDaIdelchikLinCorrOver1m(j) = abs(corrFunData(j).fDaIdelchikLinCorrOver1m);
    
     %figure2
    ReNLinCorrOver1m(j) = abs(corrFunData(j).ReNLinCorrOver1m);
    fDaExpNLinCorrOver1m(j) = abs(corrFunData(j).fDaExpNLinCorrOver1m);
    fDaErgunNLinCorrOver1m(j) = abs(corrFunData(j).fDaErgunNLinCorrOver1m);
    fDaKaysNLinCorrOver1m(j) = abs(corrFunData(j).fDaKaysNLinCorrOver1m);
    fDaCarmanNLinCorrOver1m(j) = abs(corrFunData(j).fDaCarmanNLinCorrOver1m);
    fDaBrauerNLinCorrOver1m(j) = abs(corrFunData(j).fDaBrauerNLinCorrOver1m);
    fDaKrierNLinCorrOver1m(j) = abs(corrFunData(j).fDaKrierNLinCorrOver1m);
    fDaIdelchikNLinCorrOver1m(j) = abs(corrFunData(j).fDaIdelchikNLinCorrOver1m);
    
    %figure3
    ReLinCorrOver09m(j) = abs(corrFunData(j).ReLinCorrOver09m);
    fDaExpLinCorrOver09m(j) = abs(corrFunData(j).fDaExpLinCorrOver09m);
    fDaErgunLinCorrOver09m(j) = abs(corrFunData(j).fDaErgunLinCorrOver09m);
    fDaKaysLinCorrOver09m(j) = abs(corrFunData(j).fDaKaysLinCorrOver09m);
    fDaCarmanLinCorrOver09m(j) = abs(corrFunData(j).fDaCarmanLinCorrOver09m);
    fDaBrauerLinCorrOver09m(j) = abs(corrFunData(j).fDaBrauerLinCorrOver09m);
    fDaKrierLinCorrOver09m(j) = abs(corrFunData(j).fDaKrierLinCorrOver09m);
    fDaIdelchikLinCorrOver09m(j) = abs(corrFunData(j).fDaIdelchikLinCorrOver09m);

    %figure4
    ReNLinCorrOver09m(j) = abs(corrFunData(j).ReNLinCorrOver09m);
    fDaExpNLinCorrOver09m(j) = abs(corrFunData(j).fDaExpNLinCorrOver09m);
    fDaErgunNLinCorrOver09m(j) = abs(corrFunData(j).fDaErgunNLinCorrOver09m);
    fDaKaysNLinCorrOver09m(j) = abs(corrFunData(j).fDaKaysNLinCorrOver09m);
    fDaCarmanNLinCorrOver09m(j) = abs(corrFunData(j).fDaCarmanNLinCorrOver09m);
    fDaBrauerNLinCorrOver09m(j) = abs(corrFunData(j).fDaBrauerNLinCorrOver09m);
    fDaKrierNLinCorrOver09m(j) = abs(corrFunData(j).fDaKrierNLinCorrOver09m);
    fDaIdelchikNLinCorrOver09m(j) = abs(corrFunData(j).fDaIdelchikNLinCorrOver09m);
    
    %figure5
    ReLinCorrOver08m(j) = abs(corrFunData(j).ReLinCorrOver08m);
    fDaExpLinCorrOver08m(j) = abs(corrFunData(j).fDaExpLinCorrOver08m);
    fDaErgunLinCorrOver08m(j) = abs(corrFunData(j).fDaErgunLinCorrOver08m);
    fDaKaysLinCorrOver08m(j) = abs(corrFunData(j).fDaKaysLinCorrOver08m);
    fDaCarmanLinCorrOver08m(j) = abs(corrFunData(j).fDaCarmanLinCorrOver08m);
    fDaBrauerLinCorrOver08m(j) = abs(corrFunData(j).fDaBrauerLinCorrOver08m);
    fDaKrierLinCorrOver08m(j) = abs(corrFunData(j).fDaKrierLinCorrOver08m);
    fDaIdelchikLinCorrOver08m(j) = abs(corrFunData(j).fDaIdelchikLinCorrOver08m);

    %figure6
    ReNLinCorrOver08m(j) = abs(corrFunData(j).ReNLinCorrOver08m);
    fDaExpNLinCorrOver08m(j) = abs(corrFunData(j).fDaExpNLinCorrOver08m);
    fDaErgunNLinCorrOver08m(j) = abs(corrFunData(j).fDaErgunNLinCorrOver08m);
    fDaKaysNLinCorrOver08m(j) = abs(corrFunData(j).fDaKaysNLinCorrOver08m);
    fDaCarmanNLinCorrOver08m(j) = abs(corrFunData(j).fDaCarmanNLinCorrOver08m);
    fDaBrauerNLinCorrOver08m(j) = abs(corrFunData(j).fDaBrauerNLinCorrOver08m);
    fDaKrierNLinCorrOver08m(j) = abs(corrFunData(j).fDaKrierNLinCorrOver08m);
    fDaIdelchikNLinCorrOver08m(j) = abs(corrFunData(j).fDaIdelchikNLinCorrOver08m);   
    
    %figure7
    ReLinCorrOver05m(j) = abs(corrFunData(j).ReLinCorrOver05m);
    fDaExpLinCorrOver05m(j) = abs(corrFunData(j).fDaExpLinCorrOver05m);
    fDaErgunLinCorrOver05m(j) = abs(corrFunData(j).fDaErgunLinCorrOver05m);
    fDaKaysLinCorrOver05m(j) = abs(corrFunData(j).fDaKaysLinCorrOver05m);
    fDaCarmanLinCorrOver05m(j) = abs(corrFunData(j).fDaCarmanLinCorrOver05m);
    fDaBrauerLinCorrOver05m(j) = abs(corrFunData(j).fDaBrauerLinCorrOver05m);
    fDaKrierLinCorrOver05m(j) = abs(corrFunData(j).fDaKrierLinCorrOver05m);
    fDaIdelchikLinCorrOver05m(j) = abs(corrFunData(j).fDaIdelchikLinCorrOver05m);

    %figure8
    ReNLinCorrOver05m(j) = abs(corrFunData(j).ReNLinCorrOver05m);
    fDaExpNLinCorrOver05m(j) = abs(corrFunData(j).fDaExpNLinCorrOver05m);
    fDaErgunNLinCorrOver05m(j) = abs(corrFunData(j).fDaErgunNLinCorrOver05m);
    fDaKaysNLinCorrOver05m(j) = abs(corrFunData(j).fDaKaysNLinCorrOver05m);
    fDaCarmanNLinCorrOver05m(j) = abs(corrFunData(j).fDaCarmanNLinCorrOver05m);
    fDaBrauerNLinCorrOver05m(j) = abs(corrFunData(j).fDaBrauerNLinCorrOver05m);
    fDaKrierNLinCorrOver05m(j) = abs(corrFunData(j).fDaKrierNLinCorrOver05m);
    fDaIdelchikNLinCorrOver05m(j) = abs(corrFunData(j).fDaIdelchikNLinCorrOver05m);
    
end


save([add2 [caracter, '_', num2str(imax+2),'.mat']]);%,'name','datasaved', 'fanspeed', 'indata', 'pDiffV','off',...
            %    'meanoff', 'pDiffPa','pDiffPaMean','pDiffVMeanPlot','v1','t', 'corrFunData', '-mat'); %
%%
%get Hyd Diameter
      
calcHydDiamData(1)= calcHydDiam(indata, ReLinCorrOver1mNoD, fDaExpLinCorrOver1mNoD);      %1L
calcHydDiamData(2)= calcHydDiam(indata, ReNLinCorrOver1mNoD, fDaExpNLinCorrOver1mNoD);    %1NL 
calcHydDiamData(3)= calcHydDiam(indata, ReLinCorrOver09mNoD, fDaExpLinCorrOver09mNoD);      %09L
calcHydDiamData(4)= calcHydDiam(indata, ReNLinCorrOver09mNoD, fDaExpNLinCorrOver09mNoD);    %09NL  
calcHydDiamData(5)= calcHydDiam(indata, ReLinCorrOver08mNoD, fDaExpLinCorrOver08mNoD);      %08L
calcHydDiamData(6)= calcHydDiam(indata, ReNLinCorrOver08mNoD, fDaExpNLinCorrOver08mNoD);    %08NL  
calcHydDiamData(7)= calcHydDiam(indata, ReLinCorrOver05mNoD, fDaExpLinCorrOver05mNoD);      %05L
calcHydDiamData(8)= calcHydDiam(indata, ReNLinCorrOver05mNoD, fDaExpNLinCorrOver05mNoD);    %05NL  

dHydSugSum = 0;
i=2;
 for i=2:2:8
    dHydSugSum  = calcHydDiamData(i).dHyd + dHydSugSum;
 end
dHydSug = dHydSugSum/4;

i=1;
k=1;
%dHydVec = [dHydErg,dHydKeys,dHydCarman,dHydBrauer,dHydKrier,dHydIdelchik]; 
dHydOverSSE = zeros(1,6);
oneOverSSE = zeros(1,6);
for k=1:6
 for i=1:8
 dHydOverSSE(k) = calcHydDiamData(i).dHydVec(k)/calcHydDiamData(i).SSEMinVec(k) +  dHydOverSSE(k);
    oneOverSSE(k)  = 1/calcHydDiamData(i).SSEMinVec(k) + oneOverSSE(k);
     
 end
 dHyd(k)= dHydOverSSE(k)/oneOverSSE(k);
end

dHydMeanRow = mean(dHyd);


dHydColSum = 0;
i=1;
 for i=1:7
    dHydColSum  = calcHydDiamData(i).dHyd + dHydColSum;
 end
dHydMeanCol = dHydColSum/7;

%disp([fname,': Average coefficient of friciton pre-shear is ',num2str(avgMuR1(ii,1))]);
save([add2 [caracter, '_', num2str(imax+3),'.mat']]);%,'name','datasaved', 'fanspeed', 'indata', 'pDiffV','off',...
            %    'meanoff', 'pDiffPa','pDiffPaMean','pDiffVMeanPlot','v1','t', 'corrFunData', '-mat'); %

%%
%plot

j=1;
for j=1:imax
    
        %get deltaP5 (0.1m) as gaussian exstimation
    dP01MMean1 = deltaP5Estimation(corrFunData(j).dP1MMean,corrFunData(j).dP9MMean,corrFunData(j).dP8MMean,corrFunData(j).dP5MMean);   
    corrFunData(j).dP01MMean = dP01MMean1;
    
    
   ca{1} = sprintf('%-35s %+10d %-4s', 'Measurement time:', sampleTime, 's');  
   ca{2} = sprintf('%-35s %+10.3d %-4s', 'Mean ambient temperature:', corrFunData(j).Tm, 'K');
   ca{3} = sprintf('%-35s %+10.3d %-4s', 'Measured gas flow rate', corrFunData(j).vflMean, 'm^3/s');
   ca{4} = sprintf('%-35s %+10.3d %-4s %20.1f %-30s', 'Measured superficial gas velocity:', ...
            corrFunData(j).vTuyKnowMean,'m/s',pDiffVMeanPlot(j), '% of measuring range final value');
   ca{5} = sprintf('%+32s','Area of circle with d =', indata.dTuyKnow, 'm');  
   
   ca{8} = sprintf('%-35s %+10.3d %-4s %20.1f %-30s', 'Mean pressure drop over 1m', ...
            corrFunData(j).dP1MMean, 'Pa', corrFunData(j).dP1MInVoltPlot, ...
            '% of measuring range final value');
   ca{9} = sprintf('%-35s %+10.3d %-4s %20.1f %-30s', 'Mean pressure drop over 0.9m', ...
            corrFunData(j).dP9MMean, 'Pa', corrFunData(j).dP9DMInVoltPlot, ...
            '% of measuring range final value');
   ca{10} = sprintf('%-35s %+10.3d %-4s %20.1f %-30s', 'Mean pressure drop over 0.8m',...
            corrFunData(j).dP8MMean, 'Pa', corrFunData(j).dP8DMInVoltPlot, ...
       '% of measuring range final value');
  ca{11} = sprintf('%-35s %+10.3d %-4s %20.1f %-30s', 'Mean pressure drop over 0.5m',...
            corrFunData(j).dP5MMean, 'Pa', corrFunData(j).dP5DMInVoltPlot,...
          '% of measuring range final value');      
        
   % Displaying 
    disp(' '); 
    disp('--------------'); 
    disp(ca{1});
    disp(ca{2});
    disp(ca{3});
    disp(ca{4});
    disp(ca{5});
    disp(ca{6});
    disp(ca{7});
    disp(ca{8}); 
    disp(ca{9}); 
    disp(ca{10}); 
    disp(ca{11}); 
    disp('--------------');
    disp(' ');     
   
    
end



figure(1)
plot(ReLinCorrOver1m,      fDaExpLinCorrOver1m,     '-xm',...  );,...
     ReLinCorrOver1m,      fDaErgunLinCorrOver1m,   '-xc',...
     ReLinCorrOver1m,      fDaKaysLinCorrOver1m,    '-xr',...
     ReLinCorrOver1m,      fDaCarmanLinCorrOver1m,  '-xg',...
     ReLinCorrOver1m,      fDaBrauerLinCorrOver1m,  '-xb',...
     ReLinCorrOver1m,      fDaKrierLinCorrOver1m,   '-xy',...
     ReLinCorrOver1m,      fDaIdelchikLinCorrOver1m,'-xk');
legend('exp','Ergun','Kays','Carman','Brauer','Krier','Idelchick')
title('LinCorrOver1m')
xlabel('Re')
ylabel('f')

 
figure(2)
plot(ReNLinCorrOver1m,      fDaExpNLinCorrOver1m,     '-mx',...  );,...
     ReNLinCorrOver1m,      fDaErgunNLinCorrOver1m,   '-cx',...
     ReNLinCorrOver1m,      fDaKaysNLinCorrOver1m,    '-rx',...
     ReNLinCorrOver1m,      fDaCarmanNLinCorrOver1m,  '-gx',...
     ReNLinCorrOver1m,      fDaBrauerNLinCorrOver1m,  '-bx',...
     ReNLinCorrOver1m,      fDaKrierNLinCorrOver1m,   '-yx',...
     ReNLinCorrOver1m,      fDaIdelchikNLinCorrOver1m,'-kx');
legend('exp','Ergun','Kays','Carman','Brauer','Krier','Idelchick')
title('NLinCorrOver1m')
xlabel('Re')
ylabel('f')
 
figure(3)
plot(ReLinCorrOver09m,      fDaExpLinCorrOver09m,     '-mx',...  );,...
     ReLinCorrOver09m,      fDaErgunLinCorrOver09m,   '-cx',...
     ReLinCorrOver09m,      fDaKaysLinCorrOver09m,    '-rx',...
     ReLinCorrOver09m,      fDaCarmanLinCorrOver09m,  '-gx',...
     ReLinCorrOver09m,      fDaBrauerLinCorrOver09m,  '-bx',...
     ReLinCorrOver09m,      fDaKrierLinCorrOver09m,   '-yx',...
     ReLinCorrOver09m,      fDaIdelchikLinCorrOver09m,'-kx');
legend('exp','Ergun','Kays','Carman','Brauer','Krier','Idelchick')
title('LinCorrOver09m')
xlabel('Re')
ylabel('f')
 
figure(4)
plot(ReNLinCorrOver09m,      fDaExpNLinCorrOver09m,     '-mx',...  );,...
     ReNLinCorrOver09m,      fDaErgunNLinCorrOver09m,   '-cx',...
     ReNLinCorrOver09m,      fDaKaysNLinCorrOver09m,    '-rx',...
     ReNLinCorrOver09m,      fDaCarmanNLinCorrOver09m,  '-gx',...
     ReNLinCorrOver09m,      fDaBrauerNLinCorrOver09m,  '-bx',...
     ReNLinCorrOver09m,      fDaKrierNLinCorrOver09m,   '-yx',...
     ReNLinCorrOver09m,      fDaIdelchikNLinCorrOver09m,'-kx');
legend('exp','Ergun','Kays','Carman','Brauer','Krier','Idelchick')
title('NLinCorrOver09m')
xlabel('Re')
ylabel('f')
 
figure(5)
plot(ReLinCorrOver08m,      fDaExpLinCorrOver08m,     '-mx',...  );,...
     ReLinCorrOver08m,      fDaErgunLinCorrOver08m,   '-cx',...
     ReLinCorrOver08m,      fDaKaysLinCorrOver08m,    '-rx',...
     ReLinCorrOver08m,      fDaCarmanLinCorrOver08m,  '-gx',...
     ReLinCorrOver08m,      fDaBrauerLinCorrOver08m,  '-bx',...
     ReLinCorrOver08m,      fDaKrierLinCorrOver08m,   '-yx',...
     ReLinCorrOver08m,      fDaIdelchikLinCorrOver08m,'-kx');
legend('exp','Ergun','Kays','Carman','Brauer','Krier','Idelchick')
title('LinCorrOver08m')
xlabel('Re')
ylabel('f')
 
figure(6)
plot(ReNLinCorrOver08m,      fDaExpNLinCorrOver08m,     '-mx',...  );,...
     ReNLinCorrOver08m,      fDaErgunNLinCorrOver08m,   '-cx',...
     ReNLinCorrOver08m,      fDaKaysNLinCorrOver08m,    '-rx',...
     ReNLinCorrOver08m,      fDaCarmanNLinCorrOver08m,  '-gx',...
     ReNLinCorrOver08m,      fDaBrauerNLinCorrOver08m,  '-bx',...
     ReNLinCorrOver08m,      fDaKrierNLinCorrOver08m,   '-yx',...
     ReNLinCorrOver08m,      fDaIdelchikNLinCorrOver08m,'-kx');
legend('exp','Ergun','Kays','Carman','Brauer','Krier','Idelchick')
title('NLinCorrOver08m')
xlabel('Re')
ylabel('f')
 
figure(7)
plot(ReLinCorrOver05m,      fDaExpLinCorrOver05m,     '-mx',...  );,...
     ReLinCorrOver05m,      fDaErgunLinCorrOver05m,   '-cx',...
     ReLinCorrOver05m,      fDaKaysLinCorrOver05m,    '-rx',...
     ReLinCorrOver05m,      fDaCarmanLinCorrOver05m,  '-gx',...
     ReLinCorrOver05m,      fDaBrauerLinCorrOver05m,  '-bx',...
     ReLinCorrOver05m,      fDaKrierLinCorrOver05m,   '-yx',...
     ReLinCorrOver05m,      fDaIdelchikLinCorrOver05m,'-kx');
legend('exp','Ergun','Kays','Carman','Brauer','Krier','Idelchick')
title('LinCorrOver05m')
xlabel('Re')
ylabel('f')

figure(8)
plot(ReNLinCorrOver05m,      fDaExpNLinCorrOver05m,     '-mx',...  );,...
     ReNLinCorrOver05m,      fDaErgunNLinCorrOver05m,   '-cx',...
     ReNLinCorrOver05m,      fDaKaysNLinCorrOver05m,    '-rx',...
     ReNLinCorrOver05m,      fDaCarmanNLinCorrOver05m,  '-gx',...
     ReNLinCorrOver05m,      fDaBrauerNLinCorrOver05m,  '-bx',...
     ReNLinCorrOver05m,      fDaKrierNLinCorrOver05m,   '-yx',...
     ReNLinCorrOver05m,      fDaIdelchikNLinCorrOver05m,'-kx');
legend('exp','Ergun','Kays','Carman','Brauer','Krier','Idelchick')
title('NLinCorrOver05m')
xlabel('Re')
ylabel('f')
 



disp([name,': mean Hydraulic diameters are: ']);
disp( [ 'dHydSug = ',num2str(dHydSug)]); % [           'dHydSug = ',num2str(dHydMeanCol)]
disp( [ 'dHydMeanRow = ',num2str(dHydMeanRow)]);
disp( [ 'dHydMeanCol = ',num2str(dHydMeanCol)]);
 save([add2 [caracter, '_', num2str(imax+4),'.mat']],'name','datasaved', 'fanspeed', 'indata', 'pDiffV','off',...
                'meanoff', 'pDiffPa','pDiffPaMean','pDiffVMeanPlot','v1','t', ...
                'corrFunData', 'dHydSug', 'dHydMeanRow', 'dHydMeanCol','-mat'); %

save([add2 [caracter, '_', num2str(imax+5),'.mat']]);

%save the file for simulation comparison
add3 = [add2,'exp_params'];
timeSim = [0.01:.01:0.11]';
A(:,1)=timeSim;

ijk = 1;

for ijk = 1:11
    A(ijk,2) = corrFunData(ijk).vTuyKnowMean;
    A(ijk,3) = corrFunData(ijk).dP01MMean;
end

fileID = fopen(add3,'w');
fprintf(fileID,'%4s %9s %11s\n','#Time','U','PressureDrop');
ijk = 1;
for ijk = 1:11
fprintf(fileID,'%1.2f %1.9f %1.9f\n',A(ijk,:));
end
fclose(fileID);

add4 = [add2,[caracter,'_','exp_params.txt']];

fileID2 = fopen(add4,'w');
formatSpec = 'BedLength is %4.4f meters \n';
fprintf(fileID2,formatSpec,indata.tubeTotalLength);
formatSpec = 'BedDiameter is %4.4f meters \n';
fprintf(fileID2,formatSpec,indata.dPlexiTube);
formatSpec = 'ParticleMass is %4.4f kg \n';
fprintf(fileID2,formatSpec,indata.particleWeight);
formatSpec = 'Porosity is %4.4f\n';
fprintf(fileID2,formatSpec,indata.porosity);
formatSpec = 'dHydSug is %4.4f m\n';
fprintf(fileID2,formatSpec,dHydSug);
formatSpec = 'dHydMeanRow is %4.4f m\n';
fprintf(fileID2,formatSpec,dHydMeanRow);
formatSpec = 'dHydMeanCol is %4.4f m\n';
fprintf(fileID2,formatSpec,dHydMeanCol);
fclose(fileID2);

save([add2 [caracter, '_', num2str(imax+6),'.mat']]);