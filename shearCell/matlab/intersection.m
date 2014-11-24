gloriaAugustaAORNN = gloriaAugustaAorNNBoth';
inter1=gloriaAugustaAORNN([2,3,4,7],:);
inter2=gloriaAugustaSchulzeNN([2,3,4,9],:);
inter1=inter1';
inter2=inter2';
[Cia,ia,ib] = intersect(inter1(:,[1,2,3,4]),inter2(:,[1,2,3,4]),'rows')
[Cia,ia,ib] = intersect(inter1,inter2,'rows');

gloriaAugustaSchulzeNN = Cia';

    X=gloriaAugustaSchulzeNN(2,:); %sf
    Y=gloriaAugustaSchulzeNN(3,:); %rf
    Z=gloriaAugustaSchulzeNN(4,:); %density
    S=gloriaAugustaSchulzeNN(1,:); %cor
  %  C=gloriaAugustaSchulzeNN(10,:);%avgMuR2
    %C=gloriaAugustaSchulzeNN(8,:);%aorLi
    %Z=gloriaAugustaSchulzeNN(7,:); %density
    best = find(Cia(:,3)<0.6);
    for i =1:length(best)
winner(:,i)=gloriaAugustaSchulzeNNDens(:,best(i));
    end

    for i =1:length(best)
winner(:,i)=Cia(best(i),:);
end