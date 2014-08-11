function [sOut,sIn] = makeAnalogDAQSession4TempMeas(device,deviceID,deviceIDThermoCouple,sampleTime, sampleFreq)   

sOut = daq.createSession(device); 
sIn = daq.createSession(device);
sOut.addAnalogOutputChannel(deviceID,0,'Voltage'); 
sIn.addAnalogInputChannel(deviceIDThermoCouple,[0 1 2 3],'Thermocouple');
sIn.addAnalogInputChannel(deviceID,[0 5],'Voltage'); 
sIn.DurationInSeconds = sampleTime;
sIn.Rate = sampleFreq; 

tc1 = sIn.Channels(1);
tc1.ThermocoupleType = 'K';
tc1.Units = 'Celsius';

tc2 = sIn.Channels(2);
tc2.ThermocoupleType = 'K';
tc2.Units = 'Celsius';

tc3 = sIn.Channels(3);
tc3.ThermocoupleType = 'K';
tc3.Units = 'Celsius';

tc4 = sIn.Channels(4);
tc4.ThermocoupleType = 'K';
tc4.Units = 'Celsius';

vel = sIn.Channels(5); 
vel.Coupling = 'DC'; 
vel.TerminalConfig = 'SingleEnded'; 
vel.Range = [-5,5]; 

envTemp = sIn.Channels(6); 
envTemp.Coupling = 'DC'; 
envTemp.TerminalConfig = 'SingleEnded'; 
envTemp.Range = [-5,5]; 

% sOut.outputSingleScan(vHigh); 
% data = sIn.startForeground();
% sOut.outputSingleScan(vLow);

% 
% %daq.getDevices
%  
% %s = daq.creatSession('ni');
% 
% ai.DurationInSeconds = sampleTime; 
% ai.Rate = sampleFreq; 
% data = ai.startForeground();

end 