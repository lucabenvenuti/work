function [corrFunData2] = corrFun( data2, indata3, pDiffPa2, pDiffPaMean2, meanoff2 )
%CORRFUN Summary of this function goes here
%   Detailed explanation goes here

    %%input
    offsetSampleTime = indata3.offsetSampleTime;
    sampleFrequency = indata3.sampleFrequency;
    dTuyMeasure = indata3.dTuyMeasure;
    dTuyKnow = indata3.dTuyKnow;
    rho = indata3.rho;
    particleType = indata3.particleType;
    name = indata3.name;
    particleWeight = indata3.particleWeight;
    porosity  = indata3.porosity;
    p0 = indata3.p0;
    h0 = indata3.h0;
    h = indata3.h; 
    R = indata3.R;
    fileName = indata3.fileName;
    fanspeed = indata3.fanspeed;
    pVelMax = indata3.pVelMax; % [Pa]
    VMax = indata3.VMax;    % [V] 
    tempcorr = indata3.tempcorr;
    tuyArea = indata3.tuyArea;
    tuyAreaKnow = indata3.tuyAreaKnow;
    pMax1M = indata3.pMax1M;
    vMax1M = indata3.vMax1M;
    pMax9DM = indata3.pMax9DM;
    vMax9DM = indata3.vMax9DM;
    pMax8DM = indata3.pMax8DM;
    vMax8DM = indata3.vMax8DM;
    pMax5DM = indata3.pMax5DM;
    vMax5DM = indata3.vMax5DM;
    
    %%working

    % correction of pressure with temperature and height (Taking constant room
    % temperature for this, if measurment of temperature not available!) 
    % z.B.:  http://www.systemdesign.ch/index.php?title=Barometrische_H%C3%B6henformel
    corrFunData2.T = data2(:,6)*indata3.temperaturecorr.celsius + indata3.temperaturecorr.kelvin;
    corrFunData2.Tm= mean(corrFunData2.T);
    %v2 = sqrt(abs(pDiffPa).*2.*R.*T./(p0*(1-0.4/1.4*h/h0)^(1.4/0.4)));
    %aa = pDiffPa2*2;
    corrFunData2.v2 = sqrt(indata3.tempcorr*abs(pDiffPa2(:)).*corrFunData2.T(:));
    %aa2 = pDiffPaMean2*2;
    %v2m = sqrt(pDiffPaMean*2*R*Tm/(p0*(1-0.4/1.4*h/h0)^(1.4/0.4)));
    corrFunData2.v2m = sqrt(indata3.tempcorr*abs(pDiffPaMean2)*corrFunData2.Tm);
    
    corrFunData2.vfl = corrFunData2.v2*indata3.tuyArea;  % Volumetric Flow Rate in m^3/s
                                                        %calculated with temp. correction 
    %vTuyKnow = v2.*dTuyMeasure^2/dTuyKnow^2; % Velocity @ exit point
    corrFunData2.vTuyKnow = corrFunData2.v2*indata3.tuyAreaKnow;
    corrFunData2.vTuyKnowMean = mean(corrFunData2.vTuyKnow); 
    corrFunData2.vflMean = corrFunData2.v2m*indata3.tuyArea;
    
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

    corrFunData2.dP1MInVolt = data2(:,2) - meanoff2(2); 
    
    % Differential pressure [Pa] 
    corrFunData2.dP1M = corrFunData2.dP1MInVolt*indata3.pMax1M/indata3.vMax1M; 
    
    corrFunData2.dP1MMean = mean(corrFunData2.dP1M); %Pa
    corrFunData2.dP1MInVoltPlot = mean(corrFunData2.dP1MInVolt)/indata3.vMax1M*100;
      
    
    %%
    % Sensor #2 - Misst �ber die Strecke von 9dm und hat 0 ... 1 bar range

    corrFunData2.dP9DMInVolt = data2(:,3) - meanoff2(3);
    
    % Differential pressure [Pa] 
    corrFunData2.dP9DM = corrFunData2.dP9DMInVolt*indata3.pMax9DM/indata3.vMax9DM;
    
    corrFunData2.dP9MMean = mean(corrFunData2.dP9DM); %Pa
    corrFunData2.dP9DMInVoltPlot = mean(corrFunData2.dP9DMInVolt)/indata3.vMax9DM*100;
    
    %%
    % Sensor #3 - Misst �ber die Strecke von 8 dm und hat 0 ... 1 bar range

    corrFunData2.dP8DMInVolt = data2(:,4) - meanoff2(4); 
    
    % Differential pressure [Pa] 
    corrFunData2.dP8DM = corrFunData2.dP8DMInVolt*indata3.pMax8DM/indata3.vMax8DM; 
    
    corrFunData2.dP8MMean = mean(corrFunData2.dP8DM); %Pa
    corrFunData2.dP8DMInVoltPlot = mean(corrFunData2.dP8DMInVolt)/indata3.vMax8DM*100;
    
    
    %%
    % Sensor #4 - Misst �ber die Strecke von 5dm und hat 0 ... 200 mbar range
    % (bidirectional!) 
    corrFunData2.dP5DMInVolt = data2(:,5) - meanoff2(5); 
    
    % Differential pressure [Pa] 
    corrFunData2.dP5DM = corrFunData2.dP5DMInVolt*indata3.pMax5DM/indata3.vMax5DM; 
    
    corrFunData2.dP5MMean = mean(corrFunData2.dP5DM);  %Pa
    corrFunData2.dP5DMInVoltPlot = mean(corrFunData2.dP5DMInVolt)/indata3.vMax5DM*100;
    
    
    %%
    %Correction factors	
    corrFunData2.corr1  = indata3.corr1;
    corrFunData2.corr09	= indata3.corr09; %0.975418241;
    corrFunData2.corr08	= indata3.corr08 ;%0.972409384;
    corrFunData2.corr05	= indata3.corr05 ;%0.956399605;
%     linearCorrPoly	(s*x + i)*x
    corrFunData2.s = indata3.s ;% 0.104;
    corrFunData2.i = indata3.i ;% %0.5927;
%     nonLinearCorrPoly 	(a*x^b+c)*x
    corrFunData2.a = indata3.a ; % -0.001002;
    corrFunData2.b = indata3.b ; %-2.408;
    corrFunData2.c = indata3.c ; % 0.7063;
    
    %%
%    Parameters for Friction Factor 		
    corrFunData2.L = indata3.L ; % 1;
    %indata3.rho            rhoG	1.1644 
%         indata2.L = 1;
%     indata2.L01 = 1;
%     indata2.L09 = 0.9;
%     indata2.L08 = 0.8;
%     indata2.L05 = 0.5;
    corrFunData2.nuG = indata3.nuG ; % 1.59E-05;
    corrFunData2.muG = indata3.muG ; % 1.85E-05;
    corrFunData2.dPart = indata3.dPart ; % 0.0020797;
    corrFunData2.phiP = indata3.phiP ; % 1;
    corrFunData2.rhoP = indata3.rhoP ; % 2500;
    %indata3.porosity
 
    %%
    %Uncorrected parameters
    % vSup = corrFunData2.vTuyKnowMean

    %%
    %Lin Corr Over 1m
    corrFunData2.vSupLinCorrOver1m = abs((corrFunData2.vTuyKnowMean*corrFunData2.s + corrFunData2.i)...
        *corrFunData2.vTuyKnowMean*corrFunData2.corr1);
    corrFunData2.ReLinCorrOver1m = abs(indata3.rho*corrFunData2.vSupLinCorrOver1m/...
        (corrFunData2.muG*(1-indata3.porosity))*corrFunData2.dPart);
    corrFunData2.ReLinCorrOver1mNoD = abs(corrFunData2.vSupLinCorrOver1m*indata3.rho/(indata3.muG*...
        (1 - indata3.porosity))); %re = vSup*rhoG*d/(muG*(1-e)); 
                                 % Calculating the Reynoldsnumber for specific diameter  
        
    corrFunData2.fDaExpLinCorrOver1m = abs(corrFunData2.dP1MMean*(indata3.porosity)^3*indata3.dPart/...
        (indata3.L01*(indata3.rho*(corrFunData2.vSupLinCorrOver1m)^2)*(1-indata3.porosity)));
    corrFunData2.fDaExpLinCorrOver1mNoD = abs(corrFunData2.dP1MMean/(indata3.L01*indata3.rho*...
        corrFunData2.vSupLinCorrOver1m^2)*indata3.porosity^3/(1 - indata3.porosity));
    %fExp = deltaPs(:,1)./(L(1)*rhoG*vSup.^2)*d*e^3/(1-e);
    
    corrFunData2.fDaErgunLinCorrOver1m = abs(150/corrFunData2.ReLinCorrOver1m + 1.75);
    corrFunData2.fDaKaysLinCorrOver1m = abs(172/corrFunData2.ReLinCorrOver1m + ...
        4.36/(corrFunData2.ReLinCorrOver1m^(0.12)));
    corrFunData2.fDaCarmanLinCorrOver1m = abs(180/corrFunData2.ReLinCorrOver1m + ...
        2.87/(corrFunData2.ReLinCorrOver1m^(0.1)));
    corrFunData2.fDaBrauerLinCorrOver1m = abs(160/corrFunData2.ReLinCorrOver1m + ...
        3.1/(corrFunData2.ReLinCorrOver1m^(0.1)));
    corrFunData2.fDaKrierLinCorrOver1m = abs(150/corrFunData2.ReLinCorrOver1m + ...
        3.89/(corrFunData2.ReLinCorrOver1m^(0.13)));
    corrFunData2.fDaIdelchikLinCorrOver1m  = abs(indata3.porosity^3/(1-indata3.porosity)*...
        0.765/((indata3.porosity)^4.2)*(30/corrFunData2.ReLinCorrOver1m + ...
        3/(corrFunData2.ReLinCorrOver1m^0.7)+0.3));
    
    %%
    %Non Lin Corr Over 1m
    corrFunData2.vSupNLinCorrOver1m = abs((corrFunData2.a*corrFunData2.vTuyKnowMean^corrFunData2.b ...
        +corrFunData2.c)*corrFunData2.vTuyKnowMean*corrFunData2.corr1);
    corrFunData2.ReNLinCorrOver1m = abs(indata3.rho*corrFunData2.vSupNLinCorrOver1m/...
        (corrFunData2.muG*(1-indata3.porosity))*corrFunData2.dPart);
    corrFunData2.ReNLinCorrOver1mNoD = abs(corrFunData2.vSupNLinCorrOver1m*indata3.rho/(indata3.muG*...
        (1 - indata3.porosity))); %re = vSup*rhoG*d/(muG*(1-e)); 
                                 % Calculating the Reynoldsnumber for specific diameter  
        
    corrFunData2.fDaExpNLinCorrOver1m = abs(corrFunData2.dP1MMean*(indata3.porosity)^3*indata3.dPart/...
        (indata3.L01*(indata3.rho*(corrFunData2.vSupNLinCorrOver1m)^2)*(1-indata3.porosity)));
    corrFunData2.fDaExpNLinCorrOver1mNoD = abs(corrFunData2.dP1MMean/(indata3.L01*indata3.rho*...
        corrFunData2.vSupNLinCorrOver1m^2)*indata3.porosity^3/(1 - indata3.porosity));
    %fExp = deltaPs(:,1)./(L(1)*rhoG*vSup.^2)*d*e^3/(1-e);
    
    corrFunData2.fDaErgunNLinCorrOver1m = abs(150/corrFunData2.ReNLinCorrOver1m + 1.75);
    corrFunData2.fDaKaysNLinCorrOver1m = abs(172/corrFunData2.ReNLinCorrOver1m + ...
        4.36/(corrFunData2.ReNLinCorrOver1m^(0.12)));
    corrFunData2.fDaCarmanNLinCorrOver1m = abs(180/corrFunData2.ReNLinCorrOver1m + ...
        2.87/(corrFunData2.ReNLinCorrOver1m^(0.1)));
    corrFunData2.fDaBrauerNLinCorrOver1m = abs(160/corrFunData2.ReNLinCorrOver1m + ...
        3.1/(corrFunData2.ReNLinCorrOver1m^(0.1)));
    corrFunData2.fDaKrierNLinCorrOver1m = abs(150/corrFunData2.ReNLinCorrOver1m + ...
        3.89/(corrFunData2.ReNLinCorrOver1m^(0.13)));
    corrFunData2.fDaIdelchikNLinCorrOver1m  = abs(indata3.porosity^3/(1-indata3.porosity)*...
        0.765/((indata3.porosity)^4.2)*(30/corrFunData2.ReNLinCorrOver1m + ...
        3/(corrFunData2.ReNLinCorrOver1m^0.7)+0.3));
    
    %%
    %Lin Corr Over 0.9m
    corrFunData2.vSupLinCorrOver09m = abs((corrFunData2.vTuyKnowMean*corrFunData2.s + corrFunData2.i)...
        *corrFunData2.vTuyKnowMean*corrFunData2.corr09);
    corrFunData2.ReLinCorrOver09m = abs(indata3.rho*corrFunData2.vSupLinCorrOver09m/...
        (corrFunData2.muG*(1-indata3.porosity))*corrFunData2.dPart);
    corrFunData2.ReLinCorrOver09mNoD = abs(corrFunData2.vSupLinCorrOver09m*indata3.rho/(indata3.muG*...
        (1 - indata3.porosity))); %re = vSup*rhoG*d/(muG*(1-e)); 
                                 % Calculating the Reynoldsnumber for specific diameter  
        
    corrFunData2.fDaExpLinCorrOver09m = abs(corrFunData2.dP9MMean*(indata3.porosity)^3*indata3.dPart/...
        (indata3.L09*(indata3.rho*(corrFunData2.vSupLinCorrOver09m)^2)*(1-indata3.porosity)));
    
    corrFunData2.fDaExpLinCorrOver09mNoD = abs(corrFunData2.dP9MMean/(indata3.L09*indata3.rho*...
        corrFunData2.vSupLinCorrOver09m^2)*indata3.porosity^3/(1 - indata3.porosity));
    %fExp = deltaPs(:,1)./(L(1)*rhoG*vSup.^2)*d*e^3/(1-e);
    
%     corrFunData2.dP1MMean/(indata3.L01*indata3.rho*...
%         corrFunData2.vSupLinCorrOver1m^2)*indata3.porosity^3/(1 - indata3.porosity)
    
    corrFunData2.fDaErgunLinCorrOver09m = abs(150/corrFunData2.ReLinCorrOver09m + 1.75);
    corrFunData2.fDaKaysLinCorrOver09m = abs(172/corrFunData2.ReLinCorrOver09m + ...
        4.36/(corrFunData2.ReLinCorrOver09m^(0.12)));
    corrFunData2.fDaCarmanLinCorrOver09m = abs(180/corrFunData2.ReLinCorrOver09m + ...
        2.87/(corrFunData2.ReLinCorrOver09m^(0.1)));
    corrFunData2.fDaBrauerLinCorrOver09m = abs(160/corrFunData2.ReLinCorrOver09m + ...
        3.1/(corrFunData2.ReLinCorrOver09m^(0.1)));
    corrFunData2.fDaKrierLinCorrOver09m = abs(150/corrFunData2.ReLinCorrOver09m + ...
        3.89/(corrFunData2.ReLinCorrOver09m^(0.13)));
    corrFunData2.fDaIdelchikLinCorrOver09m  = abs(indata3.porosity^3/(1-indata3.porosity)*...
        0.765/((indata3.porosity)^4.2)*(30/corrFunData2.ReLinCorrOver09m + ...
        3/(corrFunData2.ReLinCorrOver09m^0.7)+0.3));
    
        %%
    %Non Lin Corr Over 0.9m
    corrFunData2.vSupNLinCorrOver09m = abs((corrFunData2.a*corrFunData2.vTuyKnowMean^corrFunData2.b ...
        +corrFunData2.c)*corrFunData2.vTuyKnowMean*corrFunData2.corr09);
    corrFunData2.ReNLinCorrOver09m = abs(indata3.rho*corrFunData2.vSupNLinCorrOver09m/...
        (corrFunData2.muG*(1-indata3.porosity))*corrFunData2.dPart);
    corrFunData2.ReNLinCorrOver09mNoD = abs(corrFunData2.vSupNLinCorrOver09m*indata3.rho/(indata3.muG*...
        (1 - indata3.porosity))); %re = vSup*rhoG*d/(muG*(1-e)); 
                                 % Calculating the Reynoldsnumber for specific diameter  
        
    corrFunData2.fDaExpNLinCorrOver09m = abs(corrFunData2.dP9MMean*(indata3.porosity)^3*indata3.dPart/...
        (indata3.L09*(indata3.rho*(corrFunData2.vSupNLinCorrOver09m)^2)*(1-indata3.porosity)));
    corrFunData2.fDaExpNLinCorrOver09mNoD = abs(corrFunData2.dP9MMean/(indata3.L09*indata3.rho*...
        corrFunData2.vSupNLinCorrOver09m^2)*indata3.porosity^3/(1 - indata3.porosity));
    %fExp = deltaPs(:,1)./(L(1)*rhoG*vSup.^2)*d*e^3/(1-e);
    
    corrFunData2.fDaErgunNLinCorrOver09m = abs(150/corrFunData2.ReNLinCorrOver09m + 1.75);
    corrFunData2.fDaKaysNLinCorrOver09m = abs(172/corrFunData2.ReNLinCorrOver09m + ...
        4.36/(corrFunData2.ReNLinCorrOver09m^(0.12)));
    corrFunData2.fDaCarmanNLinCorrOver09m = abs(180/corrFunData2.ReNLinCorrOver09m + ...
        2.87/(corrFunData2.ReNLinCorrOver09m^(0.1)));
    corrFunData2.fDaBrauerNLinCorrOver09m = abs(160/corrFunData2.ReNLinCorrOver09m + ...
        3.1/(corrFunData2.ReNLinCorrOver09m^(0.1)));
    corrFunData2.fDaKrierNLinCorrOver09m = abs(150/corrFunData2.ReNLinCorrOver09m + ...
        3.89/(corrFunData2.ReNLinCorrOver09m^(0.13)));
    corrFunData2.fDaIdelchikNLinCorrOver09m  = abs(indata3.porosity^3/(1-indata3.porosity)*...
        0.765/((indata3.porosity)^4.2)*(30/corrFunData2.ReNLinCorrOver09m + ...
        3/(corrFunData2.ReNLinCorrOver09m^0.7)+0.3));
    
    %%
    %Lin Corr Over 0.8m
    corrFunData2.vSupLinCorrOver08m = abs((corrFunData2.vTuyKnowMean*corrFunData2.s + corrFunData2.i)...
        *corrFunData2.vTuyKnowMean*corrFunData2.corr08);
    corrFunData2.ReLinCorrOver08m = abs(indata3.rho*corrFunData2.vSupLinCorrOver08m/...
        (corrFunData2.muG*(1-indata3.porosity))*corrFunData2.dPart);
    corrFunData2.ReLinCorrOver08mNoD = abs(corrFunData2.vSupLinCorrOver08m*indata3.rho/(indata3.muG*...
        (1 - indata3.porosity))); %re = vSup*rhoG*d/(muG*(1-e)); 
                                 % Calculating the Reynoldsnumber for specific diameter  
        
    corrFunData2.fDaExpLinCorrOver08m = abs(corrFunData2.dP8MMean*(indata3.porosity)^3*indata3.dPart/...
        (indata3.L08*(indata3.rho*(corrFunData2.vSupLinCorrOver08m)^2)*(1-indata3.porosity)));
    corrFunData2.fDaExpLinCorrOver08mNoD = abs(corrFunData2.dP8MMean/(indata3.L08*indata3.rho*...
        corrFunData2.vSupLinCorrOver08m^2)*indata3.porosity^3/(1 - indata3.porosity));
    %fExp = deltaPs(:,1)./(L(1)*rhoG*vSup.^2)*d*e^3/(1-e);
    
    corrFunData2.fDaErgunLinCorrOver08m = abs(150/corrFunData2.ReLinCorrOver08m + 1.75);
    corrFunData2.fDaKaysLinCorrOver08m = abs(172/corrFunData2.ReLinCorrOver08m + ...
        4.36/(corrFunData2.ReLinCorrOver08m^(0.12)));
    corrFunData2.fDaCarmanLinCorrOver08m = abs(180/corrFunData2.ReLinCorrOver08m + ...
        2.87/(corrFunData2.ReLinCorrOver08m^(0.1)));
    corrFunData2.fDaBrauerLinCorrOver08m = abs(160/corrFunData2.ReLinCorrOver08m + ...
        3.1/(corrFunData2.ReLinCorrOver08m^(0.1)));
    corrFunData2.fDaKrierLinCorrOver08m = abs(150/corrFunData2.ReLinCorrOver08m + ...
        3.89/(corrFunData2.ReLinCorrOver08m^(0.13)));
    corrFunData2.fDaIdelchikLinCorrOver08m  = abs(indata3.porosity^3/(1-indata3.porosity)*...
        0.765/((indata3.porosity)^4.2)*(30/corrFunData2.ReLinCorrOver08m + ...
        3/(corrFunData2.ReLinCorrOver08m^0.7)+0.3));
    
        %%
    %Non Lin Corr Over 0.8m
    corrFunData2.vSupNLinCorrOver08m = abs((corrFunData2.a*corrFunData2.vTuyKnowMean^corrFunData2.b ...
        +corrFunData2.c)*corrFunData2.vTuyKnowMean*corrFunData2.corr08);
    corrFunData2.ReNLinCorrOver08m = abs(indata3.rho*corrFunData2.vSupNLinCorrOver08m/...
        (corrFunData2.muG*(1-indata3.porosity))*corrFunData2.dPart);
    corrFunData2.ReNLinCorrOver08mNoD = abs(corrFunData2.vSupNLinCorrOver08m*indata3.rho/(indata3.muG*...
        (1 - indata3.porosity))); %re = vSup*rhoG*d/(muG*(1-e)); 
                                 % Calculating the Reynoldsnumber for specific diameter  
        
    corrFunData2.fDaExpNLinCorrOver08m = abs(corrFunData2.dP8MMean*(indata3.porosity)^3*indata3.dPart/...
        (indata3.L08*(indata3.rho*(corrFunData2.vSupNLinCorrOver08m)^2)*(1-indata3.porosity)));
    corrFunData2.fDaExpNLinCorrOver08mNoD = abs(corrFunData2.dP8MMean/(indata3.L08*indata3.rho*...
        corrFunData2.vSupNLinCorrOver08m^2)*indata3.porosity^3/(1 - indata3.porosity));
    %fExp = deltaPs(:,1)./(L(1)*rhoG*vSup.^2)*d*e^3/(1-e);
    
    corrFunData2.fDaErgunNLinCorrOver08m = abs(150/corrFunData2.ReNLinCorrOver08m + 1.75);
    corrFunData2.fDaKaysNLinCorrOver08m = abs(172/corrFunData2.ReNLinCorrOver08m + ...
        4.36/(corrFunData2.ReNLinCorrOver08m^(0.12)));
    corrFunData2.fDaCarmanNLinCorrOver08m = abs(180/corrFunData2.ReNLinCorrOver08m + ...
        2.87/(corrFunData2.ReNLinCorrOver08m^(0.1)));
    corrFunData2.fDaBrauerNLinCorrOver08m = abs(160/corrFunData2.ReNLinCorrOver08m + ...
        3.1/(corrFunData2.ReNLinCorrOver08m^(0.1)));
    corrFunData2.fDaKrierNLinCorrOver08m = abs(150/corrFunData2.ReNLinCorrOver08m + ...
        3.89/(corrFunData2.ReNLinCorrOver08m^(0.13)));
    corrFunData2.fDaIdelchikNLinCorrOver08m  = abs(indata3.porosity^3/(1-indata3.porosity)*...
        0.765/((indata3.porosity)^4.2)*(30/corrFunData2.ReNLinCorrOver08m + ...
        3/(corrFunData2.ReNLinCorrOver08m^0.7)+0.3));
    
    %%
    %Lin Corr Over 0.5m
    corrFunData2.vSupLinCorrOver05m = abs((corrFunData2.vTuyKnowMean*corrFunData2.s + corrFunData2.i)...
        *corrFunData2.vTuyKnowMean*corrFunData2.corr05);
    corrFunData2.ReLinCorrOver05m = abs(indata3.rho*corrFunData2.vSupLinCorrOver05m/...
        (corrFunData2.muG*(1-indata3.porosity))*corrFunData2.dPart);
    corrFunData2.ReLinCorrOver05mNoD = abs(corrFunData2.vSupLinCorrOver05m*indata3.rho/(indata3.muG*...
        (1 - indata3.porosity))); %re = vSup*rhoG*d/(muG*(1-e)); 
                                 % Calculating the Reynoldsnumber for specific diameter  
        
    corrFunData2.fDaExpLinCorrOver05m = abs(corrFunData2.dP5MMean*(indata3.porosity)^3*indata3.dPart/...
        (indata3.L05*(indata3.rho*(corrFunData2.vSupLinCorrOver05m)^2)*(1-indata3.porosity)));
    corrFunData2.fDaExpLinCorrOver05mNoD = abs(corrFunData2.dP5MMean/(indata3.L05*indata3.rho*...
        corrFunData2.vSupLinCorrOver05m^2)*indata3.porosity^3/(1 - indata3.porosity));
    %fExp = deltaPs(:,1)./(L(1)*rhoG*vSup.^2)*d*e^3/(1-e);
    
    corrFunData2.fDaErgunLinCorrOver05m = abs(150/corrFunData2.ReLinCorrOver05m + 1.75);
    corrFunData2.fDaKaysLinCorrOver05m = abs(172/corrFunData2.ReLinCorrOver05m + ...
        4.36/(corrFunData2.ReLinCorrOver05m^(0.12)));
    corrFunData2.fDaCarmanLinCorrOver05m = abs(180/corrFunData2.ReLinCorrOver05m + ...
        2.87/(corrFunData2.ReLinCorrOver05m^(0.1)));
    corrFunData2.fDaBrauerLinCorrOver05m = abs(160/corrFunData2.ReLinCorrOver05m + ...
        3.1/(corrFunData2.ReLinCorrOver05m^(0.1)));
    corrFunData2.fDaKrierLinCorrOver05m = abs(150/corrFunData2.ReLinCorrOver05m + ...
        3.89/(corrFunData2.ReLinCorrOver05m^(0.13)));
    corrFunData2.fDaIdelchikLinCorrOver05m  = abs(indata3.porosity^3/(1-indata3.porosity)*...
        0.765/((indata3.porosity)^4.2)*(30/corrFunData2.ReLinCorrOver05m + ...
        3/(corrFunData2.ReLinCorrOver05m^0.7)+0.3));
    
        %%
    %Non Lin Corr Over 0.5m
    corrFunData2.vSupNLinCorrOver05m = abs((corrFunData2.a*corrFunData2.vTuyKnowMean^corrFunData2.b ...
        +corrFunData2.c)*corrFunData2.vTuyKnowMean*corrFunData2.corr05);
    corrFunData2.ReNLinCorrOver05m = abs(indata3.rho*corrFunData2.vSupNLinCorrOver05m/...
        (corrFunData2.muG*(1-indata3.porosity))*corrFunData2.dPart);
    corrFunData2.ReNLinCorrOver05mNoD = abs(corrFunData2.vSupNLinCorrOver05m*indata3.rho/(indata3.muG*...
        (1 - indata3.porosity))); %re = vSup*rhoG*d/(muG*(1-e)); 
                                 % Calculating the Reynoldsnumber for specific diameter  
        
    corrFunData2.fDaExpNLinCorrOver05m = abs(corrFunData2.dP5MMean*(indata3.porosity)^3*indata3.dPart/...
        (indata3.L05*(indata3.rho*(corrFunData2.vSupNLinCorrOver05m)^2)*(1-indata3.porosity)));
    corrFunData2.fDaExpNLinCorrOver05mNoD = abs(corrFunData2.dP5MMean/(indata3.L05*indata3.rho*...
        corrFunData2.vSupNLinCorrOver05m^2)*indata3.porosity^3/(1 - indata3.porosity));
    %fExp = deltaPs(:,1)./(L(1)*rhoG*vSup.^2)*d*e^3/(1-e);
    
    corrFunData2.fDaErgunNLinCorrOver05m = abs(150/corrFunData2.ReNLinCorrOver05m + 1.75);
    corrFunData2.fDaKaysNLinCorrOver05m = abs(172/corrFunData2.ReNLinCorrOver05m + ...
        4.36/(corrFunData2.ReNLinCorrOver05m^(0.12)));
    corrFunData2.fDaCarmanNLinCorrOver05m = abs(180/corrFunData2.ReNLinCorrOver05m + ...
        2.87/(corrFunData2.ReNLinCorrOver05m^(0.1)));
    corrFunData2.fDaBrauerNLinCorrOver05m = abs(160/corrFunData2.ReNLinCorrOver05m + ...
        3.1/(corrFunData2.ReNLinCorrOver05m^(0.1)));
    corrFunData2.fDaKrierNLinCorrOver05m = abs(150/corrFunData2.ReNLinCorrOver05m + ...
        3.89/(corrFunData2.ReNLinCorrOver05m^(0.13)));
    corrFunData2.fDaIdelchikNLinCorrOver05m  = abs(indata3.porosity^3/(1-indata3.porosity)*...
        0.765/((indata3.porosity)^4.2)*(30/corrFunData2.ReNLinCorrOver05m + ...
        3/(corrFunData2.ReNLinCorrOver05m^0.7)+0.3));
    %%
end
% corrFunData2.vSupLinCorrOver08m = (corrFunData2.vTuyKnowMean*corrFunData2.s + corrFunData2.i)...
%         *corrFunData2.vTuyKnowMean*corrFunData2.corr08;
%     corrFunData2.ReLinCorrOver08m = indata3.rho*corrFunData2.vSupLinCorrOver08m/...
%         (corrFunData2.muG*(1-indata3.porosity))*corrFunData2.dPart;
%     corrFunData2.fDaExpLinCorrOver08m = corrFunData2.dP8MMean*(indata3.porosity)^3*indata3.dPart/...
%         (indata3.L*(indata3.rho*(corrFunData2.vSupLinCorrOver08m)^2)*(1-indata3.porosity));
%     corrFunData2.fDaErgunLinCorrOver08m = 150/corrFunData2.ReLinCorrOver08m + 1.75;
%     corrFunData2.fDaKaysLinCorrOver08m = 172/corrFunData2.ReLinCorrOver08m + ...
%         4.36/(corrFunData2.ReLinCorrOver08m^(0.12));
%     corrFunData2.fDaCarmanLinCorrOver08m = 180/corrFunData2.ReLinCorrOver08m + ...
%         2.87/(corrFunData2.ReLinCorrOver08m^(0.1));
%     corrFunData2.fDaBrauerLinCorrOver08m = 160/corrFunData2.ReLinCorrOver08m + ...
%         3.1/(corrFunData2.ReLinCorrOver08m^(0.1));
%     corrFunData2.fDaKrierLinCorrOver08m = 150/corrFunData2.ReLinCorrOver08m + ...
%         3.89/(corrFunData2.ReLinCorrOver08m^(0.13));
%     corrFunData2.fDaIdelchikLinCorrOver08m  = indata3.porosity^3/(1-indata3.porosity)*...
%         0.765/((indata3.porosity)^4.2)*(30/corrFunData2.ReLinCorrOver08m + ...
%         3/(corrFunData2.ReLinCorrOver08m^0.7)+0.3);
%     
%         %%
    %Non Lin Corr Over 0.8m
% corrFunData2.vSupNLinCorrOver08m = (corrFunData2.a*corrFunData2.vTuyKnowMean^corrFunData2.b ...
%         +corrFunData2.c)*corrFunData2.vTuyKnowMean*corrFunData2.corr08;
%     corrFunData2.ReNLinCorrOver08m = indata3.rho*corrFunData2.vSupNLinCorrOver08m/...
%         (corrFunData2.muG*(1-indata3.porosity))*corrFunData2.dPart;
%      corrFunData2.fDaExpNLinCorrOver08m = corrFunData2.dP8MMean*(indata3.porosity)^3*indata3.dPart/...
%         (indata3.L*(indata3.rho*(corrFunData2.vSupNLinCorrOver08m)^2)*(1-indata3.porosity));
%     corrFunData2.fDaErgunNLinCorrOver08m = 150/corrFunData2.ReNLinCorrOver08m + 1.75;
%     corrFunData2.fDaKaysNLinCorrOver08m = 172/corrFunData2.ReNLinCorrOver08m + ...
%         4.36/(corrFunData2.ReNLinCorrOver08m^(0.12));
%     corrFunData2.fDaCarmanNLinCorrOver08m = 180/corrFunData2.ReNLinCorrOver08m + ...
%         2.87/(corrFunData2.ReNLinCorrOver08m^(0.1));
%     corrFunData2.fDaBrauerNLinCorrOver08m = 160/corrFunData2.ReNLinCorrOver08m + ...
%         3.1/(corrFunData2.ReNLinCorrOver08m^(0.1));
%     corrFunData2.fDaKrierNLinCorrOver08m = 150/corrFunData2.ReNLinCorrOver08m + ...
%         3.89/(corrFunData2.ReNLinCorrOver08m^(0.13));
%     corrFunData2.fDaIdelchikNLinCorrOver08m  = indata3.porosity^3/(1-indata3.porosity)*...
%         0.765/((indata3.porosity)^4.2)*(30/corrFunData2.ReNLinCorrOver08m + ...
%         3/(corrFunData2.ReNLinCorrOver08m^0.7)+0.3);
%     
%     %%
%     %Lin Corr Over 0.5m
%     corrFunData2.vSupLinCorrOver05m = (corrFunData2.vTuyKnowMean*corrFunData2.s + corrFunData2.i)...
%         *corrFunData2.vTuyKnowMean*corrFunData2.corr05;
%     corrFunData2.ReLinCorrOver05m = indata3.rho*corrFunData2.vSupLinCorrOver05m/...
%         (corrFunData2.muG*(1-indata3.porosity))*corrFunData2.dPart;
%     corrFunData2.fDaExpLinCorrOver05m = corrFunData2.dP5MMean*(indata3.porosity)^3*indata3.dPart/...
%         (indata3.L*(indata3.rho*(corrFunData2.vSupLinCorrOver05m)^2)*(1-indata3.porosity));
%     corrFunData2.fDaErgunLinCorrOver05m = 150/corrFunData2.ReLinCorrOver05m + 1.75;
%     corrFunData2.fDaKaysLinCorrOver05m = 172/corrFunData2.ReLinCorrOver05m + ...
%         4.36/(corrFunData2.ReLinCorrOver05m^(0.12));
%     corrFunData2.fDaCarmanLinCorrOver05m = 180/corrFunData2.ReLinCorrOver05m + ...
%         2.87/(corrFunData2.ReLinCorrOver05m^(0.1));
%     corrFunData2.fDaBrauerLinCorrOver05m = 160/corrFunData2.ReLinCorrOver05m + ...
%         3.1/(corrFunData2.ReLinCorrOver05m^(0.1));
%     corrFunData2.fDaKrierLinCorrOver05m = 150/corrFunData2.ReLinCorrOver05m + ...
%         3.89/(corrFunData2.ReLinCorrOver05m^(0.13));
%     corrFunData2.fDaIdelchikLinCorrOver05m  = indata3.porosity^3/(1-indata3.porosity)*...
%         0.765/((indata3.porosity)^4.2)*(30/corrFunData2.ReLinCorrOver05m + ...
%         3/(corrFunData2.ReLinCorrOver05m^0.7)+0.3);
%     
%         %%
%     %Non Lin Corr Over 0.5m
%     corrFunData2.vSupNLinCorrOver05m = (corrFunData2.a*corrFunData2.vTuyKnowMean^corrFunData2.b ...
%         +corrFunData2.c)*corrFunData2.vTuyKnowMean*corrFunData2.corr05;
%     corrFunData2.ReNLinCorrOver05m = indata3.rho*corrFunData2.vSupNLinCorrOver05m/...
%         (corrFunData2.muG*(1-indata3.porosity))*corrFunData2.dPart;
%      corrFunData2.fDaExpNLinCorrOver05m = corrFunData2.dP5MMean*(indata3.porosity)^3*indata3.dPart/...
%         (indata3.L*(indata3.rho*(corrFunData2.vSupNLinCorrOver05m)^2)*(1-indata3.porosity));
%     corrFunData2.fDaErgunNLinCorrOver05m = 150/corrFunData2.ReNLinCorrOver05m + 1.75;
%     corrFunData2.fDaKaysNLinCorrOver05m = 172/corrFunData2.ReNLinCorrOver05m + ...
%         4.36/(corrFunData2.ReNLinCorrOver05m^(0.12));
%     corrFunData2.fDaCarmanNLinCorrOver05m = 180/corrFunData2.ReNLinCorrOver05m + ...
%         2.87/(corrFunData2.ReNLinCorrOver05m^(0.1));
%     corrFunData2.fDaBrauerNLinCorrOver05m = 160/corrFunData2.ReNLinCorrOver05m + ...
%         3.1/(corrFunData2.ReNLinCorrOver05m^(0.1));
%     corrFunData2.fDaKrierNLinCorrOver05m = 150/corrFunData2.ReNLinCorrOver05m + ...
%         3.89/(corrFunData2.ReNLinCorrOver05m^(0.13));
%     corrFunData2.fDaIdelchikNLinCorrOver05m  = indata3.porosity^3/(1-indata3.porosity)*...
%         0.765/((indata3.porosity)^4.2)*(30/corrFunData2.ReNLinCorrOver05m + ...
%         3/(corrFunData2.ReNLinCorrOver05m^0.7)+0.3);