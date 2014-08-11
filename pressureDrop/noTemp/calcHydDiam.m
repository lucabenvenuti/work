function [calcHydDiamData5] = calcHydDiam(indata5, reNoD, fExpNoD)
%CALCHYDDIAM Summary of this function goes here
%   Detailed explanation goes here

      % indata5.step = 0.00001;  
%     % Value range where hydraulic diameter with minimal SSE shall be in in m
%     indata5.diamRange.init = 0.001;
%     indata5.diamRange.end = 0.010;
%     indata5.diamRange.vector = indata2.diamRange.init:indata2.step:indata2.diamRange.end;  
%     indata5.diamRange.length = length(indata2.diamRange.vector);

%     %%input
%     offsetSampleTime = indata5.offsetSampleTime;
%     sampleFrequency = indata5.sampleFrequency;
%     dTuyMeasure = indata5.dTuyMeasure;
%     dTuyKnow = indata5.dTuyKnow;
%     rho = indata5.rho;
%     particleType = indata5.particleType;
%     name = indata5.name;
%     particleWeight = indata5.particleWeight;
%     porosity  = indata5.porosity;
%     p0 = indata5.p0;
%     h0 = indata5.h0;
%     h = indata5.h; 
%     R = indata5.R;
%     fileName = indata5.fileName;
%     fanspeed = indata5.fanspeed;
%     pVelMax = indata5.pVelMax; % [Pa]
%     VMax = indata5.VMax;    % [V] 
%     tempcorr = indata5.tempcorr;
%     tuyArea = indata5.tuyArea;
%     tuyAreaKnow = indata5.tuyAreaKnow;
%     pMax1M = indata5.pMax1M;
%     vMax1M = indata5.vMax1M;
%     pMax9DM = indata5.pMax9DM;
%     vMax9DM = indata5.vMax9DM;
%     pMax8DM = indata5.pMax8DM;
%     vMax8DM = indata5.vMax8DM;
%     pMax5DM = indata5.pMax5DM;
%     vMax5DM = indata5.vMax5DM;
%     corrFunData5.dP1MMean
%     corrFunData5.dP9MMean
%     corrFunData5.dP8MMean
%     corrFunData5.dP5MMean
%     corrFunData5.vSupLinCorrOver1m
%     corrFunData5.vSupNLinCorrOver1m
%     corrFunData5.vSupLinCorrOver09m
%     corrFunData5.vSupNLinCorrOver09m
%     corrFunData5.vSupLinCorrOver08m
%     corrFunData5.vSupNLinCorrOver08m
%     corrFunData5.vSupLinCorrOver05m
%     corrFunData5.vSupNLinCorrOver05m

% %    Parameters for Friction Factor 		
%     corrFunData2.L = indata5.L ; % 1;
%     %indata5.rho            rhoG	1.1644 
%     corrFunData2.nuG = indata5.nuG ; % 1.59E-05;
%     corrFunData2.muG = indata5.muG ; % 1.85E-05;
%     corrFunData2.dPart = indata5.dPart ; % 0.0020797;
%     corrFunData2.phiP = indata5.phiP ; % 1;
%     corrFunData2.rhoP = indata5.rhoP ; % 2500;
%     %indata5.porosity
%corrFunData2.ReNLinCorrOver1mNoD
%corrFunData2.fDaExpNLinCorrOver1mNoD


% k=1;
% runSSE = 1; 
%         for k = 1:indata5.diamRange.length
%             d = indata5.diamRange.vector(k);
%             
% %             re = vSup*rhoG*d/(muG*(1-e)); % Calculating the Reynoldsnumber for specific diameter  
%             calcHydDiamData5.ReLinCorrOver1mWithD = corrFunData5.ReLinCorrOver1mNoD*d;
%             
% %             fExp = deltaPs(:,1)./(L(1)*rhoG*vSup.^2)*d*e^3/(1-e);
%             calcHydDiamData5.fDaExpLinCorrOver1mWithD = corrFunData2.fDaExpLinCorrOver1mNoD*d;
% %             fErg = 150./re+1.75; 
% %             fKeys = 172./re+4.36./re.^0.12;
% %             fCarman = 180./re+2.87./re.^0.1; 
% %             fBrauer = 160./re+3.1./re.^0.1; 
% %             fKrier = 150./re + 3.89./re.^0.13; 
% %             fIdelchik = e^3/(1-e)*0.765/e^4.2*(30./re + 3./re.^0.7 + 0.3); 
% % 
% %             SSEVec(runSSE,1) = d; 
% %             SSEVec(runSSE,2) = sum((fExp-fErg).^2); 
% %             SSEVec(runSSE,3) = sum((fExp-fKeys).^2);
% %             SSEVec(runSSE,4) = sum((fExp-fCarman).^2);
% %             SSEVec(runSSE,5) = sum((fExp-fBrauer).^2);
% %             SSEVec(runSSE,6) = sum((fExp-fKrier).^2);
% %             SSEVec(runSSE,7) = sum((fExp-fIdelchik).^2);
% % 
% %             runSSE = runSSE + 1; 
%         end 

%get Hyd Diameter

j=1;
k=1;
%runSSE = 1; 
%indata5, ReLinCorrOver1mNoD5, fDaExpLinCorrOver1mNoD5
%first SSE over the experiments, then SSE over the diameters
for k = 1:indata5.diamRange.length
    d = indata5.diamRange.vector(k);
    
   % disp(k);
%     for j=1:imax
%         re(j) =  corrFunData(j).ReLinCorrOver1mNoD*d; % Calculating the Reynoldsnumber 
%                 %for specific diameter  %vector of the different experiment 
%         fExp(j) = corrFunData(j).fDaExpLinCorrOver1mNoD*d; %vector of the different 
%                                                             %experiment,corr over 1m
% %         fKeys(j) = 172/re(j) + 4.36/re(j)^0.12;
% %         fCarman(j) = 180/re(j) + 2.87/re(j)^0.1; 
% %         fBrauer(j) = 160/re(j) + 3.1/re(j)^0.1; 
% %         fKrier(j) = 150/re(j) + 3.89/re(j)^0.13; 
% %         fIdelchik(j) = e^3/(1-e)*0.765/e^4.2*(30/re(j) + 3./re(j)^0.7 + 0.3); 
%     end
%     j=1;
    
    re = abs(reNoD*d);
    fExp = abs(fExpNoD*d);
    fErg = abs(150./re+1.75); 
    fKeys = abs(172./re+4.36./re.^0.12);
    fCarman = abs(180./re+2.87./re.^0.1); 
    fBrauer = abs(160./re+3.1./re.^0.1); 
    fKrier = abs(150./re + 3.89./re.^0.13); 
    %indata.porosity
    fIdelchik = abs(indata5.porosity^3/(1-indata5.porosity)*0.765/indata5.porosity^4.2*...
        (30./re + 3./re.^0.7 + 0.3)); %fIdelchik = e^3/(1-e)*0.765/e^4.2*(30./re + 3./re.^0.7 + 0.3); 

    SSEVec(k,1) = d; 
    SSEVec(k,2) = abs(sum((fExp-fErg).^2)); 
    SSEVec(k,3) = abs(sum((fExp-fKeys).^2));
    SSEVec(k,4) = abs(sum((fExp-fCarman).^2));
    SSEVec(k,5) = abs(sum((fExp-fBrauer).^2));
    SSEVec(k,6) = abs(sum((fExp-fKrier).^2));
    SSEVec(k,7) = abs(sum((fExp-fIdelchik).^2));

 %   runSSE = runSSE + 1; 
       


end


        [SSEMinErg, index] = min(SSEVec(:,2));
        dHydErg = SSEVec(index,1);

        [SSEMinKeys, index] = min(SSEVec(:,3));
        dHydKeys = SSEVec(index,1);

        [SSEMinCarman, index] = min(SSEVec(:,4));
        dHydCarman = SSEVec(index,1);

        [SSEMinBrauer, index] = min(SSEVec(:,5));
        dHydBrauer = SSEVec(index,1);

        [SSEMinKrier, index] = min(SSEVec(:,6));
        dHydKrier = SSEVec(index,1);

        [SSEMinIdelchik, index] = min(SSEVec(:,7));
        dHydIdelchik = SSEVec(index,1);

        indexVec = 1:6; 
        dHydVec = [dHydErg,dHydKeys,dHydCarman,dHydBrauer,dHydKrier,dHydIdelchik]; 
        SSEMinVec = [SSEMinErg,SSEMinKeys,SSEMinCarman,SSEMinBrauer,SSEMinKrier,SSEMinIdelchik]; 
        calcHydDiamData5.dHydVec = dHydVec;
        calcHydDiamData5.SSEMinVec = SSEMinVec;
 % errorbar(indexVec,dHydVec,SSEMinVec.*(max(dHydVec)-min(dHydVec))/max(SSEMinVec)); 

    % hydraulic diameter (weighted mean value). Weights are the inverse SSEs. 
        calcHydDiamData5.dHyd = sum(dHydVec./SSEMinVec)/sum(1./SSEMinVec); %vector of different 
                                                %method diameter       
        
% save to corresponding excel-file (filename) 

%     % Save data to excel file 
%     if saveFlag == 1 
%         bedPressureDataHead={'Name','dHydErg','SSEErg','dHydKeys','SSEKeys','dHydCarman',
%'SSECarman','dHydBrauer','SSEBrauer','dHydKrier','SSEKrier','dHydIdelchik','SSEIdelchik',
%'WeightedRowwiseDHyd'; ... 
%             '','[m]','[-]','[m]','[-]','[m]','[-]','[m]','[-]','[m]','[-]','[m]','[-]','[m]'};
%         bedPressure={dHydVec(1),SSEMinVec(1),dHydVec(2),SSEMinVec(2),dHydVec(3),SSEMinVec(3),
%dHydVec(4),SSEMinVec(4),dHydVec(5),SSEMinVec(5),dHydVec(6),SSEMinVec(6),dHyd};
%         xlswrite([pwd,fileName],bedPressureDataHead,'A260:N261');
%         xlswrite([pwd,fileName],[measName, bedPressure],savePos);  
%     end     
% 
%     if isnumeric(measData) && measData ~= 8 
%         measData = measData + 1;
%     else 
%         loop = 'off'; 
%     end   



end

