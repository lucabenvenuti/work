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
%load /mnt/scratchPFMDaten/Luca/testPolidispersityShearCellCokeCoarseCokeFineSinterFineLimestoneFineMatlab/testPolidispersityCokeCoarseCokeFineSinterFineLimestoneFineNew.mat
%load testPolidispersityDensityBulkBoxMax.mat
% load testPolidispersityDensityBulkBoxMean.mat
% load testPolidispersityDensityBulkBoxMin.mat
% load testPolidispersityDensityBulkBoxPreShearMax.mat
% load testPolidispersityDensityBulkBoxPreShearMean.mat
% load testPolidispersityDensityBulkBoxPreShearMin.mat
% load testPolidispersityDensityBulkBoxShearMax.mat
% load testPolidispersityDensityBulkBoxShearMean.mat
% load testPolidispersityDensityBulkBoxShearMin.mat

load DensityBulkBoxPreShearMaxTest.mat

load /mnt/scratchPFMDaten/Luca/testPolidispersityShearCellCokeCoarseCokeFineSinterFineLimestoneFineMatlab/inputRadSigma.mat

dataNN2.ctrlStress = 5000; %1068;% [1068,2069,10070];
dataNN2.radmu = 0.001;
dataNN2.dens = 2500;
dataNN2.dCylDp= 30;
dataNN2.radsigma = dataNN2.radsigma/10;
%exp_file_name = '20131128_1612_sinterfine315-10_test01';

newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);        
  %  [nY2rows,nY2column] = size(newY2);
    

    
lim = max(dataNN2.radsigma);
x = [dataNN2.radmu-lim:(lim/499.5):dataNN2.radmu+lim];
%norm = normpdf(x,dataNN2.radmu,dataNN2.radsigma(i));
% 
% .996
% .998
% .996
% .991 091simulationRadiusDistribution50DensityBulkBoxPreShearMax
% .978
% 1
% .999 091simulationRadiusDistribution50DensityBulkBoxShearMax
% .991
% .9978

for i=1:length(dataNN2.radsigma)
norm(i,:) = normpdf(x,dataNN2.radmu,dataNN2.radsigma(i)');
norm(i,:) = norm(i,:)/max(norm(i,:));
% figure(i);
% plot(x,norm(i,:));
col(i,:)=find(newY2(7,:)==dataNN2.radsigma(i)');

avgMuR2mean(i)= mean(newY2(9,col(i,:)));
avgMuR2std(i)= std(newY2(9,col(i,:)));

avgMuR1mean(i)= mean(newY2(10,col(i,:)));
avgMuR1std(i)= std(newY2(10,col(i,:)));

rhoBShearMaxmean(i)= mean(newY2(11,col(i,:)));
rhoBShearMaxstd(i)= std(newY2(11,col(i,:)));

rhoBPreShearMaxmean(i)= mean(DensityBulkBoxPreShearMax(1,col(i,:)));
rhoBPreShearMaxstd(i)= std(DensityBulkBoxPreShearMax(1,col(i,:)));

end

avgMuR2mean = avgMuR2mean./max(avgMuR2mean);
avgMuR1mean = avgMuR1mean./max(avgMuR1mean);
rhoBShearMaxmean = rhoBShearMaxmean./max(rhoBShearMaxmean);
rhoBPreShearMaxmean = rhoBPreShearMaxmean./max(rhoBPreShearMaxmean);

avgMuR2std = avgMuR2std./max(avgMuR2std);
avgMuR1std = avgMuR1std./max(avgMuR1std);
rhoBShearMaxstd = rhoBShearMaxstd./max(rhoBShearMaxstd);
rhoBPreShearMaxmean = rhoBPreShearMaxmean./max(rhoBPreShearMaxmean);

h1=figure(6);
plot(dataNN2.radsigma',avgMuR2mean,dataNN2.radsigma',avgMuR1mean,dataNN2.radsigma',rhoBShearMaxmean,dataNN2.radsigma',rhoBPreShearMaxmean)
xlabel('std dev radius [m]');
% ylabel('zPos [m]');
legend('avgMuR2mean [-]','avgMuR1mean [-]', 'rhoBShearMaxmean [-]', 'rhoBPreShearMaxmean [-]','Location', 'SouthEast' );
print(h1,'-djpeg','-r300',['0',num2str(41+i),'simulationRadiusDistribution',num2str(i)])

% figure(7)
% plot(dataNN2.radsigma',avgMuR2std,dataNN2.radsigma',avgMuR1std,dataNN2.radsigma',rhoBShearMaxstd)
% xlabel('std dev radius [m]');
% % ylabel('zPos [m]');
% legend('avgMuR2std [-]','avgMuR1std [-]', 'rhoBShearMaxstd [-]'); %, 'FontSize',24)
% 
% figure(4)
% plot(x,norm(1,:));
% xlabel('radius [m]');
% 
% figure(5)
% plot(x,norm(50,:));
% xlabel('radius [m]');
% 
% 
% figure(8)
% semilogx(dataNN2.radsigma',avgMuR2mean,dataNN2.radsigma',avgMuR1mean,dataNN2.radsigma',rhoBShearMaxmean)
% xlabel('std dev radius [m]');
% % ylabel('zPos [m]');
% legend('avgMuR2mean [-]','avgMuR1mean [-]', 'rhoBShearMaxmean [-]'); %, 'FontSize',24)
% 
% figure(9)
% semilogx(dataNN2.radsigma',avgMuR2std,dataNN2.radsigma',avgMuR1std,dataNN2.radsigma',rhoBShearMaxstd)
% xlabel('std dev radius [m]');
% % ylabel('zPos [m]');
% legend('avgMuR2std [-]','avgMuR1std [-]', 'rhoBShearMaxstd [-]'); %, 'FontSize',24)