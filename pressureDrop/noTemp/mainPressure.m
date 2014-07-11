% mainPressure
% Pressure Measurement - Preassure Drop in a Packed Bed 
% % Data Aquisition script; testetd with NI USB 6008 + NI9211 under matlab 2013, x32.
% 2 amplifiers used
% interpolation linear and polynomial 2
% By Nikolaus Doppelhammer & Luca Benvenuti
% February 2014
% v3
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


%save offset
save([name, '_', num2str(0),'.mat'],'name','off', 'fanspeed', 'indata', 'meanoff', '-mat'); %

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
    datasaved(:,:,i)= data; %rand(25,6)*i*1.3;%

    datasavedlenght(i) = length(datasaved(:,1,i));
    disp('finished.')

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

    save([name, '_', num2str(i),'.mat'],'name','datasaved', 'fanspeed', 'indata', 'pDiffV','off',...
                'meanoff', '-mat'); %

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

save([name, '_', num2str(imax+1),'.mat'],'name','datasaved', 'fanspeed', 'indata', 'pDiffV','off',...
                'meanoff', 'pDiffPa','pDiffPaMean','pDiffVMeanPlot','v1','t','-mat'); %


j=1;

for j=1:imax
    
%     length(v1(:,j))
%     pDiffPa(:,j) = pDiffV(:,j)*pVelMax/VMax; % Differetial pressure [Pa] %vector of vector = matrix
%     pDiffPaMean(j) = pDiffVMean(j)*pVelMax/VMax; %mean(pDiffPa(:,j));  % vector of scalar = vector
% (1:length(v1(:,j)))./sampleFrequency
%((1:datasavedlenght(i))/sampleFrequency)'

    % evaluation of velocity without temperatur compensation 
    t(:,j) = ((1:datasavedlenght(i))/sampleFrequency)';%((1:length(v1(:,j)))./sampleFrequency)';
    
    data3 = datasaved(:,:,j);
    pDiffPa1 = pDiffPa(:,j);
    pDiffPaMean1 = pDiffPaMean(j);
    
    corrFunData(j) = corrFun( data3, indata, pDiffPa1, pDiffPaMean1, meanoff);
    
    vTuyKnowMean(j) = corrFunData(j).vTuyKnowMean ; 
    vflMean(j) = corrFunData(j).vflMean;
% 
% %dP9MMean
% saveFlag=1;
% % Save data to excel file 
% if saveFlag == 1 
% 
%     if exist([pwd,fileName],'file')
%         [num2, txt2,raw2] = xlsread([pwd,'\',fileName],1,'A17:E43');    % read file
%         if length(num2)==0
%             messNr=1;
%         else
%         assignin('base',char(txt2(1,1)),num2(:,1));    % assign numbers to variables
%         messNr=length(vSup1DM)+1;
%         end
%     else
%         messNr=1;
%     end
%     messNr=messNr+16;
%     bedPressureDataHead={'vSup1DM','deltaP1 (1m)','deltaP2 (0.9m)','deltaP3 (0.8m)','deltaP4 (0.5m)';'[m/s]','[Pa]','[Pa]','[Pa]','[Pa]'};
%     bedPressure=[corrFunData(j).vTuyKnowMean,corrFunData(j).dP1MMean,corrFunData(j).dP9MMean,corrFunData(j).dP8MMean,corrFunData(j).dP5MMean];
%     xlswrite([pwd,fileName],bedPressureDataHead,'A17:E18');
%     xlswrite([pwd,fileName],bedPressure,['A',int2str(messNr+2),':E',int2str(messNr+2)]);
%     
% end 




    
   % calcHydDiamData(j) = calcHydDiam( data3, indata, pDiffPa1, pDiffPaMean1, meanoff, corrFunData(j) );
    ReLinCorrOver1mNoD(j)   = corrFunData(j).ReLinCorrOver1mNoD;
    ReNLinCorrOver1mNoD(j)  = corrFunData(j).ReNLinCorrOver1mNoD;
    ReLinCorrOver09mNoD(j)  = corrFunData(j).ReLinCorrOver09mNoD;
    ReNLinCorrOver09mNoD(j) = corrFunData(j).ReNLinCorrOver09mNoD;
    ReLinCorrOver08mNoD(j)  = corrFunData(j).ReLinCorrOver08mNoD;
    ReNLinCorrOver08mNoD(j) = corrFunData(j).ReNLinCorrOver08mNoD;
    ReLinCorrOver05mNoD(j)  = corrFunData(j).ReLinCorrOver05mNoD;
    ReNLinCorrOver05mNoD(j) = corrFunData(j).ReNLinCorrOver05mNoD;
    
    fDaExpLinCorrOver1mNoD(j)   = corrFunData(j).fDaExpLinCorrOver1mNoD;
    fDaExpNLinCorrOver1mNoD(j)  = corrFunData(j).fDaExpNLinCorrOver1mNoD;
    fDaExpLinCorrOver09mNoD(j)  = corrFunData(j).fDaExpLinCorrOver09mNoD;
    fDaExpNLinCorrOver09mNoD(j) = corrFunData(j).fDaExpNLinCorrOver09mNoD;
    fDaExpLinCorrOver08mNoD(j)  = corrFunData(j).fDaExpLinCorrOver08mNoD;
    fDaExpNLinCorrOver08mNoD(j) = corrFunData(j).fDaExpNLinCorrOver08mNoD;
    fDaExpLinCorrOver05mNoD(j)  = corrFunData(j).fDaExpLinCorrOver05mNoD;
    fDaExpNLinCorrOver05mNoD(j) = corrFunData(j).fDaExpNLinCorrOver05mNoD;
end


save([name, '_', num2str(imax+2),'.mat'],'name','datasaved', 'fanspeed', 'indata', 'pDiffV','off',...
                'meanoff', 'pDiffPa','pDiffPaMean','pDiffVMeanPlot','v1','t', 'corrFunData', '-mat'); %
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


%%
%plot

j=1;
for j=1:imax
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
plot(ReLinCorrOver1mNoD,   fDaExpLinCorrOver1mNoD, '-k');,...
%     corrFunData.ReLinCorrOver1m, corrFunData.fDaErgunLinCorrOver1m, '-k',...
%     corrFunData.ReLinCorrOver1m, corrFunData.fDaKaysLinCorrOver1m, '-k',...
%     corrFunData.ReLinCorrOver1m, corrFunData.fDaCarmanLinCorrOver1m, '-k',...
%     corrFunData.ReLinCorrOver1m, corrFunData.fDaBrauerLinCorrOver1m, '-k',...
%     corrFunData.ReLinCorrOver1m, corrFunData.fDaKrierLinCorrOver1m, '-k',...
%     corrFunData.ReLinCorrOver1m, corrFunData.fDaIdelchikLinCorrOver1m, '-k');
 %legend
 %legend position
 
% figure(2)
%plot(corrFunData.ReNLinCorrOver1m, corrFunData.fDaExpNLinCorrOver1m, '-k',...
%     corrFunData.ReNLinCorrOver1m, corrFunData.fDaErgunNLinCorrOver1m, '-k',...
%     corrFunData.ReNLinCorrOver1m, corrFunData.fDaKaysNLinCorrOver1m, '-k',...
%     corrFunData.ReNLinCorrOver1m, corrFunData.fDaCarmanNLinCorrOver1m, '-k',...
%     corrFunData.ReNLinCorrOver1m, corrFunData.fDaBrauerNLinCorrOver1m, '-k',...
 %    corrFunData.ReNLinCorrOver1m, corrFunData.fDaKrierNLinCorrOver1m, '-k',...
%     corrFunData.ReNLinCorrOver1m, corrFunData.fDaIdelchikNLinCorrOver1m, '-k');
 %legend
 %legend position
 
% figure(3)
%plot(corrFunData.ReLinCorrOver09m, corrFunData.fDaExpLinCorrOver09m, 'k',...
%     corrFunData.ReLinCorrOver09m, corrFunData.fDaErgunLinCorrOver09m, 'k',...
 %    corrFunData.ReLinCorrOver09m, corrFunData.fDaKaysLinCorrOver09m, 'k',...
 %    corrFunData.ReLinCorrOver09m, corrFunData.fDaCarmanLinCorrOver09m, 'k',...
%    corrFunData.ReLinCorrOver09m, corrFunData.fDaBrauerLinCorrOver09m, 'k',...
 %    corrFunData.ReLinCorrOver09m, corrFunData.fDaKrierLinCorrOver09m, 'k',...
 %    corrFunData.ReLinCorrOver09m, corrFunData.fDaIdelchikLinCorrOver09m, 'k');
 %legend
 %legend position

% figure(4)
%plot(corrFunData.ReNLinCorrOver09m, corrFunData.fDaExpNLinCorrOver09m, 'k',...
 %    corrFunData.ReNLinCorrOver09m, corrFunData.fDaErgunNLinCorrOver09m, 'k',...
%     corrFunData.ReNLinCorrOver09m, corrFunData.fDaKaysNLinCorrOver09m, 'k',...
 %    corrFunData.ReNLinCorrOver09m, corrFunData.fDaCarmanNLinCorrOver09m, 'k',...
%     corrFunData.ReNLinCorrOver09m, corrFunData.fDaBrauerNLinCorrOver09m, 'k',...
%     corrFunData.ReNLinCorrOver09m, corrFunData.fDaKrierNLinCorrOver09m, 'k',...
%     corrFunData.ReNLinCorrOver09m, corrFunData.fDaIdelchikNLinCorrOver09m, 'k');
 %legend
 %legend position

%  figure(5)
%plot(corrFunData.ReLinCorrOver08m, corrFunData.fDaExpLinCorrOver08m, 'k',...
%     corrFunData.ReLinCorrOver08m, corrFunData.fDaErgunLinCorrOver08m, 'k',...
%     corrFunData.ReLinCorrOver08m, corrFunData.fDaKaysLinCorrOver08m, 'k',...
%%     corrFunData.ReLinCorrOver08m, corrFunData.fDaCarmanLinCorrOver08m, 'k',...
 %    corrFunData.ReLinCorrOver08m, corrFunData.fDaBrauerLinCorrOver08m, 'k',...
%     corrFunData.ReLinCorrOver08m, corrFunData.fDaKrierLinCorrOver08m, 'k',...
%     corrFunData.ReLinCorrOver08m, corrFunData.fDaIdelchikLinCorrOver08m, 'k');
 %legend
 %legend position

% figure(6)
%plot(corrFunData.ReNLinCorrOver08m, corrFunData.fDaExpNLinCorrOver08m, 'k',...
%     corrFunData.ReNLinCorrOver08m, corrFunData.fDaErgunNLinCorrOver08m, 'k',...
%     corrFunData.ReNLinCorrOver08m, corrFunData.fDaKaysNLinCorrOver08m, 'k',...
 %   corrFunData.ReNLinCorrOver08m, corrFunData.fDaCarmanNLinCorrOver08m, 'k',...
%     corrFunData.ReNLinCorrOver08m, corrFunData.fDaBrauerNLinCorrOver08m, 'k',...
 %    corrFunData.ReNLinCorrOver08m, corrFunData.fDaKrierNLinCorrOver08m, 'k',...
%     corrFunData.ReNLinCorrOver08m, corrFunData.fDaIdelchikNLinCorrOver08m, 'k');
 %legend
 %legend position

    
%  figure(7)
%plot(corrFunData.ReLinCorrOver05m, corrFunData.fDaExpLinCorrOver05m, 'k',...
%     corrFunData.ReLinCorrOver05m, corrFunData.fDaErgunLinCorrOver05m, 'k',...
%     corrFunData.ReLinCorrOver05m, corrFunData.fDaKaysLinCorrOver05m, 'k',...
 %    corrFunData.ReLinCorrOver05m, corrFunData.fDaCarmanLinCorrOver05m, 'k',...
%     corrFunData.ReLinCorrOver05m, corrFunData.fDaBrauerLinCorrOver05m, 'k',...
%     corrFunData.ReLinCorrOver05m, corrFunData.fDaKrierLinCorrOver05m, 'k',...
%     corrFunData.ReLinCorrOver05m, corrFunData.fDaIdelchikLinCorrOver05m, 'k');
 %legend
 %legend position

% figure(8)
%plot(corrFunData.ReNLinCorrOver05m, corrFunData.fDaExpNLinCorrOver05m, 'k',...
%     corrFunData.ReNLinCorrOver05m, corrFunData.fDaErgunNLinCorrOver05m, 'k',...
 %    corrFunData.ReNLinCorrOver05m, corrFunData.fDaKaysNLinCorrOver05m, 'k',...
%v     corrFunData.ReNLinCorrOver05m, corrFunData.fDaCarmanNLinCorrOver05m, 'k',...
%     corrFunData.ReNLinCorrOver05m, corrFunData.fDaBrauerNLinCorrOver05m, 'k',...
 %    corrFunData.ReNLinCorrOver05m, corrFunData.fDaKrierNLinCorrOver05m, 'k',...
 %    corrFunData.ReNLinCorrOver05m, corrFunData.fDaIdelchikNLinCorrOver05m, 'k');
 %legend
 %legend position
 



disp([name,': mean Hydraulic diameters are: ']);
disp( [ 'dHydSug = ',num2str(dHydSug)]); % [           'dHydSug = ',num2str(dHydMeanCol)]
disp( [ 'dHydMeanRow = ',num2str(dHydMeanRow)]);
disp( [ 'dHydMeanCol = ',num2str(dHydMeanCol)]);
 save([name, '_', num2str(imax+3),'.mat'],'name','datasaved', 'fanspeed', 'indata', 'pDiffV','off',...
                'meanoff', 'pDiffPa','pDiffPaMean','pDiffVMeanPlot','v1','t', ...
                'corrFunData', 'dHydSug', 'dHydMeanRow', 'dHydMeanCol','-mat'); %
