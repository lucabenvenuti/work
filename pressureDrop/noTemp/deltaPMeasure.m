%% Pressure Measurement - Preassure Drop in a Packed Bed  

close all;  
clearvars -except off;  
%% ---- Channels ----  

% AI0: gas flow rate measurement
% AI1 - AI4: pressure drop 
% -> AI1: 1     m
% -> AI2: 0.9   m 
% -> AI3: 0.8   m 
% -> AI4: 0.5   m
% AI5: ambient temperature measurement 

%% ---- Flags ---- 

offsetflag = 0; % 1: offset measurement, 0: not 
saveFlag = 0; % 1: write to excel-file (.xls file must exist!) 0: not 

%% ---- Init ---- 

% Measurement parameters 
sampleTime = 10;                  % Sample time in s
offsetSampleTime = 5;             % Offset Sample time in s (only for offset measurement)  
sampleFrequency = 1000;           % Sample Frequency in Hz
dTuyMeasure = 0.0284;             % Diameter of tube where velocity is measured in m 
dTuyKnow = 0.100;                 % Diameter of tube where velocity is wanted to be known in m 

rho = 1.184;                      % Gas density in kg/m^3 

% Constants for velocity correction 
% http://www.systemdesign.ch/index.php?title=Barometrische_H%C3%B6henformel 
p0 = 102550; 
h0 =  8430;
h = 265;
R = 287.1;

% Name of file where data is written to  
fileName='\mono_pp2_1275_v3.xlsx';

%% Initialising and Measuring 

if (offsetflag == 1)
    ai = startAI4PressureDrop('nidaq','Dev2',sampleFrequency,offsetSampleTime);
    disp(['Measuring offset:' blanks(1) strcat(num2str(offsetSampleTime),' seconds remaining ...')]);
    start(ai);
    trigger(ai); 
    wait(ai,offsetSampleTime+3)
    off = getdata(ai);
    disp('Mean offset values of channels: '); 
    mean(off)
    disp('Offset measured. Power-on raceway and press any key to continue measuring.')
    pause;
else 
    disp('Offset has not been measured! Previous offset values are taken.')
end 
 
disp(['Starting measurment:' blanks(1) strcat(num2str(sampleTime),' seconds remaining ...')]);
ai = startAI4PressureDrop('nidaq','Dev2',sampleFrequency,sampleTime);
disp('measuring ...')
start(ai)
trigger(ai)
wait(ai,sampleTime+3)
data = getdata(ai);
disp('finished.')

%% Calculating Velocity 

%Offset correction, "V" stands for voltage  
pDiffV = data(:,1) - mean(off(:,1));  

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

t = (1:length(v1))./sampleFrequency;

% correction of pressure with temperature and height (Taking constant room
% temperature for this, if measurment of temperature not available!) 
% z.B.:  http://www.systemdesign.ch/index.php?title=Barometrische_H%C3%B6henformel

T = data(:,6)*100+273.15;
% T = ones(length(data(:,1)),1)*25+273.15; 
Tm= mean(T);
v2 = sqrt(abs(pDiffPa).*2.*R.*T./(p0*(1-0.4/1.4*h/h0)^(1.4/0.4)));
v2m = sqrt(pDiffPaMean*2*R*Tm/(p0*(1-0.4/1.4*h/h0)^(1.4/0.4)));

vfl = v2.*(dTuyMeasure^2*pi/4); % Volumetric Flow Rate in m^3/s calculated with temp. correction 
vTuyKnow = v2.*dTuyMeasure^2/dTuyKnow^2; % Velocity @ exit point
vTuyKnowMean = mean(vTuyKnow); 
vflMean = v2m*(dTuyMeasure^2*pi/4);  

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

% Sensor #1 - Misst über die Strecke von 1m und hat 0 ... 200 mbar range

dP1MInVolt = data(:,2) - mean(off(:,2)); 
pMax1M = 20000; % [Pa]
vMax1M = 4;    % [V] 
dP1M = dP1MInVolt*pMax1M/vMax1M; % Differential pressure [Pa] 
dP1MMean = mean(dP1M);

% Sensor #2 - Misst über die Strecke von 9dm und hat 0 ... 1 bar range

dP9DMInVolt = data(:,3) - mean(off(:,3)); 
pMax9DM = 200000; % [Pa]
vMax9DM = 4;    % [V] 
dP9DM = dP9DMInVolt*pMax9DM/vMax9DM; % Differential pressure [Pa] 
dP9DMMean = mean(dP9DM);

% Sensor #3 - Misst über die Strecke von 8 dm und hat 0 ... 1 bar range

dP8DMInVolt = data(:,4) - mean(off(:,4)); 
pMax8DM = 100000; % [Pa]
vMax8DM = 4;    % [V] 
dP8DM = dP8DMInVolt*pMax8DM/vMax8DM; % Differential pressure [Pa] 
dP8DMMean = mean(dP8DM);

% Sensor #4 - Misst über die Strecke von 5dm und hat 0 ... 200 mbar range
% (bidirectional!) 
dP5DMInVolt = data(:,5) - mean(off(:,5)); 
pMax5DM = 20000; % [Pa]
vMax5DM = 2;    % [V] 
dP5DM = dP5DMInVolt*pMax5DM/vMax5DM; % Differential pressure [Pa] 
dP5DMMean = mean(dP5DM); 

%% Print Mean Data to .TXT-File 

% fileID = fopen('data_meas_close_random_packing.txt','a'); 
% fprintf(fileID,'%s %d %d %d\n', name,diffPressureInPascalMean,vflMean,vTuyKnowMean); 
% fclose(fileID);

ca{1} = sprintf('%-35s %+10d %-4s', 'Measurement time:', sampleTime, 's');  
ca{2} = sprintf('%-35s %+10.3d %-4s', 'Mean ambient temperature:', mean(T), 'K');
ca{3} = sprintf('%-35s %+10.3d %-4s', 'Measured gas flow rate', vflMean, 'm^3/s');
ca{4} = sprintf('%-35s %+10.3d %-4s %20.1f %-30s', 'Measured superficial gas velocity:', vTuyKnowMean,'m/s',mean(pDiffV)/VMax*100, '% of measuring range final value');
ca{5} = sprintf('%+32s','Area of circle with d = 0.1 m'); 
ca{8} = sprintf('%-35s %+10.3d %-4s %20.1f %-30s', 'Mean pressure drop over 1m',dP1MMean, 'Pa', mean(dP1MInVolt)/vMax1M*100, '% of measuring range final value');
ca{9} = sprintf('%-35s %+10.3d %-4s %20.1f %-30s', 'Mean pressure drop over 0.9m',dP9DMMean, 'Pa', mean(dP9DMInVolt)/vMax9DM*100, '% of measuring range final value');
ca{10} = sprintf('%-35s %+10.3d %-4s %20.1f %-30s', 'Mean pressure drop over 0.8m',dP8DMMean, 'Pa', mean(dP8DMInVolt)/vMax8DM*100, '% of measuring range final value');
ca{11} = sprintf('%-35s %+10.3d %-4s %20.1f %-30s', 'Mean pressure drop over 0.5m',dP5DMMean, 'Pa', mean(dP5DMInVolt)/vMax5DM*100, '% of measuring range final value');

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

% Save data to excel file 
if saveFlag == 1 

    if exist([pwd,fileName],'file')
        [num2, txt2,raw2] = xlsread([pwd,'\',fileName],1,'A17:E43');    % read file
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
    bedPressure=[vTuyKnowMean,dP1MMean,dP9DMMean,dP8DMMean,dP5DMMean];
    xlswrite([pwd,fileName],bedPressureDataHead,'A17:E18');
    xlswrite([pwd,fileName],bedPressure,['A',int2str(messNr+2),':E',int2str(messNr+2)]);
    
end     



