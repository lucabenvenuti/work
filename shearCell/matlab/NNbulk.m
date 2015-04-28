trainFcn = 'trainscg';

load /mnt/scratchPFMDaten/Luca/testPolidispersityShearCellCokeCoarseCokeFineSinterFineLimestoneFineMatlab/inputRadSigma.mat

dataNN2.ctrlStress = 5000; %1068;% [1068,2069,10070];
dataNN2.radmu = 0.001;
dataNN2.dens = 2500;
dataNN2.dCylDp= 30;
dataNN2.radsigma = dataNN2.radsigma/10;

[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxMax);
avgMuR2Pos = 9;
avgMuR1Pos = 10;
densityBulkBoxMeanPos = 11;
% save -v7.3testPolidispersityDensityBulkBoxMax.mat
newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);

bulkValue(1).avgMuR2 = newY2(avgMuR2Pos,:);
bulkValue(1).avgMuR1 = newY2(avgMuR1Pos,:);
bulkValue(1).densityBulkBox = newY2(densityBulkBoxMeanPos,:);
bulkValue(1).name = 'DensityBulkBoxMax';


clearvars NNSave2 errorNN2 x2 zz2 errorEstSum2 errorEstIndex2 errorEstSumMaxIndex2 yy2 corrMat2 newY2

[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxMean);
avgMuR2Pos = 9;
avgMuR1Pos = 10;
densityBulkBoxMeanPos = 11;
newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);
% save -v7.3testPolidispersityDensityBulkBoxMean.mat

bulkValue(2).avgMuR2 = newY2(avgMuR2Pos,:);
bulkValue(2).avgMuR1 = newY2(avgMuR1Pos,:);
bulkValue(2).densityBulkBox = newY2(densityBulkBoxMeanPos,:);
bulkValue(2).name = 'DensityBulkBoxMean';


clearvars NNSave2 errorNN2 x2 zz2 errorEstSum2 errorEstIndex2 errorEstSumMaxIndex2 yy2 corrMat2 newY2

[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxMin);
avgMuR2Pos = 9;
avgMuR1Pos = 10;
densityBulkBoxMeanPos = 11;
newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);
% save -v7.3testPolidispersityDensityBulkBoxMin.mat

bulkValue(3).avgMuR2 = newY2(avgMuR2Pos,:);
bulkValue(3).avgMuR1 = newY2(avgMuR1Pos,:);
bulkValue(3).densityBulkBox = newY2(densityBulkBoxMeanPos,:);
bulkValue(3).name = 'DensityBulkBoxMin';

clearvars NNSave2 errorNN2 x2 zz2 errorEstSum2 errorEstIndex2 errorEstSumMaxIndex2 yy2 corrMat2 newY2

[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxPreShearMax);
avgMuR2Pos = 9;
avgMuR1Pos = 10;
densityBulkBoxMeanPos = 11;
newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);
% save -v7.3testPolidispersityDensityBulkBoxPreShearMax.mat

bulkValue(4).avgMuR2 = newY2(avgMuR2Pos,:);
bulkValue(4).avgMuR1 = newY2(avgMuR1Pos,:);
bulkValue(4).densityBulkBox = newY2(densityBulkBoxMeanPos,:);
bulkValue(4).name = 'DensityBulkBoxPreShearMax';

clearvars NNSave2 errorNN2 x2 zz2 errorEstSum2 errorEstIndex2 errorEstSumMaxIndex2 yy2 corrMat2 newY2

[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxPreShearMean);
avgMuR2Pos = 9;
avgMuR1Pos = 10;
densityBulkBoxMeanPos = 11;
newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);
% save -v7.3testPolidispersityDensityBulkBoxPreShearMean.mat

bulkValue(5).avgMuR2 = newY2(avgMuR2Pos,:);
bulkValue(5).avgMuR1 = newY2(avgMuR1Pos,:);
bulkValue(5).densityBulkBox = newY2(densityBulkBoxMeanPos,:);
bulkValue(5).name = 'DensityBulkBoxPreShearMean';

clearvars NNSave2 errorNN2 x2 zz2 errorEstSum2 errorEstIndex2 errorEstSumMaxIndex2 yy2 corrMat2 newY2

[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxPreShearMin);
avgMuR2Pos = 9;
avgMuR1Pos = 10;
densityBulkBoxMeanPos = 11;
newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);
% save -v7.3testPolidispersityDensityBulkBoxPreShearMin.mat

bulkValue(6).avgMuR2 = newY2(avgMuR2Pos,:);
bulkValue(6).avgMuR1 = newY2(avgMuR1Pos,:);
bulkValue(6).densityBulkBox = newY2(densityBulkBoxMeanPos,:);
bulkValue(6).name = 'DensityBulkBoxPreShearMin';

clearvars NNSave2 errorNN2 x2 zz2 errorEstSum2 errorEstIndex2 errorEstSumMaxIndex2 yy2 corrMat2 newY2

[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxShearMax);
avgMuR2Pos = 9;
avgMuR1Pos = 10;
densityBulkBoxMeanPos = 11;
newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);
% save -v7.3testPolidispersityDensityBulkBoxShearMax.mat

bulkValue(7).avgMuR2 = newY2(avgMuR2Pos,:);
bulkValue(7).avgMuR1 = newY2(avgMuR1Pos,:);
bulkValue(7).densityBulkBox = newY2(densityBulkBoxMeanPos,:);
bulkValue(7).name = 'DensityBulkBoxShearMax';

clearvars NNSave2 errorNN2 x2 zz2 errorEstSum2 errorEstIndex2 errorEstSumMaxIndex2 yy2 corrMat2 newY2

[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxShearMean);
avgMuR2Pos = 9;
avgMuR1Pos = 10;
densityBulkBoxMeanPos = 11;
newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);
% save -v7.3testPolidispersityDensityBulkBoxShearMean.mat

bulkValue(8).avgMuR2 = newY2(avgMuR2Pos,:);
bulkValue(8).avgMuR1 = newY2(avgMuR1Pos,:);
bulkValue(8).densityBulkBox = newY2(densityBulkBoxMeanPos,:);
bulkValue(8).name = 'DensityBulkBoxShearMean';

clearvars NNSave2 errorNN2 x2 zz2 errorEstSum2 errorEstIndex2 errorEstSumMaxIndex2 yy2 corrMat2 newY2

[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxShearMin);
avgMuR2Pos = 9;
avgMuR1Pos = 10;
densityBulkBoxMeanPos = 11;
newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);
% save -v7.3testPolidispersityDensityBulkBoxShearMin.mat

bulkValue(9).avgMuR2 = newY2(avgMuR2Pos,:);
bulkValue(9).avgMuR1 = newY2(avgMuR1Pos,:);
bulkValue(9).densityBulkBox = newY2(densityBulkBoxMeanPos,:);
bulkValue(9).name = 'DensityBulkBoxShearMin';

%clearvars NNSave2 errorNN2 x2 zz2 errorEstSum2 errorEstIndex2 errorEstSumMaxIndex2 yy2 corrMat2 newY2

% for i=1:9
% startMinAvgMuR2(i) = bulkValue(i).avgMuR2(1)/max(bulkValue(i).avgMuR2(:));
% startMinAvgMuR1(i) = bulkValue(i).avgMuR1(1)/max(bulkValue(i).avgMuR1(:));
% %startMinRho(i) = bulkValue(i).densityBulkBox(1);
%
% endMaxAvgMuR2(i) = bulkValue(i).avgMuR2(end)/max(bulkValue(i).avgMuR2(:));
% endMaxAvgMuR1(i) = bulkValue(i).avgMuR1(end)/max(bulkValue(i).avgMuR1(:));
% %endMaxRho(i) = bulkValue(i).densityBulkBox(end);
%
% end
%
% for i=4:6
%
% startMinRhoPre(i) = bulkValue(i).densityBulkBox(1)/max(bulkValue(i).densityBulkBox(:));
% endMaxRhoPre(i) = bulkValue(i).densityBulkBox(end)/max(bulkValue(i).densityBulkBox(:));
%
% end
%
% for i=7:9
%
% startMinRhoPost(i) = bulkValue(i).densityBulkBox(1)/max(bulkValue(i).densityBulkBox(:));
% endMaxRhoPost(i) = bulkValue(i).densityBulkBox(end)/max(bulkValue(i).densityBulkBox(:));
%
% end
%
%
% [startMinAvgMuR2Min, startMinAvgMuR2Index] = min(startMinAvgMuR2);
% [startMinAvgMuR1Min, startMinAvgMuR1Index] = min(startMinAvgMuR1);
% [startMinRhoPreMin, startMinRhoPreIndex] = min(startMinRhoPre);
% [startMinRhoPostMin, startMinRhoPostIndex] = min(startMinRhoPost);
% startMinRhoPostIndex = startMinRhoPostIndex+3;
%
% [endMaxAvgMuR2Max, endMaxAvgMuR2Index] = max(endMaxAvgMuR2);
% [endMaxAvgMuR1Max, endMaxAvgMuR1Index] = max(endMaxAvgMuR1);
% [endMaxRhoPreMax, endMaxRhoPreIndex] = max(endMaxRhoPre);
% [startMinRhoPostMin, startMinRhoPostIndex] = min(startMinRhoPost);
% startMinRhoPostIndex = startMinRhoPostIndex+6; %%%BEWARE
% INVERTED!!!!!!!!!!!!!!!!!!
%
% lim = max(dataNN2.radsigma);
% x = [dataNN2.radmu-lim:(lim/499.5):dataNN2.radmu+lim];
%
% for i=1:length(dataNN2.radsigma)
% norm(i,:) = normpdf(x,dataNN2.radmu,dataNN2.radsigma(i)');
% norm(i,:) = norm(i,:)/max(norm(i,:));
% col(i,:)=find(newY2(7,:)==dataNN2.radsigma(i)');
%
% avgMuR2mean(i)= mean(bulkValue(endMaxAvgMuR2Index).avgMuR2(1,col(i,:)));
% avgMuR2std(i)= std(bulkValue(endMaxAvgMuR2Index).avgMuR2(1,col(i,:)));
%
% avgMuR1mean(i)= mean(bulkValue(startMinAvgMuR1Index).avgMuR1(1,col(i,:)));
% avgMuR1std(i)= std(bulkValue(startMinAvgMuR1Index).avgMuR1(1,col(i,:)));
%
% rhoBShearMaxmean(i)= mean(bulkValue(startMinRhoPostIndex).densityBulkBox(1,col(i,:)));
% rhoBShearMaxstd(i)= std(bulkValue(startMinRhoPostIndex).densityBulkBox(1,col(i,:)));
%
% rhoBPreShearMaxmean(i)= mean(bulkValue(startMinRhoPreIndex).densityBulkBox(1,col(i,:)));
% rhoBPreShearMaxstd(i)= std(bulkValue(startMinRhoPreIndex).densityBulkBox(1,col(i,:)));
%
% end
%
% avgMuR2mean = avgMuR2mean./max(avgMuR2mean);
% avgMuR1mean = avgMuR1mean./max(avgMuR1mean);
% rhoBShearMaxmean = rhoBShearMaxmean./max(rhoBShearMaxmean);
% rhoBPreShearMaxmean = rhoBPreShearMaxmean./max(rhoBPreShearMaxmean);
%
% avgMuR2std = avgMuR2std./max(avgMuR2std);
% avgMuR1std = avgMuR1std./max(avgMuR1std);
% rhoBShearMaxstd = rhoBShearMaxstd./max(rhoBShearMaxstd);
% rhoBPreShearMaxmean = rhoBPreShearMaxmean./max(rhoBPreShearMaxmean);

lim = max(dataNN2.radsigma);
x = [dataNN2.radmu-lim:(lim/499.5):dataNN2.radmu+lim];
for j = 1:9
    
    for i=1:length(dataNN2.radsigma)
        norm(i,:) = normpdf(x,dataNN2.radmu,dataNN2.radsigma(i)');
        norm(i,:) = norm(i,:)/max(norm(i,:));
        col(i,:)=find(newY2(7,:)==dataNN2.radsigma(i)');
        
        avgMuR2mean(i,j)= mean(bulkValue(j).avgMuR2(1,col(i,:)));
        avgMuR2std(i,j)= std(bulkValue(j).avgMuR2(1,col(i,:)));
        
        avgMuR1mean(i,j)= mean(bulkValue(j).avgMuR1(1,col(i,:)));
        avgMuR1std(i,j)= std(bulkValue(j).avgMuR1(1,col(i,:)));
        
        rhoBShearMaxmean(i,j)= mean(bulkValue(j).densityBulkBox(1,col(i,:)));
        rhoBShearMaxstd(i,j)= std(bulkValue(j).densityBulkBox(1,col(i,:)));
        
        rhoBPreShearMaxmean(i,j)= mean(bulkValue(j).densityBulkBox(1,col(i,:)));
        rhoBPreShearMaxstd(i,j)= std(bulkValue(j).densityBulkBox(1,col(i,:)));
        
    end
    
    avgMuR2mean(:,j) = avgMuR2mean(:,j)./max(avgMuR2mean(:,j));
    avgMuR1mean(:,j) = avgMuR1mean(:,j)./max(avgMuR1mean(:,j));
    rhoBShearMaxmean(:,j) = rhoBShearMaxmean(:,j)./max(rhoBShearMaxmean(:,j));
    rhoBPreShearMaxmean(:,j) = rhoBPreShearMaxmean(:,j)./max(rhoBPreShearMaxmean(:,j));
    
    avgMuR2std(:,j) = avgMuR2std(:,j)./max(avgMuR2std(:,j));
    avgMuR1std(:,j) = avgMuR1std(:,j)./max(avgMuR1std(:,j));
    rhoBShearMaxstd(:,j) = rhoBShearMaxstd(:,j)./max(rhoBShearMaxstd(:,j));
    rhoBPreShearMaxmean(:,j) = rhoBPreShearMaxmean(:,j)./max(rhoBPreShearMaxmean(:,j));
    
    
    
    
    
end

[startMinAvgMuR2Min, startMinAvgMuR2Index] = min(avgMuR2mean(1,:));
[startMinAvgMuR1Min, startMinAvgMuR1Index] = min(avgMuR1mean(1,:));
[startMinRhoPreMin, startMinRhoPreIndex] = min(rhoBPreShearMaxmean(1,4:6));
startMinRhoPreIndex = startMinRhoPreIndex + 3;
[startMinRhoPostMin, startMinRhoPostIndex] = min(rhoBShearMaxmean(1,7:9));
startMinRhoPostIndex = startMinRhoPostIndex + 6;

h1=figure(6);
%plot(dataNN2.radsigma',avgMuR2mean,dataNN2.radsigma',avgMuR1mean,dataNN2.radsigma',rhoBShearMaxmean,dataNN2.radsigma',rhoBPreShearMaxmean)
plot(dataNN2.radsigma',avgMuR2mean(:,startMinAvgMuR2Index),dataNN2.radsigma',avgMuR1mean(:, startMinAvgMuR1Index),dataNN2.radsigma',rhoBShearMaxmean(:,startMinRhoPostIndex ),dataNN2.radsigma',rhoBPreShearMaxmean(:, startMinRhoPreIndex))
xlabel('std dev radius [m]');
% ylabel('zPos [m]');
legend('avgMuR2mean [-]','avgMuR1mean [-]', 'rhoBShearMaxmean [-]', 'rhoBPreShearMaxmean [-]','Location', 'SouthEast' );
print(h1,'-djpeg','-r300',['0',num2str(41+i),'simulationRadiusDistribution',num2str(i)])

save -v7.3 testPolidispersityDensityBulkBoxBis.mat
