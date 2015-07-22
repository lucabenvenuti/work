function [ h1 , a2 ] = intersectionPlotRadarFun( res , loopNumber)

X=res.Cia(:,1); %cor
Y=res.Cia(:,2); %sf
Z=res.Cia(:,3); %rf
S=res.Cia(:,4); %rad_sigma

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

clearvars h1

h1=figure(loopNumber);
a2 = radarPlot(G);
legend('minInput','min', '\mu - \sigma', '\mu', '\mu + \sigma', 'max', 'maxInput'); %, 'FontSize',24)
title ([res.material, ', intersection Shear Cell 5000 Pa and coeff. P. = 1 and AoR '] ,'FontSize',24);
set(gca,'fontname','times new roman','FontSize',20)  % Set it to times
set(h1, 'Position', [100 100 1500 800])

if (isunix)
    addpath('/mnt/DATA/liggghts/work/shearCell/matlab/exportFig');
else
    addpath('E:\liggghts\work\shearCell\matlab\exportFig');
end
export_fig([res.material, ', intersection Shear Cell 5000 Pa and coeff. P. = 1 and AoR ',num2str(loopNumber), ' ',date1],'-jpg', '-nocrop', h1);
end