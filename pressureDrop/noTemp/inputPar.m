function [indata2] = inputPar() 
%% ---- Channels ----  

% AI0: gas flow rate measurement
% AI1 - AI4: pressure drop 
% -> AI1: 1     m
% -> AI2: 0.9   m 
% -> AI3: 0.8   m 
% -> AI4: 0.5   m
% AI5: ambient temperature measurement 
% function [trota3] = myfun(trota4)
% 
% trota3 = trota4*2;
% 
% end

%% ---- Flags ---- 

offsetflag = 0; % 1: offset measurement, 0: not 
saveFlag = 0; % 1: write to excel-file (.xls file must exist!) 0: not 

%% ---- Init ---- 

% Measurement parameters 
indata2.sampleTime = 10;                  % Sample time in s
%indata2.sampleTime = 10;                  % Sample time in s

%make a input selection for sampleTime, suggest 10 s for normal and 10
%minutes= 600 s for temp exp

indata2.offsetSampleTime = 5;             % Offset Sample time in s (only for offset measurement)  
indata2.sampleFrequency = 1000;           % Sample Frequency in Hz
indata2.sampleFrequencyForTemp = 2.5;     % sample frequency - NI 9211 (Thermo Coupling) 
                                          % tolerates only low frequencies 
indata2.dTuyMeasure = 0.0284;             % Diameter of tube where velocity is measured in m 
indata2.dTuyKnow = input('Diameter of tube where velocity is wanted to be known in m (e.g. 0.1 or 0.14) \n');    %0.100;                 % Diameter of tube where velocity is wanted to be known in m
indata2.dPlexiTube = input('Diameter of the Inner Plexi-Tube in m (e.g. 0.1 or 0.14) \n');                       %0.100;               % Inner diameter Plexi-Tube
indata2.dHTTube = input('Diameter of the Inner HT-Tube in m (e.g. 0.1046 or 0.14) \n');                       %0.1046;                  % Diameter of the HT tube in m  %input(' (e.g. 0.1046) \n'); 
indata2.lengthHTTube = input('Length of the HT tube in m (e.g. 0.365 or ??) \n');                       %0.365;             % Length of the HT tube in m

indata2.particleType = input('kind of particle inside the spheres \n','s');
indata2.name = input('test + number \n','s');
%voltage = input('voltage on the power supply \n');
indata2.particleWeight = input('weight of the particles inside the setup in kg \n');
indata2.particleDensity = input('particle density of the material inside the setup in kg/m3 \n');


indata2.tubeTotalLength = input('Total Length of the filled tube in m (e.g. 1.30) \n'); 
indata2.lengthPlexiTube = indata2.tubeTotalLength - indata2.lengthHTTube;
indata2.volume = (indata2.dHTTube/2)^2*pi*indata2.lengthHTTube + ...
                 (indata2.dPlexiTube/2)^2*pi*indata2.lengthPlexiTube; %total volume of the tube

indata2.rho = 1.1644;                      % AIR density in kg/m^3 AT 30 degrees celsius

indata2.porosity = 1 - (indata2.particleWeight/indata2.particleDensity)/indata2.volume;
indata2.voidRatio = indata2.porosity /(1 -indata2.porosity);
% %%
tAmb = input('ambient temperature in celsius \n');
indata2.manroomTemp = tAmb;
indata2.temperaturecorr.kelvin = 273.15;
indata2.temperaturecorr.celsius = 100; %+273.15;
indata2.TAmb = tAmb + indata2.temperaturecorr.kelvin;
% 
% vHigh = 2.1;        %1.6 = 50�Celsius or 2.4 = 120�Celsius           
% % "Temp Control" box works with input voltages from (1 ... 5) V. 1V means no
% % power drain to the heating element, except a small leak drain due to
% % irregularities of the power controller. 
% % Use "vHigh" to adjust the power consumption during the experiment
% vLow = 1;
% % Use "vLow" to adjust the power consumption before an after the experiment
% % (Matlab can only hold a constant analog output value during a started
% % session. You can not change analog output values while a session is
% % running. This (and many more options) would be possible if the "NI
% 6008" had a "clock" feature. 

%%

% Constants for velocity correction 
% http://www.systemdesign.ch/index.php?title=Barometrische_H%C3%B6henformel 
indata2.p0 = 102550; 
indata2.h0 =  8430;
indata2.h = 265;
indata2.R = 287.1;


indata2.saveFlag = input('Do you want to write an excel file? \n 0 = no \n 1 = yes \n');

    if indata2.saveFlag==1
        %indata2.fileName='\limestone7.xlsx';
        indata2.fileName=[input('Name of the excel file without extension where data is written to \n','s'),'.xlsx'];
    else
    end

indata2.saveFlag;
  



%fan speed
fanspeed2perc = input('speed for the offset of the fan in % \n'); % 1.0;
indata2.fanspeed = fanspeed2perc/100;

%Offset correction, "V" stands for voltage  
% sensor: 0 ... 1250 Pa 
% sensor_output: 0.25 ... 4.25 V 

% sensor: 0 ... 250 Pa 
% sensor_output: 2.25 ... 4.25 V

% sensor: 0 ... 250 Pa 
% sesnor_output: 0.25 ... 4.25 V 

pVelMax = 250; % [Pa]
VMax = 4;    % [V] 

indata2.pVelMax = 250; % [Pa]
indata2.VMax = 4;    % [V] 

%%
%corrections
%corrFunData2.v2 = sqrt(indata3.tempcorr*abs(pDiffPa2).*corrFunData2.T);
%v2 = sqrt(abs(pDiffPa).*2.*R.*T./(p0*(1-0.4/1.4*h/h0)^(1.4/0.4)));
%v2 = sqrt(abs(pDiffPa).*2.*R.*T./(p0*(1-0.4/1.4*h/h0)^(1.4/0.4)));
indata2.tempcorr = 2*indata2.R/(indata2.p0*(1-0.4/1.4*indata2.h/indata2.h0)^(1.4/0.4));
indata2.tuyArea = (indata2.dTuyMeasure^2*pi/4); 
indata2.tuyAreaKnow = indata2.dTuyMeasure^2/indata2.dTuyKnow^2; %% Velocity @ exit point correction


%% Differential Pressure 

% Funktioniert sehr ungenau 
% sensor_input: 0 ... 5 bar (500000 Pa) 
% senor_output: 0.5 ... 4 V 

% sensor_input: 0 ... 2 bar 
% sensor_output: 0.5 ... 4.5 V 

% sensor_input: 0 ... 1 bar 
% sensor_output: 0.5 ... 4.5 V 

% sensor_input: 0 ... 7500 Pa 
% sensor_output: 2.25 ... 4.25 V

% sensor_input: 0 ... 2500 Pa 
% sensor_output: 2.25 ... 4.25 V

% Sensor #1 - Misst �ber die Strecke von 1m und hat 0 ... 200 mbar range

indata2.pMax1M = 20000; % [Pa]
indata2.vMax1M = 4;    % [V] 


% Sensor #2 - Misst �ber die Strecke von 9dm und hat 0 ... 200 mba range

indata2.pMax9DM = 20000; % [Pa]
indata2.vMax9DM = 4;    % [V] 


% Sensor #3 - Misst �ber die Strecke von 8 dm und hat 0 ... 200 mba range

indata2.pMax8DM = 20000; % [Pa]
indata2.vMax8DM = 4;    % [V] 


% Sensor #4 - Misst �ber die Strecke von 5dm und hat 0 ... 200 mbar range
% (bidirectional!) 

indata2.pMax5DM = 20000; % [Pa]
indata2.vMax5DM = 2;    % [V] 




    %%
    %Correction factors	
    indata2.corr1 = 0.977835393;
    indata2.corr09	= 0.975418241;
    indata2.corr08	= 0.972409384;
    indata2.corr05	= 0.956399605;
%     linearCorrPoly	(s*x + i)*x
    indata2.s = 0.104;
    indata2.i = 0.5927;
%     nonLinearCorrPoly 	(a*x^b+c)*x
    indata2.a = -0.001002;
    indata2.b = -2.408;
    indata2.c = 0.7063;
    
    %%
%    Parameters for Friction Factor 		
    indata2.L = 1;
    indata2.L01 = 1;
    indata2.L09 = 0.9;
    indata2.L08 = 0.8;
    indata2.L05 = 0.5;
    %indata3.rho            rhoG	1.1644 
    indata2.nuG = 1.59E-05;
    indata2.muG = 1.85E-05;
    indata2.dPart = 0.002424;
    indata2.phiP = 1;
    indata2.rhoP = 2500;

%%
    % Stepwidth the hydraulic diameter is stepped through in m 
    indata2.step = 0.00001;  
    % Value range where hydraulic diameter with minimal SSE shall be in in m
    indata2.diamRange.init = 0.0001;
    indata2.diamRange.end = 0.010;
    indata2.diamRange.vector = indata2.diamRange.init:indata2.step:indata2.diamRange.end;  
    indata2.diamRange.length = length(indata2.diamRange.vector);
    
    
%%
end
