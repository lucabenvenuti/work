    dataNN2.rest = sort(0.5 + (0.9-0.5).*rand(50,1)); %a + (b-a).*rand(10,1);%[0.5:0.1:0.9];
    dataNN2.sf= sort(0.05 + (1.0-0.05).*rand(100,1)); %[0.1:0.1:1];
    dataNN2.rf= sort(0.05 + (1.0-0.05).*rand(100,1)); %[0.1:0.1:1];
    dataNN2.dt= 1e-6; %[1e-7:1e-7:1e-6];
    dataNN2.dCylDp= 20;%[20:1:50];
    dataNN2.ctrlStress = 1068;% [1068,2069,10070];
    dataNN2.shearperc = 1.0;   
    if (exist('densityBulkBoxMean'))
       dataNN2.dens = sort(2000 + (3500-2000).*rand(50,1)); %[2000:100:3500];
    end   
    
    dataNN2.rest = sort(0.5 + (0.9-0.5).*rand(25,1)); %a + (b-a).*rand(10,1);%[0.5:0.1:0.9];
    dataNN2.sf= sort(0.05 + (1.0-0.05).*rand(100,1)); %[0.1:0.1:1];
    dataNN2.rf= sort(0.05 + (1.0-0.05).*rand(100,1)); %[0.1:0.1:1];
    dataNN2.dt= 1e-6; %[1e-7:1e-7:1e-6];
    dataNN2.dCylDp= 50;%[20:1:50];
    dataNN2.ctrlStress = 1068;% [1068,2069,10070];
    dataNN2.shearperc = [0.4:0.2:1.0];  %1.0;   
    if (exist('densityBulkBoxMean'))
       dataNN2.dens = sort(2000 + (3500-2000).*rand(25,1)); %[2000:100:3500];
    end      
       
    dataNN2.rest = sort(0.5 + (0.9-0.5).*rand(25,1)); %a + (b-a).*rand(10,1);%[0.5:0.1:0.9];
    dataNN2.sf= sort(0.05 + (2.0-0.05).*rand(100,1)); %[0.1:0.1:1];
    dataNN2.rf= sort(0.05 + (2.0-0.05).*rand(100,1)); %[0.1:0.1:1];
    dataNN2.dt= 1e-6; %[1e-7:1e-7:1e-6];
    dataNN2.dCylDp= 50;%[20:1:50];
    dataNN2.ctrlStress = 1068;% [1068,2069,10070];
    dataNN2.shearperc = [0.4:0.2:1.0];  %1.0;   
    if (exist('densityBulkBoxMean'))
       dataNN2.dens = sort(2000 + (3500-2000).*rand(25,1)); %[2000:100:3500];
    end      
           
%     X=gloriaAugustaSchulzeNN(3,:); %sf
%     Y=gloriaAugustaSchulzeNN(4,:); %rf
%     Z=gloriaAugustaSchulzeNN(9,:); %density
%     S=gloriaAugustaSchulzeNN(2,:); %cor
%     C=gloriaAugustaSchulzeNN(10,:);%avgMuR2
       %% radar plot
    P(1,:)=S;
    P(2,:)=X;
    P(3,:)=Y;
    P(4,:)=Z;
    P(5,:)=C;
    for i=1:20
    a(i)=randi([1, 411]);
    end
    b=sort(a)
    a1 = radarPlot( P(:,b))
    
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
     G(1,2)= meanS - stdS;
     G(1,3)= meanS;
     G(1,4)= meanS + stdS;
     G(1,5)= maxS;
     
     G(2,1)= minX;
     G(2,2)= meanX - stdX;
     G(2,3)= meanX;
     G(2,4)= meanX + stdX;
     G(2,5)= maxX;
     
     G(3,1)= minY;
     G(3,2)= meanY - stdY;
     G(3,3)= meanY;
     G(3,4)= meanY + stdY;
     G(3,5)= maxY;
     
     G(4,1)= minZ;
     G(4,2)= meanZ - stdZ;
     G(4,3)= meanZ;
     G(4,4)= meanZ + stdZ;
     G(4,5)= maxZ;
     
     figure(5)
     a2 = radarPlot( G)
     legend('min', '\mu - \sigma', '\mu', '\mu + \sigma', 'max')
     
%     X=gloriaAugustaSchulzeNN(3,:); %sf
%     Y=gloriaAugustaSchulzeNN(4,:); %rf
%     Z=gloriaAugustaSchulzeNN(9,:); %density
%     S=gloriaAugustaSchulzeNN(2,:); %cor
%     C=gloriaAugustaSchulzeNN(10,:);%avgMuR2
% P(1,:)=S;
%     P(2,:)=X;
%     P(3,:)=Y;
%     P(4,:)=Z;
% meanS = mean(S)
% 
% meanS =
% 
%     0.5490
% 
% meanX = mean(X)
% 
% meanX =
% 
%     0.1979
% 
% meanY = mean(Y)
% 
% meanY =
% 
%     0.5124
% 
% meanZ = mean(Z)
% 
% meanZ =
% 
%    2.1650e+03
% 
% stdS  = std(S)
% 
% stdS =
% 
%     0.0321
% 
% stdX  = std(X)
% stdY  = std(Y)
% 
% stdX =
% 
%     0.0660
% 
% 
% stdY =
% 
%     0.2906
% 
% stdZ  = std(Z)
% 
% stdZ =
% 
%    93.0302

% minS
% 
% minS =
% 
%     0.5099
% 
% minX
% minY
% 
% minX =
% 
%     0.0543
% 
% 
% minY =
% 
%     0.0548
% 
% minZ
% 
% minZ =
% 
%    2.0050e+03
% 
% maxS
% maxX
% 
% maxS =
% 
%     0.6904
% 
% 
% maxX =
% 
%     0.3810
% 
% maxY
% 
% maxY =
% 
%     0.9980
% 
% maxZ
% 
% maxZ =
% 
%    3.4974e+03

    dataNN21.rest=[0.5:0.05:0.9];
    dataNN21.sf=[0.05:0.05:1];
    dataNN21.rf=[0.05:0.05:1];
    dataNN21.dt= 1e-6; %[1e-7:1e-7:1e-6];
    dataNN21.dCylDp= 50;%[20:1:50];
    dataNN21.ctrlStress = 1068;% [1068,2069,10070];
    dataNN21.shearperc = [0.4:0.2:1.0];   
    if (exist('densityBulkBoxMean'))
       dataNN21.dens = [2000:100:3500];
       densTolerance =1.4; 
    end
    newY21 = myNewInput(NNSave2, errorEstSumMaxIndex2, dataNN21);        
    [nY21rows,nY21column] = size(newY2);
