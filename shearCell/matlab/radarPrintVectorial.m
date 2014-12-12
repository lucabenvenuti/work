%   clearvars newY2 newY22 gloriaAugustaSchulzeNN dataNN2 densTolerance gloriaAugustaSchulzeNNDens gloriaAugustaSchulzeNNnoDens gloriaAugustaAorNNMa gloriaAugustaAorNNLi gloriaAugustaAorNNBoth X Y Z S 
%   close all

%       dataNN2.rest = [0.5:(0.9-0.5)/49:0.9]; %sort(0.5 + (0.9-0.5).*rand(50,1)); %a + (b-a).*rand(10,1);%[0.5:0.1:0.9];
%       dataNN2.sf= [0.05:(1.0-0.05)/99:1.0]; %sort(0.05 + (1.0-0.05).*rand(100,1)); %[0.1:0.1:1];
%       dataNN2.rf= [0.05:(0.6-0.05)/99:0.6]; %sort(0.05 + (0.6-0.05).*rand(100,1)); %[0.1:0.1:1];
%       dataNN2.dt= 1e-6; %[1e-7:1e-7:1e-6];
%       dataNN2.dCylDp= 40;%[20:1:50];
% %  %   dataNN2.ctrlStress = 1068; %1068;% [1068,2069,10070];
% %    %  dataNN2.shearperc = 1.0;   % [0.4:0.2:1.0];  %1.0;   
% %      if (exist('densityBulkBoxMean'))
%          dataNN2.dens = [2000:(3500-2000)/49:3500]; %sort(2000 + (3500-2000).*rand(50,1)); %[2000:100:3500];
% % %         densTolerance =1.4; 
%      end   
% %     
  %   load inputDataNN6.mat
%  %   load('/mnt/benvenutiPFMDaten/simulations/input/inputDataNN1.mat');
    %  dataNN2 = rmfield(dataNN2, {'shearperc', 'dCylDp'} );
     %  dataNN2 = rmfield(dataNN2, 'shearperc' );
    % dataNN2.shearperc = 1.0;  
    % dataNN2.dCylDp= 36;
      dataNN2.ctrlStress = 1.068007975188830e+03; % 1.007001977856750e+04; % 1068; %1068;% [1068,2069,10070];
      coeffPirker = 1.0;
    densTolerance = 0.05; 
   %  dataNN2.dCylDp= 20;
    
     c2 = datestr(clock)   
   %  tic
     newY2 = myNewInput(NNSave2, errorEstSumMaxIndex2, dataNN2);        
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
     
%      switch newY2(7,ii) %.shearperc %data(ii).shearperc
%                                 case 0.4
%                                     newY2(nY2rows+1,ii) = newY2(avgMuR2Pos,ii)/coeffShear40; %   %data(ii).ratioShear = avgMuR2(ii)/...
%                                     newY2(nY2rows+2,ii) =  newY2(avgMuR1Pos,ii)/expOut.coeffPreShear40 ;   %  data(ii).ratioPreShear  = avgMuR1(ii)/expOut.coeffPreShear40;
%                                     newY2(nY2rows+3,ii) = expInp.tauAb40; %data(ii).tauAb = expInp.tauAb40;
%                                     newY2(nY2rows+4,ii) = expOut.sigmaAb40; %data(ii).sigmaAb
%                                     newY2(nY2rows+5,ii) = coeffShear40; %data(ii).coeffShear
%                                     newY2(nY2rows+6,ii) = expOut.tauAbPr40; %data(ii).tauAbPr
%                                     newY2(nY2rows+7,ii) = expOut.coeffPreShear40; %data(ii).coeffPreShear 
%                                     newY2(nY2rows+8,ii) = expOut.rhoB40;
%                                     
%                                 case 0.6
% %                                     data(ii).ratioShear = avgMuR2(ii)/coeffShear60;
% %                                     data(ii).ratioPreShear = avgMuR1(ii)/expOut.coeffPreShear60;
% %                                     data(ii).tauAb = expInp.tauAb60;
% %                                     data(ii).sigmaAb = expOut.sigmaAb60;
% %                                     data(ii).coeffShear = coeffShear60;
% %                                     data(ii).tauAbPr = expOut.tauAbPr60;
% %                                     data(ii).coeffPreShear = expOut.coeffPreShear60;
%                                     newY2(nY2rows+1,ii) = newY2(avgMuR2Pos,ii)/coeffShear60; 
%                                     newY2(nY2rows+2,ii) =  newY2(avgMuR1Pos,ii)/expOut.coeffPreShear60 ;  
%                                     newY2(nY2rows+3,ii) = expInp.tauAb60; 
%                                     newY2(nY2rows+4,ii) = expOut.sigmaAb60; 
%                                     newY2(nY2rows+5,ii) = coeffShear60;
%                                     newY2(nY2rows+6,ii) = expOut.tauAbPr60; 
%                                     newY2(nY2rows+7,ii) = expOut.coeffPreShear60; 
%                                     newY2(nY2rows+8,ii) = expOut.rhoB60;
%                                     
%                                 case 0.8
% %                                     data(ii).ratioShear = avgMuR2(ii)/coeffShear80;
% %                                     data(ii).ratioPreShear = avgMuR1(ii)/expOut.coeffPreShear80;
% %                                     data(ii).tauAb = expInp.tauAb80;
% %                                     data(ii).sigmaAb = expOut.sigmaAb80;
% %                                     data(ii).coeffShear = coeffShear80;
% %                                     data(ii).tauAbPr = expOut.tauAbPr80;
% %                                     data(ii).coeffPreShear = expOut.coeffPreShear80;
%                                     newY2(nY2rows+1,ii) = newY2(avgMuR2Pos,ii)/coeffShear80; 
%                                     newY2(nY2rows+2,ii) =  newY2(avgMuR1Pos,ii)/expOut.coeffPreShear80 ;  
%                                     newY2(nY2rows+3,ii) = expInp.tauAb80; 
%                                     newY2(nY2rows+4,ii) = expOut.sigmaAb80; 
%                                     newY2(nY2rows+5,ii) = coeffShear80;
%                                     newY2(nY2rows+6,ii) = expOut.tauAbPr80; 
%                                     newY2(nY2rows+7,ii) = expOut.coeffPreShear80; 
%                                     newY2(nY2rows+8,ii) = expOut.rhoB80;
%                                     
%                                 case 1.0
%                                     data(ii).ratioShear = avgMuR2(ii)/coeffShear100;
%                                     data(ii).ratioPreShear = avgMuR1(ii)/expOut.coeffPreShear100;
%                                     data(ii).tauAb = expInp.tauAb100;
%                                     data(ii).sigmaAb = expOut.sigmaAb100;
%                                     data(ii).coeffShear = coeffShear100;
%                                     data(ii).tauAbPr = expOut.tauAbPr100;
%                                     data(ii).coeffPreShear = expOut.coeffPreShear100;
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
          temp_i = find (temp_vi < densTolerance);
          temp_vj = newY2( (nY2rowsBis+2), : );
          temp_j = find (temp_vj < densTolerance*2);
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
          
          ni = size(Cijkl,2) 
          
          gloriaAugustaSchulzeNNDens = zeros( kkk+size(Cijkl,2)-1,  nY2rowsTris+2);
          gloriaAugustaSchulzeNNDens( kkk:(kkk+ni-1), 1) = Cijkl'; 
          gloriaAugustaSchulzeNNDens(kkk:(kkk+ni-1), 2:(nY2rowsTris+1) ) = newY2( :, Cijkl )';
          gloriaAugustaSchulzeNNDens( kkk:(kkk+ni-1), nY2rowsTris+2) =1;
          kkk = kkk + ni
          c9 = datestr(clock) 
     
%             for ii=1:nY2column
%                        % if (dataNN2.ctrlStress*1*.95 < expOut.sigmaAnM <dataNN2.ctrlStress*1*1.05)
%                             
%                             if (exist('densityBulkBoxMean') &  (newY2(nY2rowsBis+1,ii)<0.05) & (newY2(nY2rowsBis+2,ii)<0.05) &   (newY2(densityBulkBoxMeanPos,ii)<maxExpFtdRhoB*(1.0+densTolerance))  ...
%                                     &  (newY2(densityBulkBoxMeanPos,ii)>minExpFtdRhoB*(1.0-densTolerance)) )
%                                                        
%       %                      if (exist('densityBulkBoxMean') &  (newY2(nY2rowsBis+1,ii)<0.05) & (newY2(nY2rowsBis+2,ii)<0.05) &   ...
%       %                              (newY2(densityBulkBoxMeanPos,ii)<newY2(nY2rowsBis+4,ii)*densTolerance)  &  (newY2(densityBulkBoxMeanPos,ii)>newY2(nY2rowsBis+5,ii)) )
%                                 gloriaAugustaSchulzeNNDens(1,kkk) = ii;
%                                 gloriaAugustaSchulzeNNDens(2:(nY2rowsTris+1), kkk) = newY2(1:end,ii) ;%avgMuR1(ii);  
%                                 gloriaAugustaSchulzeNNDens(nY2rowsTris+2, kkk) = 1;
%                                 kkk=kkk+1;
% %                             elseif ((newY2(nY2rowsBis+1,ii)<0.05) & (newY2(nY2rowsBis+2,ii)<0.05)) %((data(ii).deltaRatioShear<0.05) & (data(ii).deltaRatioPreShear<0.05))
% %                                 gloriaAugustaSchulzeNNnoDens(1,jjj) = ii;
% %                                 gloriaAugustaSchulzeNNnoDens(2:(nY2rowsTris+1), jjj) = newY2(1:end,ii) ;%avgMuR1(ii);
% %                                 gloriaAugustaSchulzeNNnoDens(nY2rowsTris+2, jjj) = 0;
% % %                                 gloriaAugustaSchulze{jjj,3} = avgMuR2(ii);
% % %                                 gloriaAugustaSchulze{jjj,4} = data(ii).tauAb;
% % %                                 gloriaAugustaSchulze{jjj,5} = data(ii).sigmaAb;
% % %                                 gloriaAugustaSchulze{jjj,6} = data(ii).coeffShear;
% % %                                 gloriaAugustaSchulze{jjj,7} = data(ii).ratioShear;
% % %                                 gloriaAugustaSchulze{jjj,8} = data(ii).deltaRatioShear;
% % %                                 gloriaAugustaSchulze{jjj,9} = data(ii).tauAbPr;
% % %                                 gloriaAugustaSchulze{jjj,10} = data(ii).coeffPreShear;
% % %                                 gloriaAugustaSchulze{jjj,11} = data(ii).ratioPreShear;
% % %                                 gloriaAugustaSchulze{jjj,12} = data(ii).deltaRatioPreShear;
% %                                 jjj=jjj+1;
%                            end
%                      %   end
%             end
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
     
     figure(8)
     a2 = radarPlot(G)
     legend('minInput','min', '\mu - \sigma', '\mu', '\mu + \sigma', 'max', 'maxInput'); %, 'FontSize',24)
     title (['normal stress = ', num2str(dataNN2.ctrlStress), ' [Pa], coeff. P. = ', num2str(coeffPirker)] ,'FontSize',24);
     %title (['AOR, coeff. P. = ', num2str(coeffPirker)] ,'FontSize',24);
     set(gca,'fontname','times new roman')  % Set it to times
     %save -v7.3 radarPlot10070sinterfine0_1rangePirker1dot0SFRangeReducedBis

     %dfittool
     %save(['PDF10070sinterfine', '.mat'], 'PDF10070');
%      PDF10070{1} = COR10070;
% PDF10070{2} = sf10070;
% PDF10070{2} = SF10070;
% PDF10070{3} = RF10070;
% PDF10070{4} = particledensity10070;


% SF2069 = createFit(S);
% xlabel('COR')
% saveas(1,['COR2069PDF','.tif']);
% 
% SF2069 = createFit(X);
% xlabel('SF')
% saveas(1,['SF2069PDF','.tif']);
% 
% RF2069 = createFit(Y);
% xlabel('RF')
% saveas(1,['RF2069PDF','.tif']);
% 
% 
% particledensity2069 = createFit(Z);
% xlabel('particle density')
% saveas(1,['particledensity2069PDF','.tif']);
% 
% PDF2069{1} = COR2069;
% PDF2069{2} = SF2069;
% PDF2069{3} = RF2069;
% PDF2069{4} = particledensity2069;
% save(['PDF2069sinterfine', '.mat'], 'PDF2069');


