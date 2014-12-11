    clearvars newY2 newY22 gloriaAugustaSchulzeNN dataNN2 densTolerance gloriaAugustaSchulzeNNDens gloriaAugustaSchulzeNNnoDens gloriaAugustaAorNNMa gloriaAugustaAorNNLi gloriaAugustaAorNNBoth X Y Z S 
close all

    jjj=1;
    ii=1;
    %load('R:\simulations\input\inputDataNN4.mat')
    load('/mnt/benvenutiPFMDaten/simulations/input/inputDataNN2.mat')
    angleExp = 38.8500;
    dataNN2 = rmfield(dataNN2, {'shearperc','ctrlStress'});
    c3 = datestr(clock)  
     angleExp = 38.8500;
    newY2 = myNewInput(NNSave2, errorEstSumMaxIndex2, dataNN2);        
    [nY2rows,nY2column] = size(newY2);
    [newY2rows newY2columns] = size(newY2);
    jjj=1;
    kkk=1;
    lll=1;
    i=1;

    c4 = datestr(clock)  
    newY2(newY2rows+1,:) = newY2(newY2rows-1,:)/angleExp; %ratioAORLi
    %newY2(newY2rows+2,:) = newY2(newY2rows,:)/angleExp;   %ratioAORMa
    newY2(newY2rows+2,:) = abs(1- newY2(newY2rows+1,:));  %deltaRatioAORLi
  %  newY2(newY2rows+4,:) = abs(1- newY2(newY2rows+2,:));  %deltaRatioAORMa
%     c1 = datestr(clock)   
%     for i = 1:newY2columns
%         if (newY2(newY2rows+2,i)<0.05)
%                 gloriaAugustaAorNNLi(kkk,1) = i;
%                 gloriaAugustaAorNNLi(kkk,2:newY2rows+3) = newY2(:,i);
%                 gloriaAugustaAorNNLi(kkk,newY2rows+4) = 1;
%                 kkk=kkk+1;        
%             
%         end
% 
%     end
%     c2 = datestr(clock)   
    
    
    tic
   temp_v = newY2( (newY2rows+2), : );
   temp_i = find (temp_v < 0.05);
   ni = size(temp_i,2) 
   gloriaAugustaAorNNLi = zeros( kkk+size(temp_i,2), newY2rows+4 );
   gloriaAugustaAorNNLi( kkk:(kkk+ni-1), 1) = temp_i'; 
   gloriaAugustaAorNNLi( kkk:(kkk+ni-1), 2:(newY2rows+3) ) = newY2( :, temp_i )';
   gloriaAugustaAorNNLi( kkk:(kkk+ni-1), newY2rows+4) = 1;
   kkk = kkk + ni
   toc