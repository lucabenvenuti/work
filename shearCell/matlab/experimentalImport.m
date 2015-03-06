function [coeffShear40, coeffShear60, coeffShear80, coeffShear100, expFtd, expInp, expOut] = experimentalImport( exp_file_name )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%%experimental import
exp_flag = true;
%exp_dir = '.'; % directory, where the files can be found
exp_dir = '/mnt/benvenutiPFMDaten/Materials2Simulation2Application_RnR/BS/Luca_final/';
% exp_file_name = '20131128_1612_sinterfine315-10_test01';
legendExpFlag = 'schulze'; % choose between jenike & schulze
imageFlag = false;
exp_file_name
if (exp_flag)
    switch legendExpFlag
        case {'jenike','poorMan'}    
             exp_file = 'test05sinterfine-0-315mm'; %.mat %name of the mat-file, created with the script available at 'gemeinsames'; it must contain 'Fr' and 't'

            
        case 'schulze'
            exp_file = [exp_dir, exp_file_name, '.FTD']; % name of the FTD FILE, with the exp values vs time
            summaryFile = [exp_dir,exp_file_name , '.out']; % name of the out file, with the summary values
            sumForceFile = [exp_dir,exp_file_name , '.inp']; % name of the inp file, with the forces summary values
    end
    
end

if (exp_flag)
    
     switch legendExpFlag

            case 'schulze'   



                    comma2point_overwrite(exp_file);    %substitution of commas with dots
                    expFtd = importFTD(exp_file);
                    
                    time = expFtd.time;
                    tau = expFtd.tau;
                    dH = expFtd.dH;
                    rhoB = expFtd.rhoB;
                    
                    
                    comma2point_overwrite(summaryFile);
                    expOut = importOut(summaryFile);
                    
                    comma2point_overwrite(sumForceFile);
                    expInp = importInp(sumForceFile);
                    
                    coeffShear40 = expInp.tauAb40/expOut.sigmaAb40;
                    coeffShear60 = expInp.tauAb60/expOut.sigmaAb60;
                    coeffShear80 = expInp.tauAb80/expOut.sigmaAb80;
                    coeffShear100 = expOut.coeffShear100;
                    if (imageFlag)
                        figure(hFig(4)); hold on
                        plot(time,tau,'Color','red','LineWidth',2);
                        %xlim([-1 data(1).timesteps(end)+1]);

                        leg{4,iCnt(4)} = exp_file;
                        iCnt(4) = iCnt(4)+1;  

                        figure(hFig(6));
                        subplot(2,1,2);
                        plot(time,tau,'LineWidth',2);   
                    end
                    jjj=1;
                    ii=1;
%                     for ii=1:nSimCases
%                         if (data(ii).ctrlStress*-1*.95 < expOut.sigmaAnM <data(ii).ctrlStress*-1*1.05)
%                             
%                             switch data(ii).shearperc
%                                 case 0.4
%                                     data(ii).ratioShear = avgMuR2(ii)/coeffShear40;
%                                     data(ii).ratioPreShear = avgMuR1(ii)/expOut.coeffPreShear40;
%                                     data(ii).tauAb = expInp.tauAb40;
%                                     data(ii).sigmaAb = expOut.sigmaAb40;
%                                     data(ii).coeffShear = coeffShear40;
%                                     data(ii).tauAbPr = expOut.tauAbPr40;
%                                     data(ii).coeffPreShear = expOut.coeffPreShear40;
%                                                                         
%                                 case 0.6
%                                     data(ii).ratioShear = avgMuR2(ii)/coeffShear60;
%                                     data(ii).ratioPreShear = avgMuR1(ii)/expOut.coeffPreShear60;
%                                     data(ii).tauAb = expInp.tauAb60;
%                                     data(ii).sigmaAb = expOut.sigmaAb60;
%                                     data(ii).coeffShear = coeffShear60;
%                                     data(ii).tauAbPr = expOut.tauAbPr60;
%                                     data(ii).coeffPreShear = expOut.coeffPreShear60;
%                                                                         
%                                 case 0.8
%                                     data(ii).ratioShear = avgMuR2(ii)/coeffShear80;
%                                     data(ii).ratioPreShear = avgMuR1(ii)/expOut.coeffPreShear80;
%                                     data(ii).tauAb = expInp.tauAb80;
%                                     data(ii).sigmaAb = expOut.sigmaAb80;
%                                     data(ii).coeffShear = coeffShear80;
%                                     data(ii).tauAbPr = expOut.tauAbPr80;
%                                     data(ii).coeffPreShear = expOut.coeffPreShear80;
%                                     
%                                     
%                                 case 1.0
%                                     data(ii).ratioShear = avgMuR2(ii)/coeffShear100;
%                                     data(ii).ratioPreShear = avgMuR1(ii)/expOut.coeffPreShear100;
%                                     data(ii).tauAb = expOut.tauAbPr100;
%                                     data(ii).sigmaAb = expOut.sigmaAb100;
%                                     data(ii).coeffShear = coeffShear100;
%                                     data(ii).tauAbPr = expOut.tauAbPr100;
%                                     data(ii).coeffPreShear = expOut.coeffPreShear100;
%                                     
%                             end
%                             
%                             data(ii).deltaRatioShear = abs(1-data(ii).ratioShear);
%                             data(ii).deltaRatioPreShear = abs(1-data(ii).ratioPreShear);
%                             
%                            if ((data(ii).deltaRatioShear<0.05) & (data(ii).deltaRatioPreShear<0.05))
%                                 gloriaAugustaSchulze{jjj,1} = data(ii).name;
%                                 gloriaAugustaSchulze{jjj,2} = avgMuR1(ii);
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
%                                 jjj=jjj+1;
%                            end
%                         end
%                     end
     end
end
end