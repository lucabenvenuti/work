     clear all
     close all
     clc


%dataNN2.rest = sort(0.5 + (0.9-0.5).*rand(25,1));
%dataNN2.sf= sort(0.05 + (1.0-0.05).*rand(50,1)); %[0.1:0.1:1];[0.05:(1.0-0.05)/99:1.0]; %
%dataNN2.radmu = sort(0.00025 + (0.002-0.00025).*rand(50,1)); %0.00184;
% % % %  dataNN2.rf= sort(0.05 + (1.0-0.05).*rand(50,1)); %[0.1:0.1:1];[0.05:(1.0-0.05)/99:0.6]; %
% % % % %        dataNN2.dt= 1e-6; %[1e-7:1e-7:1e-6];
% % % % dataNN2.dCylDp= 50;%[20:1:50];
% % % % 
% % % % % % %    %  dataNN2.shearperc = 1.0;   % [0.4:0.2:1.0];  %1.0;   
% % % % 
% % % % if (exist('densityBulkBoxMean'))
% % % %            dataNN2.dens = sort(2000 + (3500-2000).*rand(25,1)); %[2000:100:3500];[2000:(3500-2000)/49:3500]; %
% % % %        % densTolerance =1.4; 
% % % % end   
% % %     
load /mnt/scratchPFMDaten/Luca/testPolidispersityShearCellCokeCoarseCokeFineSinterFineLimestoneFineMatlab/testPolidispersityCokeCoarseCokeFineSinterFineLimestoneFineNew.mat
load /mnt/scratchPFMDaten/Luca/testPolidispersityShearCellCokeCoarseCokeFineSinterFineLimestoneFineMatlab/inputRadSigma.mat

dataNN2.ctrlStress = 1056; %1068;% [1068,2069,10070];
dataNN2.radmu = 0.001;
dataNN2.dens = 2500;
%exp_file_name = '20131128_1612_sinterfine315-10_test01';

newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);        
    [nY2rows,nY2column] = size(newY2);
    

    
lim = max(dataNN2.radsigma);
x = [dataNN2.radmu-lim:(lim/499.5):dataNN2.radmu+lim];
norm = normpdf(x,dataNN2.radmu,dataNN2.radsigma(i));

for i=1:length(dataNN2.radsigma)
norm(i,:) = normpdf(x,dataNN2.radmu,dataNN2.radsigma(i)');
% figure(i);
% plot(x,norm(i,:));
col(i,:)=find(newY2(7,:)==dataNN2.radsigma(i)');

avgMuR2mean(i)= mean(newY2(9,col(i,:)));
avgMuR2std(i)= std(newY2(9,col(i,:)));

avgMuR1mean(i)= mean(newY2(10,col(i,:)));
avgMuR1std(i)= std(newY2(10,col(i,:)));

rhoBmean(i)= mean(newY2(11,col(i,:)));
rhoBstd(i)= std(newY2(11,col(i,:)));

end

