function [ gloriaAugustaSchulzeNN, a2 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, angleExp, numFig, material)

%RADARPRINTAORVECTORIALPOLIDISPERSITYFUN identify valid parameters and
% plot them in a radar plot

if (isunix)
    addpath('/mnt/DATA/liggghts/work/shearCell/matlab/exportFig');
else
    addpath('E:\liggghts\work\shearCell\matlab\exportFig');
end

kkk=1;
coeffPirker = 1.0;

newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);
[nY2rows,nY2column] = size(newY2);

newY2rows =   nY2rows  ;
newY2(newY2rows+1,:) = newY2(newY2rows-1,:)/angleExp; %ratioAORLi
%newY2(newY2rows+2,:) = newY2(newY2rows,:)/angleExp;   %ratioAORMa
newY2(newY2rows+2,:) = abs(1- newY2(newY2rows+1,:));  %deltaRatioAORLi
%  newY2(newY2rows+4,:) = abs(1- newY2(newY2rows+2,:));  %deltaRatioAORMa


temp_v = newY2( (newY2rows+2), : );
temp_i = find (temp_v < 0.05);
ni = size(temp_i,2);
gloriaAugustaAorNNLi = zeros( kkk+size(temp_i,2)-1, newY2rows+4 );
gloriaAugustaAorNNLi( kkk:(kkk+ni-1), 1) = temp_i';
gloriaAugustaAorNNLi( kkk:(kkk+ni-1), 2:(newY2rows+3) ) = newY2( :, temp_i )';
gloriaAugustaAorNNLi( kkk:(kkk+ni-1), newY2rows+4) = 1;

if (ni>0)
    
    clearvars gloriaAugustaSchulzeNN X Y Z S C G
    gloriaAugustaSchulzeNN = gloriaAugustaAorNNLi';%(1:size(gloriaAugustaSchulzeNNDens,1)-1, :)';
    
    X=gloriaAugustaSchulzeNN(3,:); %sf
    Y=gloriaAugustaSchulzeNN(4,:); %rf
    % Z=gloriaAugustaSchulzeNN(9,:); %density
    S=gloriaAugustaSchulzeNN(2,:); %cor
    % C=gloriaAugustaSchulzeNN(10,:);%avgMuR2
    C=gloriaAugustaSchulzeNN(9,:);%aorLi
    Z=gloriaAugustaSchulzeNN(7,:); %density
    
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
    
    formatOut = 'yyyy-mm-dd-HH-MM-SS';
    date1 = datestr(now,formatOut);
    
    h1 = figure(numFig);
    a2 = radarPlot(G);
    legend('minInput','min', '\mu - \sigma', '\mu', '\mu + \sigma', 'max', 'maxInput'); %, 'FontSize',24)
    if (exist('material','var'))
        title ([material, ', angleExp = ', num2str(angleExp), 'coeff. P. = ', num2str(coeffPirker)] ,'FontSize',24);
        set(gca,'fontname','times new roman','FontSize',20);
        set(h1, 'Position', [100 100 1500 800],'color','w');;
        export_fig([material, ', angleExp = ', num2str(angleExp), 'coeff. P. = ', num2str(coeffPirker),date1],'-jpg', '-nocrop', h1);
    else
        title (['angleExp = ', num2str(angleExp), 'coeff. P. = ', num2str(coeffPirker)] ,'FontSize',24);
    end
    
else a2=0; gloriaAugustaSchulzeNN = 0;
end
end

