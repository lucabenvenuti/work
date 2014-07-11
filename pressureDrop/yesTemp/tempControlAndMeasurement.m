% Temperature Control and Measurement 
% ------------------------------------
% Thermo Cell Experiment: 
%   Measuring the temperature change in a packed particle bed while gas is
%   blown in. 
% subsidiary file of mainPressure, needed to check the temperature
% % Data Aquisition script; testetd with NI USB 6008 under matlab 2013, x32.
% 1 amplifiers used
% By Nikolaus Doppelhammer & Luca Benvenuti
% February 2014
% v4

close all;  
clc;
clearvars -except off;  

%% ----- Flags -----

offsetFlag = 1; %1: offset measurement, 0: not 
saveFlag = 0; % not implemented yet 
roomTempFlag = 1; %1: Room temperature is measured, 0: Enter room temp manually only for check

%% ----- Init -----

offsetSampleTime = 5;             % only necessary when offsetFlag = 1 
sampleTime = 60*10;               % measurement time 
sampleFrequency = 2.5;            % sample frequency - NI 9211 (Thermo Coupling) 
                                  % tolerates only low frequencies 


% Velocity Calculation 
dTuyMeasure = 0.0284;             % Diameter of tube where velocity is measured in m 
dTuyKnow = 0.100;                 % Diameter of tube where velocity is wanted to be known in m 
rho = 1.184;                      % AIR Gas density in kg/m^3 
dPlexiTube = 0.100;               % Inner diameter Plexi-Tube
dHTTube = 0.1046;                  % Diameter of the HT tube in m  %input(' (e.g. 0.146) \n'); 
lengthHTTube = 0.365;             % Length of the HT tube in m

%% Input
particleType = input('kind of particle inside the spheres \n','s');
name = input('test + number \n','s');
%voltage = input('voltage on the power supply \n');
particleWeight = input('weight of the particles inside the setup in kg \n');
particleDensity = input('particle density of the material inside the setup in kg/m3 \n');


tubeTotalLength = input('Total Length of the filled tube in m (e.g. 1.30) \n'); 
lengthPlexiTube = tubeTotalLength - lengthHTTube;
volume = (dHTTube/2)^2*pi*lengthHTTube + ...
                 (dPlexiTube/2)^2*pi*lengthPlexiTube; %total volume of the tube


% Constants for velocity correction 
% http://www.systemdesign.ch/index.php?title=Barometrische_H%C3%B6henformel 
%manRoomTemp = 25; % [C�], only necessary if roomTempFlag = 0 
tAmb = input('ambient temperature in celsius \n');
manroomTemp = tAmb;
temperaturecorr.kelvin = 273.15;
temperaturecorr.celsius = 100; %+273.15;
TAmb = tAmb + temperaturecorr.kelvin;

vHigh = input('voltage power to the heating element [1-5] (e.g. 2.1) ==> ~120 degrees celsius \n'); %2.1;                        
% "Temp Control" box works with input voltages from (1 ... 5) V. 1V means no
% power drain to the heating element, except a small leak drain due to
% irregularities of the power controller. 
% Use "vHigh" to adjust the power consumption during the experiment
vLow = 1;
% Use "vLow" to adjust the power consumption before an after the experiment
% (Matlab can only hold a constant analog output value during a started
% session. You can not change analog output values while a session is
% running. This (and many more options) would be possible if the "NI
% 6008" had a "clock" feature. 

p0 = 102550; 
h0 =  8430;
h = 265;
R = 287.1;

% Plot settings 
lineWidth = 2;
axesSize = 13;
labelSize = 13;

%% ----- Initialising and Measuring----- 

disp('Initialising and Measuring ... ');

if (offsetFlag == 1)
    offTemp = makeAnalogDAQSession4OffsetMeas('ni','dev2',offsetSampleTime, sampleFrequency);  
    disp(['Measuring offset:' blanks(1) strcat(num2str(offsetSampleTime),' seconds remaining ...')]);
    disp('Mean offset values of channels: '); 
    mean(offTemp)
    disp('Offset measured. Power-on raceway and press any key to continue measuring.')
    pause;
else 
    disp('Offset has not been measured! Previous offset values are taken.')
end 
 
fanspeed2perc = input('speed of the fan in % \n'); % 1.0;
fanspeed = fanspeed2perc/100;

disp(['Starting measurement:' blanks(1) strcat(num2str(sampleTime),' seconds remaining ...')]);
[sOut,sIn] = makeAnalogDAQSession4TempMeas('ni','dev2','cDAQ2Mod1', sampleTime, sampleFrequency);

sOut.outputSingleScan(vHigh); 
data = sIn.startForeground();
sOut.outputSingleScan(vLow);
sampleTime = sIn.DurationInSeconds; 

clear sOut; 
clear sIn; 

temp140cm = data(:,1); 
tempBotMid = data(:,2);
tempBotWall = data(:,3); 
temp10cm = data(:,4); 
disp(''); 
disp('Done.');

%% Calculating Velocity 

%Offset correction, "V" stands for voltage  
pDiffV = data(:,5) - mean(offTemp);  

% sensor: 0 ... 1250 Pa 
% sensor_output: 0.25 ... 4.25 V 

% sensor: 0 ... 250 Pa 
% sensor_output: 2.25 ... 4.25 V

% sensor: 0 ... 250 Pa 
% sesnor_output: 0.25 ... 4.25 V 

pVelMax = 250; % [Pa]
VMax = 4;    % [V] 
pDiffPa = pDiffV*pVelMax/VMax; % Differetial pressure [Pa] 
pDiffPaMean = mean(pDiffPa);

if (mean(pDiffV) > 0.95*VMax) 
    warning('Sensor for veloctiy measurement has reached over 95% of its measuring range'); 
end 

% evaluation of velocity without temperatur compensation 

v1 = sqrt(2*abs(pDiffPaMean)/rho); % [m/s] 

% correction of pressure with temperature and height (Taking constant room
% temperature for this, if measurment of temperature not available!) 
% z.B.:  http://www.systemdesign.ch/index.php?title=Barometrische_H%C3%B6henformel

T = data(:,6)*100+273.15;
% Manual Temp: T = ones(length(data(:,1)),1)*manRoomTemp+273.15; 
Tm= mean(T);
v2 = sqrt(abs(pDiffPa).*2.*R.*T./(p0*(1-0.4/1.4*h/h0)^(1.4/0.4)));
v2m = sqrt(pDiffPaMean*2*R*Tm/(p0*(1-0.4/1.4*h/h0)^(1.4/0.4)));

vfl = v2.*(dTuyMeasure^2*pi/4); % Volumetric Flow Rate in m^3/s calculated with temp. correction 
vTuyKnow = v2.*dTuyMeasure^2/dTuyKnow^2; % Velocity @ exit point
vTuyKnowMean = mean(vTuyKnow); 
vflMean = v2m*(dTuyMeasure^2*pi/4);  

%% ----- Plotting -----  

t = 0:sampleTime/(length(temp140cm)-1):sampleTime; 
figure(1); 
subplot(1,2,1); 
h = plot(t,temp140cm,t,tempBotWall,t,tempBotMid,t,temp10cm);
hold on; 
plot(t,ones(length(t))*mean(T)-273.15,'LineStyle','--','Color','red'); 
hold off; 
set(h,'LineWidth',lineWidth);
set(gca,'fontsize',axesSize);
grid on; 
xlabel('time [s]','FontSize',labelSize);  
ylabel('Temperature [C�]','FontSize',labelSize); 
legend('140cm (TC)', 'Bottom middle (TC)','Bottom wall (TC)','10cm (TC)','Ambient (LM35)','Location', 'SouthEast'); 
title('Temperature Measurement','FontSize',labelSize); 
subplot(1,2,2); 
h = plot(t,vTuyKnow);
set(h,'LineWidth',lineWidth);
set(gca,'fontsize',axesSize);
grid on; 
xlabel('time [s]','FontSize',labelSize);  
ylabel('Superficial velocity [m/s]','FontSize',labelSize);  
title('Velocity Measurement','FontSize',labelSize); 
legend('Location', 'SouthEast'); 

%save the plotted image
saveas(1,name, 'tiffn')

%% Saving the data obtained
save([name,'_',particleType,'.mat'],'name','offsetSampleTime','sampleTime', 'sampleFrequency', ...
        'vHigh', 'vLow', ...
        'dTuyMeasure', 'dTuyKnow', 'rho', 'dPlexiTube', 'dHTTube', 'lengthHTTube', 'particleType', ...
        'particleWeight', 'particleDensity', 'tubeTotalLength', 'lengthPlexiTube', 'volume', 'tAmb', ...
        'TAmb', 'p0', 'h0', 'h', 'R', 'fanspeed', 'data', 'temp140cm', 'tempBotMid', 'tempBotWall', ...
        'temp10cm', 'pDiffV', 'pVelMax', 'VMax', 'pDiffPa', 'pDiffPaMean', 'v1', 'T', 'Tm', 'v2', ...
        'v2m', 'vfl', 'vTuyKnow', 'vTuyKnowMean', 'vflMean');




%% ----- Displaying ----- 

ca{1} = sprintf('%-43s %+10d %-4s', 'Measurement time:', sampleTime, 's');  
ca{2} = sprintf('%-43s %+10.3d %-4s', 'Mean gas flow rate:', vflMean, 'm^3/s');
ca{3} = sprintf('%-43s %+10.3d %-4s %20.1f %-30s', 'Mean superficial gas velocity:', vTuyKnowMean,'m/s', max(pDiffV)/VMax*100, '% of max measured value / measuring range final value');
ca{4} = sprintf('%+32s','Area of circle with d = 0.1 m'); 
ca{5} = sprintf('%-43s %+10.3d %-4s', 'Mean room temperature (LM35):', mean(T) - 273.15, '�C');
ca{6} = sprintf('%-43s %+10.3d %-4s', 'Mean temperature at 140cm (TC Type K):',mean(temp140cm), '�C');
ca{7} = sprintf('%-43s %+10.3d %-4s', 'Mean temperature bottom middle (TC Type K):',mean(tempBotMid), '�C');
ca{8} = sprintf('%-43s %+10.3d %-4s', 'Mean temperature bottom wall (TC Type K):',mean(tempBotWall), '�C');
ca{9} = sprintf('%-43s %+10.3d %-4s', 'Mean temperature at 10cm (TC Type K):',mean(temp10cm), '�C');

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
disp('--------------');
disp(' ');



