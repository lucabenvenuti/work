function a2 = radarPrintVectorialFun( gloriaAugustaSchulzeNN, aorFlag, numFig, dataNN2, exp_file_name, coeffPirker)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

switch aorFlag
    case 1 %aor
        X=gloriaAugustaSchulzeNN(3,:); %sf
        Y=gloriaAugustaSchulzeNN(4,:); %rf
        S=gloriaAugustaSchulzeNN(2,:); %cor
        Z=gloriaAugustaSchulzeNN(7,:); %density
    case 2 %mix
        X=gloriaAugustaSchulzeNN(2,:); %sf
        Y=gloriaAugustaSchulzeNN(3,:); %rf
        S=gloriaAugustaSchulzeNN(1,:); %cor
        Z=gloriaAugustaSchulzeNN(4,:); %density
    otherwise %sct
        X=gloriaAugustaSchulzeNN(3,:); %sf
        Y=gloriaAugustaSchulzeNN(4,:); %rf
        S=gloriaAugustaSchulzeNN(2,:); %cor
        Z=gloriaAugustaSchulzeNN(9,:); %density
end

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

if isa(dataNN2, 'struct') 
    G(1,1)= min(dataNN2.rest); %S
else
    G(1,1)= minS;
end
G(1,2)= minS;
G(1,3)= meanS - stdS;
G(1,4)= meanS;
G(1,5)= meanS + stdS;
G(1,6)= maxS;
if isa(dataNN2, 'struct') 
    G(1,7)= max(dataNN2.rest); %S
else
    G(1,7)= maxS;
end

if isa(dataNN2, 'struct') 
    G(2,1)= min(dataNN2.sf); %X
else
    G(2,1)= minX;
end
G(2,2)= minX;
G(2,3)= meanX - stdX;
G(2,4)= meanX;
G(2,5)= meanX + stdX;
G(2,6)= maxX;
if isa(dataNN2, 'struct') 
    G(2,7)= max(dataNN2.sf); %X
else
    G(2,7)= maxX;
end

if isa(dataNN2, 'struct') 
    G(3,1)= min(dataNN2.rf); %Y
else
    G(3,1)= minY;
end
G(3,2)= minY;
G(3,3)= meanY - stdY;
G(3,4)= meanY;
G(3,5)= meanY + stdY;
G(3,6)= maxY;
if isa(dataNN2, 'struct') 
    G(3,7)= max(dataNN2.rf); %Y
else
    G(3,7)= maxY;
end

if isa(dataNN2, 'struct') 
    G(4,1)= min(dataNN2.dens); %Z
else
    G(4,1)= minZ;
end
G(4,2)= minZ;
G(4,3)= max(meanZ - stdZ, minZ);
G(4,4)= meanZ;
G(4,5)= meanZ + stdZ;
G(4,6)= maxZ;
if isa(dataNN2, 'struct') 
    G(4,7)= max(dataNN2.dens); %Z
else
    G(4,7)= maxZ;
end

handler = figure(numFig);
a2 = radarPlot(G);
legend('minInput','min', '\mu - \sigma', '\mu', '\mu + \sigma', 'max', 'maxInput'); %, 'FontSize',24)
set(gca,'fontname','times new roman','FontSize',20)
set(handler, 'Position', [100 100 1500 800],'color','w');

formatOut = 'yyyy-mm-dd-HH-MM-SS';
date1 = datestr(now,formatOut);

switch aorFlag
    case 1 %aor
        savefig(['ParamSpaceAOR', exp_file_name, date1, '.fig']);
    case 2 %mix
        savefig(['ParamSpaceMix', date1, '.fig']);
    otherwise %sct
        savefig(['ParamSpaceSCT', exp_file_name, 'coeffP', num2str(coeffPirker),date1, '.fig']);
end

end