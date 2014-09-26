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

