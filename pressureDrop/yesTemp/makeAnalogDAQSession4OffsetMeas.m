function off = makeAnalogDAQSession4OffsetMeas(device,deviceID, sampleTime, sampleFreq)   

sIn = daq.createSession(device); 
sIn.addAnalogInputChannel(deviceID,0,'Voltage'); 
sIn.DurationInSeconds = sampleTime;
sIn.Rate = sampleFreq; 
vel = sIn.Channels(1); 
vel.Coupling = 'DC'; 
vel.TerminalConfig = 'SingleEnded'; 
vel.Range = [-5,5]; 

off = sIn.startForeground();

clear sOut; 
clear sIn; 

end 