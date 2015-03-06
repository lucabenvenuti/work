% gloriaAugustaAORNN = gloriaAugustaAorNNMa';
% inter1=gloriaAugustaAORNN([2,3,4,7],:);
% inter2=gloriaAugustaSchulzeNN([2,3,4,9],:);
% inter1=inter1';
% inter2=inter2';
% [Cia,ia,ib] = intersect(inter1(:,[1,2,3,4]),inter2(:,[1,2,3,4]),'rows')
% [Cia,ia,ib] = intersect(inter1,inter2,'rows');
% 
% gloriaAugustaSchulzeNN = Cia';
% 
%     X=gloriaAugustaSchulzeNN(2,:); %sf
%     Y=gloriaAugustaSchulzeNN(3,:); %rf
%     Z=gloriaAugustaSchulzeNN(4,:); %density
%     S=gloriaAugustaSchulzeNN(1,:); %cor
%   %  C=gloriaAugustaSchulzeNN(10,:);%avgMuR2
%     %C=gloriaAugustaSchulzeNN(8,:);%aorLi
%     %Z=gloriaAugustaSchulzeNN(7,:); %density
%     best = find(Cia(:,3)<0.6);
%     for i =1:length(best)
% winner(:,i)=gloriaAugustaSchulzeNNDens(:,best(i));
%     end
% 
%     for i =1:length(best)
% winner(:,i)=Cia(best(i),:);
%     end
clear all
close all
clc

load('/mnt/DATA/liggghts/work/aorStatic/matlab/gloriaAugustaSchulzeNNPolidispersity.mat')
load('/mnt/DATA/liggghts/work/aorStatic/matlab/gloriaAugustaAorNNPolidispersity.mat')
    
sinter1 = gloriaAugustaSchulzeNNDens02(:,[2,3,4,9]); %2057
sinter2 = gloriaAugustaSchulzeNNDens03(:,[2,3,4,9]); %5059
sinter3 = gloriaAugustaAorNN01([2,3,4,7],:)';

[Cia,ia,ib] = intersect(sinter2,sinter3,'rows');
gloriaAugustaSchulzeNN = Cia';
X=gloriaAugustaSchulzeNN(2,:); %sf
Y=gloriaAugustaSchulzeNN(3,:); %rf
Z=gloriaAugustaSchulzeNN(4,:); %density
S=gloriaAugustaSchulzeNN(1,:); %cor
numFig = 6

%a2 = radarPlot(G)
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
G(1,1)= 0.50; %min(dataNN2.rest); %S
G(1,2)= minS;
G(1,3)= meanS - stdS;
G(1,4)= meanS;
G(1,5)= meanS + stdS;
G(1,6)= maxS;
G(1,7)= 0.889 ; %max(dataNN2.rest); %S
G(2,1)= 0.05; %min(dataNN2.sf); %X
G(2,2)= minX;
G(2,3)= meanX - stdX;
G(2,4)= meanX;
G(2,5)= meanX + stdX;
G(2,6)= maxX;
G(2,7)= 0.999; % max(dataNN2.sf); %X
G(3,1)= 0.06; %min(dataNN2.rf); %Y
G(3,2)= minY;
G(3,3)= meanY - stdY;
G(3,4)= meanY;
G(3,5)= meanY + stdY;
G(3,6)= maxY;
G(3,7)= 0.999; %max(dataNN2.rf); %Y
G(4,1)= 2080; %min(dataNN2.dens); %Z
G(4,2)= minZ;
G(4,3)= max(meanZ - stdZ, minZ);
G(4,4)= meanZ;
G(4,5)= meanZ + stdZ;
G(4,6)= maxZ;
G(4,7)= 3463; %max(dataNN2.dens); %Z
figure(11)
a2 = radarPlot(G)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % [Cia2,ia2,ib2] = intersect(Cia,sinter1,'rows');
clearvars Cia gloriaAugustaSchulzeNN
limestone1 = gloriaAugustaSchulzeNNDens05(:,[2,3,4,9]); %5050
limestone2 = gloriaAugustaAorNN02([2,3,4,7],:)';

% sinter1 = gloriaAugustaSchulzeNNDens02(:,[2,3,4,9]); %2057
% sinter2 = gloriaAugustaSchulzeNNDens03(:,[2,3,4,9]); %5059
% sinter3 = gloriaAugustaAorNN01([2,3,4,7],:)';

[Cia,ia,ib] = intersect(limestone1,limestone2,'rows');
gloriaAugustaSchulzeNN = Cia';
X=gloriaAugustaSchulzeNN(2,:); %sf
Y=gloriaAugustaSchulzeNN(3,:); %rf
Z=gloriaAugustaSchulzeNN(4,:); %density
S=gloriaAugustaSchulzeNN(1,:); %cor
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
G(1,1)= 0.50; %min(dataNN2.rest); %S
G(1,2)= minS;
G(1,3)= meanS - stdS;
G(1,4)= meanS;
G(1,5)= meanS + stdS;
G(1,6)= maxS;
G(1,7)= 0.889 ; %max(dataNN2.rest); %S
G(2,1)= 0.05; %min(dataNN2.sf); %X
G(2,2)= minX;
G(2,3)= meanX - stdX;
G(2,4)= meanX;
G(2,5)= meanX + stdX;
G(2,6)= maxX;
G(2,7)= 0.999; % max(dataNN2.sf); %X
G(3,1)= 0.06; %min(dataNN2.rf); %Y
G(3,2)= minY;
G(3,3)= meanY - stdY;
G(3,4)= meanY;
G(3,5)= meanY + stdY;
G(3,6)= maxY;
G(3,7)= 0.999; %max(dataNN2.rf); %Y
G(4,1)= 2080; %min(dataNN2.dens); %Z
G(4,2)= minZ;
G(4,3)= max(meanZ - stdZ, minZ);
G(4,4)= meanZ;
G(4,5)= meanZ + stdZ;
G(4,6)= maxZ;
G(4,7)= 3463; %max(dataNN2.dens); %Z
figure(12)
a2 = radarPlot(G)