     %clearvars newY2 newY22 gloriaAugustaSchulzeNN dataNN2 densTolerance gloriaAugustaSchulzeNNDens gloriaAugustaSchulzeNNnoDens gloriaAugustaAorNNMa gloriaAugustaAorNNLi gloriaAugustaAorNNBoth X Y Z S 
     clear all
     close all
     clc
%load('radarPlot10070sinterfine0_1range.mat', 'NNSave2', 'avgMuR1', 'avgMuR2', 'data', 'dataNN2', 'densityBulkBoxMax', 'densityBulkBoxMean', 'densityBulkBoxMin', 'errorEstSumMaxIndex2', 'errorNN2', 'expFtd', 'expInp', 'expOut', 'exp_file', 'nY2column', 'nY2rows', 'newY2', 'trainFcn')
% load('radarPlot10070sinterfine0_1range.mat', 'avgMuR2Pos')
% load('radarPlot10070sinterfine0_1range.mat', 'avgMuR1Pos')
% load('radarPlot10070sinterfine0_1range.mat', 'maxExpFtdRhoB', 'meanExpFtdRhoB', 'minExpFtdRhoB')
% % % % 
% % % % dataNN2.rest = sort(0.5 + (0.9-0.5).*rand(50,1));
% % % %  dataNN2.sf= sort(0.05 + (1.0-0.05).*rand(100,1)); %[0.1:0.1:1];[0.05:(1.0-0.05)/99:1.0]; %
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
load testPolidispersityCokeCoarseCokeFineSinterFineLimestoneFine.mat
load testInputNNpolidispersity.mat

dataNN2.ctrlStress = 1056; %1068;% [1068,2069,10070];
dataNN2.radmu = 0.00184;
dataNN2.radsigma = 0.00192;
exp_file_name = '20131129_1000_limestone315-10_test02';

[ gloriaAugustaSchulzeNNDens01, gca01 ] = radarPrintVectorialPolidispersityFun(densityBulkBoxMean, NNSave2, errorEstSumMaxIndex2, avgMuR2Pos, avgMuR1Pos,densityBulkBoxMeanPos, dataNN2, exp_file_name, 1);

dataNN2.ctrlStress = 2057; %1068;% [1068,2069,10070];
dataNN2.radmu = 0.00184;
dataNN2.radsigma = 0.00192;
exp_file_name = '20131129_1000_limestone315-10_test02';

[ gloriaAugustaSchulzeNNDens02, gca02 ] = radarPrintVectorialPolidispersityFun(densityBulkBoxMean, NNSave2, errorEstSumMaxIndex2, avgMuR2Pos, avgMuR1Pos,densityBulkBoxMeanPos, dataNN2, exp_file_name, 2);

dataNN2.ctrlStress = 5059; %1068;% [1068,2069,10070];
dataNN2.radmu = 0.00184;
dataNN2.radsigma = 0.00192;
exp_file_name = '20131129_1000_limestone315-10_test02';

[ gloriaAugustaSchulzeNNDens03, gca03 ] = radarPrintVectorialPolidispersityFun(densityBulkBoxMean, NNSave2, errorEstSumMaxIndex2, avgMuR2Pos, avgMuR1Pos,densityBulkBoxMeanPos, dataNN2, exp_file_name,  3);

dataNN2.ctrlStress = 2050; %1068;% [1068,2069,10070];
dataNN2.radmu = 0.00155;
dataNN2.radsigma = 0.00147;
exp_file_name = '20131129_1000_limestone315-10_test02';

[ gloriaAugustaSchulzeNNDens04, gca04 ] = radarPrintVectorialPolidispersityFun(densityBulkBoxMean, NNSave2, errorEstSumMaxIndex2, avgMuR2Pos, avgMuR1Pos,densityBulkBoxMeanPos, dataNN2, exp_file_name,  4);

dataNN2.ctrlStress = 5050; %1068;% [1068,2069,10070];
dataNN2.radmu = 0.00155;
dataNN2.radsigma = 0.00147;
exp_file_name = '20131129_1000_limestone315-10_test02';

[ gloriaAugustaSchulzeNNDens05, gca05 ] = radarPrintVectorialPolidispersityFun(densityBulkBoxMean, NNSave2, errorEstSumMaxIndex2, avgMuR2Pos, avgMuR1Pos,densityBulkBoxMeanPos, dataNN2, exp_file_name,  5);
