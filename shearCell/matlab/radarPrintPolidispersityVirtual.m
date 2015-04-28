%/mnt/benvenutiPFMDaten/Materials2Simulation2Application_RnR/BS/Luca_final/20131129_1059_limestone0-315_test03

% clear all
% close all
% clc
%
% load /mnt/scratchPFMDaten/Luca/testPolidispersityShearCellCokeCoarseCokeFineSinterFineLimestoneFineMatlab/DensityBulkBoxPreShearMaxTest.mat
exp_file_name = '20131129_1059_limestone0-315_test03';
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

X=gloriaAugustaSchulzeNN(2,:); %sf
Y=gloriaAugustaSchulzeNN(3,:); %rf
Z=gloriaAugustaSchulzeNN(4,:); %density
S=gloriaAugustaSchulzeNN(5,:); %cor

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

h1=figure(1)
a2 = radarPlot(G)
legend('minInput','min', '\mu - \sigma', '\mu', '\mu + \sigma', 'max', 'maxInput'); %, 'FontSize',24)
title ([exp_file_name, 'SRSCT: normal stress = ', num2str(dataNN2.ctrlStress), ' [Pa], coeff. P. = ', num2str(coeffPirker)] ,'FontSize',24);
print(h1,'-djpeg','-r300',['0',num2str(41+i),'radarPlot',num2str(i)])

save -v7.3 testPolidispersityDensityBulkBoxTris.mat
