function [newY2Par, gloriaTestPar]  = gloria(newY2Par, nY2columnPar, nY2rowsPar, dataNN2Par, expOutPar, expInpPar, ...
                                                        expFtdPar, coeffShear40Par, coeffShear60Par, coeffShear80Par, ...
                                                        coeffShear100Par, avgMuR2PosPar, avgMuR1PosPar, densityBulkBoxMeanPosPar, nY2rowsParBisPar, nY2rowsParTrisPar, densTolerancePar )

%          for i =1:nY2rowsPar
%             newY2ParPar{i} = newY2Par(i,:);
%          end
                   
            poolobj = gcp('nocreate');
            if (~isempty(poolobj.isvalid))
                %do nothing
            else
                parpool local
            end

            %parpool local %4
            jjj=1;
            ii=1;
            meanexpFtdParRhoB = mean(expFtdPar.rhoB);
            maxexpFtdParRhoB  = max(expFtdPar.rhoB);
            minexpFtdParRhoB  = min(expFtdPar.rhoB);
            
            newY2ParCheck = newY2Par(7,:);
            newY2ParCheckDens = newY2Par(densityBulkBoxMeanPosPar,:);
            %(newY2Par(densityBulkBoxMeanPosPar,ii)<newY2Par(nY2rowsParBisPar+4,ii)*densTolerancePar) ...
            %                        &  (newY2Par(densityBulkBoxMeanPosPar,ii)>newY2Par(nY2rowsParBisPar+5,ii)) )

                newY2Par1=zeros(nY2columnPar,1);
                newY2Par2=zeros(nY2columnPar,1);
                newY2Par3=zeros(nY2columnPar,1);
                newY2Par4=zeros(nY2columnPar,1);
                newY2Par5=zeros(nY2columnPar,1);
                newY2Par6=zeros(nY2columnPar,1);
                newY2Par7=zeros(nY2columnPar,1);
                newY2Par8=zeros(nY2columnPar,1);
                newY2Par9=zeros(nY2columnPar,1);
                newY2Par10=zeros(nY2columnPar,1);
                newY2Par11=zeros(nY2columnPar,1);
                newY2Par12=zeros(nY2columnPar,1);
                newY2Par13=zeros(nY2columnPar,1);
                newY2Par14=zeros(nY2columnPar,1);
                
            
            parfor ii=1:nY2columnPar
                        if (dataNN2Par.ctrlStress*1*.95 < expOutPar.sigmaAnM <dataNN2Par.ctrlStress*1*1.05)
                            
                            switch newY2ParCheck(ii) %.shearperc %data(ii).shearperc
                                case 0.4
                                    newY2Par1(ii) = newY2Par(avgMuR2PosPar,ii)/coeffShear40Par; %   %data(ii).ratioShear = avgMuR2(ii)/...
                                     %   %data(ii).ratioShear = avgMuR2(ii)/...
                                    newY2Par2(ii) =  newY2Par(avgMuR1PosPar,ii)/expOutPar.coeffPreShear40 ;   %  data(ii).ratioPreShear  = avgMuR1(ii)/expOutPar.coeffPreShear40;
                                    newY2Par3(ii) = expInpPar.tauAb40; %data(ii).tauAb = expInpPar.tauAb40;
                                    newY2Par4(ii) = expOutPar.sigmaAb40; %data(ii).sigmaAb
                                    newY2Par5(ii) = coeffShear40Par; %data(ii).coeffShear
                                    newY2Par6(ii) = expOutPar.tauAbPr40; %data(ii).tauAbPr
                                    newY2Par7(ii) = expOutPar.coeffPreShear40; %data(ii).coeffPreShear 
                                    newY2Par8(ii) = expOutPar.rhoB40;
                                    
                                case 0.6
%                                     data(ii).ratioShear = avgMuR2(ii)/coeffShear60Par;
%                                     data(ii).ratioPreShear = avgMuR1(ii)/expOutPar.coeffPreShear60;
%                                     data(ii).tauAb = expInpPar.tauAb60;
%                                     data(ii).sigmaAb = expOutPar.sigmaAb60;
%                                     data(ii).coeffShear = coeffShear60Par;
%                                     data(ii).tauAbPr = expOutPar.tauAbPr60;
%                                     data(ii).coeffPreShear = expOutPar.coeffPreShear60;
                                    newY2Par1(ii) = newY2Par(avgMuR2PosPar,ii)/coeffShear60Par; 
                                    newY2Par2(ii) =  newY2Par(avgMuR1PosPar,ii)/expOutPar.coeffPreShear60 ;  
                                    newY2Par3(ii) = expInpPar.tauAb60; 
                                    newY2Par4(ii) = expOutPar.sigmaAb60; 
                                    newY2Par5(ii) = coeffShear60Par;
                                    newY2Par6(ii) = expOutPar.tauAbPr60; 
                                    newY2Par7(ii) = expOutPar.coeffPreShear60; 
                                    newY2Par8(ii) = expOutPar.rhoB60;
                                    
                                case 0.8
%                                     data(ii).ratioShear = avgMuR2(ii)/coeffShear80Par;
%                                     data(ii).ratioPreShear = avgMuR1(ii)/expOutPar.coeffPreShear80;
%                                     data(ii).tauAb = expInpPar.tauAb80;
%                                     data(ii).sigmaAb = expOutPar.sigmaAb80;
%                                     data(ii).coeffShear = coeffShear80Par;
%                                     data(ii).tauAbPr = expOutPar.tauAbPr80;
%                                     data(ii).coeffPreShear = expOutPar.coeffPreShear80;
                                    newY2Par1(ii) = newY2Par(avgMuR2PosPar,ii)/coeffShear80Par; 
                                    newY2Par2(ii) =  newY2Par(avgMuR1PosPar,ii)/expOutPar.coeffPreShear80 ;  
                                    newY2Par3(ii) = expInpPar.tauAb80; 
                                    newY2Par4(ii) = expOutPar.sigmaAb80; 
                                    newY2Par5(ii) = coeffShear80Par;
                                    newY2Par6(ii) = expOutPar.tauAbPr80; 
                                    newY2Par7(ii) = expOutPar.coeffPreShear80; 
                                    newY2Par8(ii) = expOutPar.rhoB80;
                                    
                                case 1.0
%                                     data(ii).ratioShear = avgMuR2(ii)/coeffShear100Par;
%                                     data(ii).ratioPreShear = avgMuR1(ii)/expOutPar.coeffPreShear100;
%                                     data(ii).tauAb = expInpPar.tauAb100;
%                                     data(ii).sigmaAb = expOutPar.sigmaAb100;
%                                     data(ii).coeffShear = coeffShear100Par;
%                                     data(ii).tauAbPr = expOutPar.tauAbPr100;
%                                     data(ii).coeffPreShear = expOutPar.coeffPreShear100;
                                    newY2Par1(ii) = newY2Par(avgMuR2PosPar,ii)/coeffShear100Par; 
                                    newY2Par2(ii) =  newY2Par(avgMuR1PosPar,ii)/expOutPar.coeffPreShear100 ;  
                                    newY2Par3(ii) = expOutPar.tauAbPr100; %expInpPar.tauAb100; 
                                    newY2Par4(ii) = expOutPar.sigmaAnM;% expOutPar.sigmaAb100; 
                                    newY2Par5(ii) = coeffShear100Par;
                                    newY2Par6(ii) = expOutPar.tauAbPr100; 
                                    newY2Par7(ii) = expOutPar.coeffPreShear100; 
                                    newY2Par8(ii) = expOutPar.rhoBAnM;
                            end
                            

                            %nY2rowsParBisPar = length(newY2Par(:,ii));
                            %data(ii).deltaRatioShear = abs(1-data(ii).ratioShear);
                            newY2Par9(ii) =  abs(1- newY2Par1(ii));
                            %data(ii).deltaRatioPreShear = abs(1-data(ii).ratioPreShear);
                            newY2Par10(ii) =  abs(1- newY2Par2(ii));
                            
                            newY2Par11(ii) =  meanexpFtdParRhoB;%mean(expFtdPar.rhoB);
                            newY2Par12(ii) =  maxexpFtdParRhoB;%max(expFtdPar.rhoB);
                            newY2Par13(ii) =  minexpFtdParRhoB;%min(expFtdPar.rhoB);
                            newY2Par14(ii) = 0;
                            
                            
                            if (exist('densityBulkBoxMean') &  (newY2Par9(ii)<0.05) & (newY2Par10(ii)<0.05) ) %&   ...
                                 %   (newY2ParCheckDens(ii)<newY2Par12(ii)*densTolerancePar) ...
                                %    &  (newY2ParCheckDens(ii)>newY2Par13(ii)) )
                                newY2Par14(ii) = 2;
% % % %                                 gloriaAugustaSchulzeNNPar(1,jjj) = ii;
% % % %                                 gloriaAugustaSchulzeNNPar(2:(nY2rowsParTrisPar+1), jjj) = newY2Par(1:end,ii) ;%avgMuR1(ii);  
% % % %                                 gloriaAugustaSchulzeNNPar(nY2rowsParTrisPar+2, jjj) = 1;
%                             elseif ((newY2Par(nY2rowsParBisPar+1,ii)<0.05) & (newY2Par(nY2rowsParBisPar+2,ii)<0.05)) %((data(ii).deltaRatioShear<0.05) & (data(ii).deltaRatioPreShear<0.05))
%                                 gloriaAugustaSchulzeNNPar(1,jjj) = ii;
%                                 gloriaAugustaSchulzeNNPar(2:(nY2rowsParTrisPar+1), jjj) = newY2Par(1:end,ii) ;%avgMuR1(ii);
%                                 gloriaAugustaSchulzeNNPar(nY2rowsParTrisPar+2, jjj) = 0;
                                
                                
                                
                                
                                
                                
                                
%                                 gloriaAugustaSchulze{jjj,3} = avgMuR2(ii);
%                                 gloriaAugustaSchulze{jjj,4} = data(ii).tauAb;
%                                 gloriaAugustaSchulze{jjj,5} = data(ii).sigmaAb;
%                                 gloriaAugustaSchulze{jjj,6} = data(ii).coeffShear;
%                                 gloriaAugustaSchulze{jjj,7} = data(ii).ratioShear;
%                                 gloriaAugustaSchulze{jjj,8} = data(ii).deltaRatioShear;
%                                 gloriaAugustaSchulze{jjj,9} = data(ii).tauAbPr;
%                                 gloriaAugustaSchulze{jjj,10} = data(ii).coeffPreShear;
%                                 gloriaAugustaSchulze{jjj,11} = data(ii).ratioPreShear;
%                                 gloriaAugustaSchulze{jjj,12} = data(ii).deltaRatioPreShear;
% % % %                                 jjj=jjj+1;
                           end
                        end
            end
                newY2Par(nY2rowsPar+1,:) = newY2Par1;
                newY2Par(nY2rowsPar+2,:) = newY2Par2;
                newY2Par(nY2rowsPar+3,:) = newY2Par3;
                newY2Par(nY2rowsPar+4,:) = newY2Par4;
                newY2Par(nY2rowsPar+5,:) = newY2Par5;
                newY2Par(nY2rowsPar+6,:) = newY2Par6;
                newY2Par(nY2rowsPar+7,:) = newY2Par7;
                newY2Par(nY2rowsPar+8,:) = newY2Par8;
                newY2Par(nY2rowsParBisPar+1,:) = newY2Par9;
                newY2Par(nY2rowsParBisPar+2,:) = newY2Par10;
                newY2Par(nY2rowsParBisPar+3,:) = newY2Par11;
                newY2Par(nY2rowsParBisPar+4,:) = newY2Par12;
                newY2Par(nY2rowsParBisPar+5,:) = newY2Par13;
                newY2Par(nY2rowsParBisPar+6,:) = newY2Par14;
                gloriaTestPar = find(newY2Par14==2);  
                
                
                poolobj = gcp('nocreate');
                delete(poolobj);
                
end

% 
%                         end
%                         ii=0;
%                         
% 
%                         
%                         parfor ii=1:nY2columnPar