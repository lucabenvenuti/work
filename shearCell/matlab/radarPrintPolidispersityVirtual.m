%/mnt/benvenutiPFMDaten/Materials2Simulation2Application_RnR/BS/Luca_final/20131129_1059_limestone0-315_test03

clear all
close all
clc

% load /mnt/scratchPFMDaten/Luca/testPolidispersityShearCellCokeCoarseCokeFineSinterFineLimestoneFineMatlab/DensityBulkBoxPreShearMaxTest.mat
%load S:\Luca\testShearCellPoli20150428\elaboratedTest02Completed.mat

%load S:\Luca\testShearCellPoli20150428\testPolidispersityDensityBulkBoxBis.mat
%load S:\Luca\testShearCellPoli20150428\testPolidispersityDensityBulkBoxQuater.mat
load testPolidispersityDensityBulkBoxSepties.mat
%exp_file_name = '20131129_1059_limestone0-315_test03';sexies

clearvars newY3

prob = mode([startMinAvgMuR2Index startMinAvgMuR1Index startMinRhoPreIndex startMinRhoPostIndex]);

exp_file_name_list = {'20131001_1117_Iron_ore',1;'20131001_1157_Iron_ore',2;'20131001_13011_Iron_ore',3;'20131128_0957_PP_test01',4;'20131128_1016_PP_test02',5;'20131128_1058_PP_test03',6;'20131128_1114_PP_test04',7;'20131128_1140_PP_test05',8;'20131128_1158_silibeads2mm_test01',9;'20131128_1218_silibeads2mm_test02',10;'20131128_1238_silibeads2mm_test03',11;'20131128_1443_silibeads4mm_test01',12;'20131128_1517_silibeads4mm_test02',13;'20131128_1612_sinterfine315-10_test01',14;'20131128_1712_sinterfine315-10_test02',15;'20131128_1742_sinterfine315-10_test03',16;'20131128_1824_sinterfine0-315_test01',17;'20131128_1851_sinterfine0-315_test02',18;'20131128_1951_sinterfine0-315_test03',19;'20131129_0841_sinterfine0-315_test04',20;'20131129_0921_limestone315-10_test01',21;'20131129_1000_limestone315-10_test02',22;'20131129_1019_limestone0-315_test01',23;'20131129_1035_limestone0-315_test02',24;'20131129_1059_limestone0-315_test03',25;'20131129_1121_limestone0-315_test04',26;'20131129_1155_coal315-10_test01',27;'20131129_1245_coal315-10_test02',28;'20131129_1356_coal0-315_test02',29;'20131129_1418_coal0-315_test03',30;'20131129_1437_coal0-315_test04',31;'20131129_1514_ironore315-10_test01',32;'20131129_1554_ironore315-10_test02',33;'20131129_1610_ironore0-315_test01',34;'20131129_1629_ironore0-315_test02',35;'20131129_1648_ironore0-315_test03',36;'20131129_1713_ironore0-315_test04',37;'20131129_1733_ironore0-315_test05',38;'20131129_1831_ironore315-10_test03',39;'20131129_1854_saatbau_test01',40;'20131129_1915_perlite_test01',41;'Iron_ore1030-011013',42;'Iron_ore1030-011013.in',43};
exp_file_name = exp_file_name_list{25,1}; 
[coeffShear40, coeffShear60, coeffShear80, coeffShear100, expFtd, expInp, expOut] = experimentalImport(exp_file_name );
coeffPirker = 1.0;
densTolerance = 0.05;
fricTolerance = 0.05;

newY3(1,:) = newY2(1,:);
newY3(2,:) = newY2(2,:);
newY3(3,:) = newY2(3,:);
newY3(4,:) = newY2(7,:);

avgMuR2Pos = 5;
avgMuR1Pos = 6;
densityPostPos = 7;
densityPrePos = 8;

clearvars newY2
% startMinAvgMuR2Index = 10 ;
% startMinAvgMuR1Index = 10 ;
% startMinRhoPostIndex = 11 ;
% startMinRhoPreIndex  = 12 ;

newY3(avgMuR2Pos,:) = bulkValue(startMinAvgMuR2Index).avgMuR2;
newY3(avgMuR1Pos,:) = bulkValue(startMinAvgMuR1Index).avgMuR1;
newY3(densityPostPos,:) = bulkValue(startMinRhoPostIndex).densityBulkBox;
newY3(densityPrePos,:) = bulkValue(startMinRhoPreIndex).densityBulkBox;
%plot(dataNN2.radsigma',avgMuR2mean(:,startMinAvgMuR2Index),dataNN2.radsigma',avgMuR1mean(:, startMinAvgMuR1Index),dataNN2.radsigma',rhoBShearMaxmean(:,startMinRhoPostIndex ),dataNN2.radsigma',rhoBPreShearMaxmean(:, startMinRhoPreIndex))

[nY3rows,nY3column] = size(newY3);

jjj=1;
kkk=1;
ii=1;
meanExpFtdRhoB = mean(expFtd.rhoB);
maxExpFtdRhoB  = max(expFtd.rhoB);
minExpFtdRhoB  = min(expFtd.rhoB);

coeffShear40 = coeffShear40*coeffPirker;
expOut.coeffPreShear40 = expOut.coeffPreShear40*coeffPirker;

coeffShear60 = coeffShear60*coeffPirker;
expOut.coeffPreShear60 = expOut.coeffPreShear60*coeffPirker;

coeffShear80 = coeffShear80*coeffPirker;
expOut.coeffPreShear80 = expOut.coeffPreShear80*coeffPirker;

coeffShear100 = coeffShear100*coeffPirker;
expOut.coeffPreShear100 = expOut.coeffPreShear100*coeffPirker;


newY3(nY3rows+1,:) = newY3(avgMuR2Pos,:)/coeffShear100;
newY3(nY3rows+2,:) = newY3(avgMuR1Pos,:)/expOut.coeffPreShear100 ;
newY3(nY3rows+3,:) = expOut.tauAbPr100; %expInp.tauAb100;
newY3(nY3rows+4,:) = expOut.sigmaAnM;% expOut.sigmaAb100;
newY3(nY3rows+5,:) = coeffShear100;
newY3(nY3rows+6,:) = expOut.tauAbPr100;
newY3(nY3rows+7,:) = expOut.coeffPreShear100;
newY3(nY3rows+8,:) = expOut.rhoBAnM;

nY3rowsBis = nY3rows+8;

newY3(nY3rowsBis+1,:) =  abs(1- newY3(nY3rows+1,:));
%data(ii).deltaRatioPreShear = abs(1-data(ii).ratioPreShear);
newY3(nY3rowsBis+2,:) =  abs(1- newY3(nY3rows+2,:));

newY3(nY3rowsBis+3,:) =  meanExpFtdRhoB;%mean(expFtd.rhoB);
newY3(nY3rowsBis+4,:) =  maxExpFtdRhoB;%max(expFtd.rhoB);
newY3(nY3rowsBis+5,:) =  minExpFtdRhoB;%min(expFtd.rhoB);

ii=1;
kkk=1;
ni=1;
temp_vi = newY3( (nY3rowsBis+1), : );
temp_i = find (temp_vi < fricTolerance);
temp_vj = newY3( (nY3rowsBis+2), : );
temp_j = find (temp_vj < fricTolerance);
temp_vk = newY3( densityPostPos, : );
temp_k = find (temp_vk < maxExpFtdRhoB*(1.0+densTolerance));
temp_l = find (temp_vk > minExpFtdRhoB*(1.0-densTolerance));

temp_vm = newY3( densityPrePos, : );
temp_m = find (temp_vm < maxExpFtdRhoB*(1.0+densTolerance));
temp_n = find (temp_vm > minExpFtdRhoB*(1.0-densTolerance));

[Cij,aij,bij] = intersect(temp_i,temp_j);
[Ckl,akl,bkl] = intersect(temp_k,temp_m);
if (size(akl,1)<1)
    [Ckl,akl,bkl] = intersect(temp_l,temp_n);
end
[Cijkl,aijkl,bijkl] = intersect(Cij,Ckl);

ni = size(Cijkl,2) ;

nY3rowsTris = nY3rowsBis+5;

gloriaAugustaSchulzeNNDens = zeros( ni,  nY3rowsTris+2);

gloriaAugustaSchulzeNNDens( kkk:(kkk+ni-1), 1) = Cijkl';
%
gloriaAugustaSchulzeNNDens(kkk:ni, 2:(nY3rowsTris+1) ) = newY3( :, Cijkl )';
%
gloriaAugustaSchulzeNNDens( kkk:ni, nY3rowsTris+2) =1;

kkk = kkk + ni

clearvars gloriaAugustaSchulzeNN X Y Z S C G
gloriaAugustaSchulzeNN = gloriaAugustaSchulzeNNDens';%(1:size(gloriaAugustaSchulzeNNDens,1)-1, :)';

X=gloriaAugustaSchulzeNN(2,:); %cor
Y=gloriaAugustaSchulzeNN(3,:); %sf
Z=gloriaAugustaSchulzeNN(4,:); %rf
S=gloriaAugustaSchulzeNN(5,:); %rad_sigma

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

G(1,1)= minS; %0.52; %min(dataNN2.rest); %S
G(1,2)= minS;
G(1,3)= meanS - stdS;
G(1,4)= meanS;
G(1,5)= meanS + stdS;
G(1,6)= maxS;
G(1,7)= maxS; %0.86 ; %max(dataNN2.rest); %S

G(2,1)= minX; %0.06; %min(dataNN2.sf); %X
G(2,2)= minX;
G(2,3)= meanX - stdX;
G(2,4)= meanX;
G(2,5)= meanX + stdX;
G(2,6)= maxX;
G(2,7)= maxX; %0.98; % max(dataNN2.sf); %X

G(3,1)= minY;% 0.06; %min(dataNN2.rf); %Y
G(3,2)= minY;
G(3,3)= meanY - stdY;
G(3,4)= meanY;
G(3,5)= meanY + stdY;
G(3,6)= maxY;
G(3,7)= maxY; %0.99; %max(dataNN2.rf); %Y

G(4,1)= minZ; %2027; %min(dataNN2.dens); %Z
G(4,2)= minZ;
G(4,3)= max(meanZ - stdZ, minZ);
G(4,4)= meanZ;
G(4,5)= meanZ + stdZ;
G(4,6)= maxZ;
G(4,7)= maxZ; %3499; %max(dataNN2.dens); %Z

formatOut = 'yyyy-mm-dd-HH-MM-SS';
date1 = datestr(now,formatOut);

h1=figure(1)
a2 = radarPlot(G)
legend('minInput','min', '\mu - \sigma', '\mu', '\mu + \sigma', 'max', 'maxInput'); %, 'FontSize',24)
title ([exp_file_name, 'SRSCT: normal stress = ', num2str(dataNN2.ctrlStress), ' [Pa], coeff. P. = ', num2str(coeffPirker)] ,'FontSize',24);
set(gca,'fontname','times new roman','FontSize',20)  % Set it to times
set(h1, 'Position', [100 100 1500 800],'color','w');
print(h1,'-djpeg','-r300',[exp_file_name, 'SRSCTnormalstress', num2str(dataNN2.ctrlStress), 'PacoeffP', num2str(coeffPirker*10),'0',num2str(41+i),'radarPlot',num2str(i),date1])
%export_fig [exp_file_name, 'SRSCTnormalstress', num2str(dataNN2.ctrlStress), 'PacoeffP', num2str(coeffPirker*10),'0',num2str(41+i),'radarPlot',num2str(i),date1,.jpg]
addpath('/mnt/DATA/liggghts/work/shearCell/matlab/exportFig');
export_fig([exp_file_name, 'SRSCTnormalstress', num2str(dataNN2.ctrlStress), 'PacoeffP', num2str(coeffPirker*10),'0',num2str(41+i),'radarPlot',num2str(i),date1],'-jpg', '-nocrop', h1);
%save -v7.3 testPolidispersityDensityBulkBoxTris.mat

% k=1;
% 
% for i = 1:length(aa)
% 
%     j= findstr(aa(i).name,'.FTD');
%     if (j > 0)
%        
%         ab{k} = aa(i).name(1:j-1);
%         
%         k = k+1;
%     end
%     
% end
