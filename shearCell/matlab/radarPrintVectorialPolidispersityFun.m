function [ gloriaAugustaSchulzeNNDens, a2 ] = radarPrintVectorialPolidispersityFun(densityBulkBoxMean, NNSave2, errorEstSumMaxIndex2, avgMuR2Pos, avgMuR1Pos,densityBulkBoxMeanPos, dataNN2, exp_file_name, numFig)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

[coeffShear40, coeffShear60, coeffShear80, coeffShear100, expFtd, expInp, expOut] = experimentalImport( exp_file_name );
        coeffPirker = 1.0;
      densTolerance = 0.05; 
     fricTolerance = 0.05;
% %    %  dataNN2.dCylDp= 20;
    
     c2 = datestr(clock)   
   %  tic
     newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);        
    [nY2rows,nY2column] = size(newY2);
 %   toc
  c11 = datestr(clock)   
            jjj=1;
            kkk=1;
            ii=1;
            meanExpFtdRhoB = mean(expFtd.rhoB);
            maxExpFtdRhoB  = max(expFtd.rhoB);
            minExpFtdRhoB  = min(expFtd.rhoB);    
    
            
            if (exist('densityBulkBoxMean'))
                nY2rowsBis = nY2rows+8;
                nY2rowsTris = nY2rowsBis+5;
            else
                nY2rowsBis = nY2rows+7;
                nY2rowsTris = nY2rowsBis+2;
            end
            
     coeffShear40 = coeffShear40*coeffPirker;
     expOut.coeffPreShear40 = expOut.coeffPreShear40*coeffPirker;
     
     coeffShear60 = coeffShear60*coeffPirker;
     expOut.coeffPreShear60 = expOut.coeffPreShear60*coeffPirker;
     
     coeffShear80 = coeffShear80*coeffPirker;
     expOut.coeffPreShear80 = expOut.coeffPreShear80*coeffPirker;
     
     coeffShear100 = coeffShear100*coeffPirker;
     expOut.coeffPreShear100 = expOut.coeffPreShear100*coeffPirker;
     

     
     
     c1 = datestr(clock)     
                                         newY2(nY2rows+1,:) = newY2(avgMuR2Pos,:)/coeffShear100; 
                                    newY2(nY2rows+2,:) =  newY2(avgMuR1Pos,:)/expOut.coeffPreShear100 ;  
                                    newY2(nY2rows+3,:) = expOut.tauAbPr100; %expInp.tauAb100; 
                                    newY2(nY2rows+4,:) = expOut.sigmaAnM;% expOut.sigmaAb100; 
                                    newY2(nY2rows+5,:) = coeffShear100;
                                    newY2(nY2rows+6,:) = expOut.tauAbPr100; 
                                    newY2(nY2rows+7,:) = expOut.coeffPreShear100; 
                                    newY2(nY2rows+8,:) = expOut.rhoBAnM;
                                     c6 = datestr(clock) 
     %                       end
                                
                                 %nY2rowsBis = length(newY2(:,ii));
                            %data(ii).deltaRatioShear = abs(1-data(ii).ratioShear);
                            newY2(nY2rowsBis+1,:) =  abs(1- newY2(nY2rows+1,:));
                            %data(ii).deltaRatioPreShear = abs(1-data(ii).ratioPreShear);
                            newY2(nY2rowsBis+2,:) =  abs(1- newY2(nY2rows+2,:));
                            
                            newY2(nY2rowsBis+3,:) =  meanExpFtdRhoB;%mean(expFtd.rhoB);
                            newY2(nY2rowsBis+4,:) =  maxExpFtdRhoB;%max(expFtd.rhoB);
                            newY2(nY2rowsBis+5,:) =  minExpFtdRhoB;%min(expFtd.rhoB);
                            c7 = datestr(clock) 
     
          ii=1;
          kkk=1;
          ni=1;
          c8 = datestr(clock) 
          temp_vi = newY2( (nY2rowsBis+1), : );
          temp_i = find (temp_vi < fricTolerance);
          temp_vj = newY2( (nY2rowsBis+2), : );
          temp_j = find (temp_vj < fricTolerance);
          temp_vk = newY2( (densityBulkBoxMeanPos), : );
          temp_k = find (temp_vk < maxExpFtdRhoB*(1.0+densTolerance));
          temp_l = find (temp_vk > minExpFtdRhoB*(1.0-densTolerance));
%           ni = size(temp_i,2) 
%           nj = size(temp_j,2) 
%           nk = size(temp_k,2) 
%           nl = size(temp_l,2) 
%           
          [Cij,aij,bij] = intersect(temp_i,temp_j); %1068 .06
          [Ckl,akl,bkl] = intersect(temp_k,temp_l);
          [Cijkl,aijkl,bijkl] = intersect(Cij,Ckl);
          
        %  Cijkl=Cij;
          ni = size(Cijkl,2) ;
%           size(Cijkl) 
          
          
          gloriaAugustaSchulzeNNDens = zeros( ni,  nY2rowsTris+2);
%           size(gloriaAugustaSchulzeNNDens)
          gloriaAugustaSchulzeNNDens( kkk:(kkk+ni-1), 1) = Cijkl'; 
%           size(gloriaAugustaSchulzeNNDens)
%           size(newY2)
%           nY2rowsTris
%           aa=newY2( :, Cijkl )';
          gloriaAugustaSchulzeNNDens(kkk:ni, 2:(nY2rowsTris+1) ) = newY2( :, Cijkl )';
%           size(gloriaAugustaSchulzeNNDens)
          gloriaAugustaSchulzeNNDens( kkk:ni, nY2rowsTris+2) =1;
%           size(gloriaAugustaSchulzeNNDens)
          kkk = kkk + ni
          c9 = datestr(clock) 
    
c4 = datestr(clock)           
    
clearvars gloriaAugustaSchulzeNN X Y Z S C G
    gloriaAugustaSchulzeNN = gloriaAugustaSchulzeNNDens';%(1:size(gloriaAugustaSchulzeNNDens,1)-1, :)';

    X=gloriaAugustaSchulzeNN(3,:); %sf
    Y=gloriaAugustaSchulzeNN(4,:); %rf
    Z=gloriaAugustaSchulzeNN(9,:); %density
    S=gloriaAugustaSchulzeNN(2,:); %cor
    C=gloriaAugustaSchulzeNN(10,:);%avgMuR2
    %C=gloriaAugustaSchulzeNN(8,:);%aorLi
    %Z=gloriaAugustaSchulzeNN(7,:); %density
    
    meanS = mean(S);
    meanX = mean(X);
    meanY = mean(Y);
    meanZ = mean(Z); 
    stdS  = std(S);
    stdX  = std(X);
    stdY  = std(Y);
    stdZ  = std(Z);
    minS = min(S);
    minX = min(X);
    minY = min(Y);
    minZ = min(Z);    
    maxS = max(S);
    maxX = max(X);
    maxY = max(Y);
    maxZ = max(Z);    
    
     G(1,1)= 0.52; %min(dataNN2.rest); %S
     G(1,2)= minS;
     G(1,3)= meanS - stdS;
     G(1,4)= meanS;
     G(1,5)= meanS + stdS;
     G(1,6)= maxS;
     G(1,7)= 0.86 ; %max(dataNN2.rest); %S
     
     G(2,1)= 0.06; %min(dataNN2.sf); %X
     G(2,2)= minX;
     G(2,3)= meanX - stdX;
     G(2,4)= meanX;
     G(2,5)= meanX + stdX;
     G(2,6)= maxX;
     G(2,7)= 0.98; % max(dataNN2.sf); %X  
     
     G(3,1)= 0.06; %min(dataNN2.rf); %Y
     G(3,2)= minY;
     G(3,3)= meanY - stdY;
     G(3,4)= meanY;
     G(3,5)= meanY + stdY;
     G(3,6)= maxY;
     G(3,7)= 0.99; %max(dataNN2.rf); %Y
     
     G(4,1)= 2027; %min(dataNN2.dens); %Z
     G(4,2)= minZ;
     G(4,3)= max(meanZ - stdZ, minZ);
     G(4,4)= meanZ;
     G(4,5)= meanZ + stdZ;
     G(4,6)= maxZ;
     G(4,7)= 3499; %max(dataNN2.dens); %Z
     
     figure(numFig)
     a2 = radarPlot(G)
     legend('minInput','min', '\mu - \sigma', '\mu', '\mu + \sigma', 'max', 'maxInput'); %, 'FontSize',24)
     title (['SRSCT: normal stress = ', num2str(dataNN2.ctrlStress), ' [Pa], coeff. P. = ', num2str(coeffPirker)] ,'FontSize',24);
     %title (['AOR, coeff. P. = ', num2str(coeffPirker)] ,'FontSize',24);
%      set(gca,'fontname','times new roman','FontSize',24)  % Set it to times
%      gca

end

