X=newY2(1,:); %cor
Y=newY2(2,:); %sf
Z=newY2(3,:); %rf
S=newY2(7,:); %radsigma

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


G(1,1)= minS;
G(1,2)= minS;
G(1,3)= meanS - stdS;
G(1,4)= meanS;
G(1,5)= meanS + stdS;
G(1,6)= maxS;
G(1,7)= maxS;

G(2,1)= minX;
G(2,2)= minX;
G(2,3)= meanX - stdX;
G(2,4)= meanX;
G(2,5)= meanX + stdX;
G(2,6)= maxX;
G(2,7)= maxX;

G(3,1)= minY;
G(3,2)= minY;
G(3,3)= meanY - stdY;
G(3,4)= meanY;
G(3,5)= meanY + stdY;
G(3,6)= maxY;
G(3,7)= maxY;

G(4,1)= minZ;
G(4,2)= minZ;
G(4,3)= max(meanZ - stdZ, minZ);
G(4,4)= meanZ;
G(4,5)= meanZ + stdZ;
G(4,6)= maxZ;
G(4,7)= maxZ;

figure(1)
a2 = radarPlot(G)
legend('minInput','min', '\mu - \sigma', '\mu', '\mu + \sigma', 'max', 'maxInput'); %, 'FontSize',24)