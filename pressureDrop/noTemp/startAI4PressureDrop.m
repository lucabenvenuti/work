function [ai]=startAI4PressureDrop(driver,device,samplefreq,sampletime)

disp('Creating ai object ... ')

%samplefreq  = 50000;
%sampletime  = 5;

ai = analoginput(driver,device);
ai.InputType='SingleEnded';

%disp('Valid input ranges:');
%in = daqhwinfo(ai);
%in.InputRanges

ai_ch = addchannel(ai,0,'vel'); %vel
ai_ch = addchannel(ai,1,'p1');  %p1m
ai_ch = addchannel(ai,2,'p2');  %p0.9m
ai_ch = addchannel(ai,3,'p3');  %p0.8m
ai_ch = addchannel(ai,4,'p4');  %p0.5m
ai_ch = addchannel(ai,5,'T');   %T

% skalierung der Daten mit
% scaled value = (A/D value)(units range)/(sensor range)
% default output range = 10V

ai.vel.SensorRange=[0,5]; % Ausschlag +-2V
ai.vel.InputRange=[-10,10];    
ai.vel.Units='Pa';
ai.vel.UnitsRange=[0,5];

ai.p1.SensorRange=[0,5]; % Ausschlag +-2V
ai.p1.InputRange=[-10,10];    
ai.p1.Units='Pa';
ai.p1.UnitsRange=[0,5];

ai.p2.SensorRange=[0,5];
ai.p2.InputRange=[-10,10];    
ai.p2.Units='Pa';
ai.p2.UnitsRange=[0,5];
 
ai.p3.SensorRange=[0,5]; % Ausschlag +-2V
ai.p3.InputRange=[-10,10];    
ai.p3.Units='Pa';
ai.p3.UnitsRange=[0,5];
% 
ai.p4.SensorRange=[0,5]; % Ausschlag +-2V
ai.p4.InputRange=[-10,10];    
ai.p4.Units='Pa';
ai.p4.UnitsRange=[0,5];

% LM35 Temperaturfühler
ai.T.SensorRange=[0,5];
ai.T.InputRange=[-10,10];
ai.T.Units='Temp';
ai.T.UnitsRange=[0,5];

% CTA Temperaturfühler
% ai.T.SensorRange=[0,5];
% ai.T.InputRange=[0,5];
% ai.T.Units='Temp';
% ai.T.UnitsRange=[0,150];

% ai.p_diff.SensorRange=[0,5];
% ai.p_diff.InputRange=[0,5];
% ai.p_diff.Units='Pa';
% ai.p_diff.UnitsRange=[0,5];

% ai.p.SensorRange=[0,5]; % Ausschlag +-2V
% ai.p.InputRange=[0,5];    
% ai.p.Units='Pa';
% ai.p.UnitsRange=[0,5];

% ai.F.InputRange=[0,2];
% ai.F.SensorRange=[0,2]; 
% ai.F.Units='V';
% ai.F.UnitsRange=[0,2];

%disp('Valid Sampling rates for anaolg input:');
%validRates = propinfo(ai,'SampleRate')

%ai.SampleRate = samplefreq;
%ActualRate = get(ai,'SampleRate');

samplefreq = setverify(ai,'SampleRate',samplefreq);
ai.SamplesPerTrigger = sampletime * samplefreq;

%ai.ChannelSkewMode = 'Manual';
%channelskew = setverify(ai,'ChannelSkew',0.0001);

% ai.InputType='SingleEnded';
%ground = setverify(ai,'DriveAISenseToGround','on')

%ai.InputType='NonReferencedSingleEnded';
ai.TriggerType='Manual';
end
