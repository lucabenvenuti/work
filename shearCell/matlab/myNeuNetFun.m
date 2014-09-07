function [NNSave, errorNN, x, zz, errorEstSum, errorEstIndex, errorEstSumMaxIndex, yyy, corrMatPca, newInput] =   myNeuNetFun(nSimCases2,data2,trainFcn2,hiddenLayerSizeVector2,  dataNN, target1, target2, target3)

for iijj=1:nSimCases2
    inputNN(iijj,3)=data2(iijj).rest;
    inputNN(iijj,1)=data2(iijj).fric;
    inputNN(iijj,2)=data2(iijj).rf;
    inputNN(iijj,4)=data2(iijj).dt;
    inputNN(iijj,5)=data2(iijj).dCylDp;
    
    if isfield (data2(iijj), 'ctrlStress')
        inputNN(iijj,6)=data2(iijj).ctrlStress;
    end

    if isfield (data2(iijj), 'shearperc')
        inputNN(iijj,7)=data2(iijj).shearperc;
    end
    
    if (exist('target1'))
        targetNN(iijj,1) = target1(iijj);
    %else
     %   warning('no target inserted'); 
      %  break
    end
    
    if (exist('target2'))
       targetNN(iijj,2) = target2(iijj);
    end
    
    
    if (exist('target3'))
        aa=7;
        %length(inputNN(iijj,:))
        inputNN(iijj,aa+1)=data2(iijj).dens;
        targetNN(iijj,3) = target3(iijj);
    end
    
end



[rowsTargetNN columnTargetNN] = size(targetNN);
[rowsInputNN columnInputNN] = size(inputNN);

ITNN(:,1:columnInputNN) = inputNN(:,1:columnInputNN);
ITNN(:,(columnInputNN+1):(columnInputNN+columnTargetNN)) = targetNN(:,1:columnTargetNN);
%[rowsITNN columnITNN] = size(ITNN);

corrMatPca.corrMat = corrcoef(ITNN);
[corrMatPca.coeff,corrMatPca.score,corrMatPca.latent,corrMatPca.tsquare] = princomp(ITNN); %Principal Components Analysis
%corrMat(1,1) = corr2(ITNN(:,1),ITNN(:,1));

% jjmm = 1;
% kkmm = 1;
% corrMat = zeros(columnITNN,columnITNN);
% for jjmm=1:columnITNN
%     for kkmm=1:columnITNN
%         corrMat(jjmm,kkmm) = corrcoef(ITNN(:,jjmm),ITNN(:,kkmm));
%     end
% end

% Setup Division of data2 for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
%net.trainParam.epochs= 10000;

hiddenLayerSizeVectorLength = length(hiddenLayerSizeVector2);

x = inputNN';
zz = targetNN';
% size(x)
% size(zz)

if length(x)>1000
    parallel = 'yes';
else
    parallel = 'no';
end

llmm=1; %targetSel, targets MUST be trained indipendently !
for llmm=1:columnTargetNN

    
    z = targetNN(:,llmm)';

    % Create a Fitting Network


    kkll = 1;
    for kkll = 1:hiddenLayerSizeVectorLength

        hiddenLayerSize = hiddenLayerSizeVector2(kkll);
        net = fitnet(hiddenLayerSize,trainFcn2);


        % Train the Network
        [net,tr] = train(net,x,z,'useParallel',parallel);

        NNSave{kkll,llmm}.net = net;
        NNSave{kkll,llmm}.tr = tr;

        NNSave{kkll,llmm}.IWM = net.IW{1};
        NNSave{kkll,llmm}.LWM  = net.LW{2,1}';
        NNSave{kkll,llmm}.biasInput  = net.b{1};
        NNSave{kkll,llmm}.biasOutput  = net.b{2};
        NNSave{kkll,llmm}.divideParam = net.divideParam;
        % Radial Basis Function Network
        % eg = 0.02; % sum-squared error goal
        % sc = 1;    % spread constant
        % net = newrb(x,t,eg,sc);

        % Test the Network
        y = net(x);
        yy(kkll,:) = y;
        yyy(kkll,llmm,:) = y;
        e = gsubtract(z,y);
        % performance = perform(net,t,y); %
        % meanAbsoluteError = mae(t-y);

        %perf = mse(net,t,y);n
        [NNSave{kkll,llmm}.r, NNSave{kkll,llmm}.m, NNSave{kkll,llmm}.b] = regression(z,y);



        errorNN(4*kkll-3).index = 1:length(x); %totale
        errorNN(4*kkll-2).index = tr.trainInd; %Train
        errorNN(4*kkll-1).index = tr.valInd; %val
        errorNN(4*kkll).index = tr.testInd; %test
        errorNN(4*kkll-3).name = 'tot';
        errorNN(4*kkll-2).name = 'train';
        errorNN(4*kkll-1).name = 'val';
        errorNN(4*kkll).name = 'test';

        jjkk = 0;
        llkk = 1;
        %llnn=1;
        for llkk = 1:4
            jjkk = 4*kkll + llkk-4;
           [errorNN(jjkk).r2(llmm) errorNN(jjkk).rmse(llmm)] = rsquare(z(:,[errorNN(jjkk).index]),y(:,[errorNN(jjkk).index]));
            errorNN(jjkk).mae(llmm) = mae(z(:,[errorNN(jjkk).index]),y(:,[errorNN(jjkk).index]));
            errorNN(jjkk).mse(llmm) = mse(z(:,[errorNN(jjkk).index]),y(:,[errorNN(jjkk).index]));
            errorNN(jjkk).neuronNumber(llmm) = hiddenLayerSize;
            errorNN(jjkk).errorEst(llmm) = errorNN(jjkk).r2(llmm)/(errorNN(jjkk).mae(llmm)*errorNN(jjkk).mse(llmm));
            errorNN(jjkk).errorEstIn = errorNN(jjkk).errorEst(llmm);
        %     for llnn=1:columnTargetNN
        %            [errorNN(jjkk).r2(llmm) errorNN(jjkk).rmse(llmm)] = rsquare(z(llmm,[errorNN(jjkk).index]),y(llmm,[errorNN(jjkk).index]));
        %             errorNN(jjkk).mae(llmm) = mae(z(llnn,[errorNN(jjkk).index]),y(llnn,[errorNN(jjkk).index]));
        %             errorNN(jjkk).mse(llmm) = mse(z(llnn,[errorNN(jjkk).index]),y(llnn,[errorNN(jjkk).index]));
        %     end

        end

        % [tot.r2 tot.rmse] = rsquare(t,y)
        % maeTot = mae(t,y)
        % mseTot = mse(t,y);
        % [r2Train rmseTrain] = rsquare(t(:,[tr.trainInd]),y(:,[tr.trainInd]))
        % maeTrain = mae(t(:,[tr.trainInd]),y(:,[tr.trainInd]))
        % mseTrain = mse(t(:,[tr.trainInd]),y(:,[tr.trainInd]))
        % [r2Val rmseVal] = rsquare(t(:,[tr.valInd]),y(:,[tr.valInd]))
        % [r2Test rmseTest] = rsquare(t(:,[tr.testInd]),y(:,[tr.testInd]))

        %
        %  y(:,[tr.trainInd])
        %  y(:,[tr.valInd])
        %  y(:,[tr.testInd])

        %help nntrain


end
kkkk=1;
kkjj=1;
% for kkkk=1:4:(hiddenLayerSizeVectorLength*4)
%     errorEstSumIn(kkjj) = sum([errorNN(kkkk:(kkkk+3)).errorEstIn]);
%     %errorEstSum(kkjj)=sum(errorEst(i:i+3));
%     kkjj=kkjj+1;
% end

for kkkk=4:4:(hiddenLayerSizeVectorLength*4)
    errorEstSumIn(kkjj) = errorNN(kkkk).r2(llmm);
    %errorEstSum(kkjj)=sum(errorEst(i:i+3));
    kkjj=kkjj+1;
end

errorEstSum(:,llmm)= errorEstSumIn(:);

%getting the winner neuron number
[errorEstSumMax(llmm), errorEstSumMaxIndex(llmm)]=max(errorEstSum(:,llmm));
errorEstIndex(llmm) = errorEstSumMaxIndex(llmm)*4-3;
disp(['#Neuron = ',num2str(errorNN(errorEstIndex(llmm)).neuronNumber(llmm)), ' ; transferFcn = ', num2str(net.layers{:}.transferFcn), ' ; trainFcn2 = ', trainFcn2,...
    ' ; R2tot = ', num2str(errorNN(errorEstIndex(llmm)).r2(llmm)), ' ; meanSquareErrorTot = ', num2str(errorNN(errorEstIndex(llmm)).mse(llmm)),...
     ' ; R2test = ', num2str(errorNN(errorEstIndex(llmm)+3).r2(llmm)), ...
' ; meanAbsoluteErrorTot = ', num2str(errorNN(errorEstIndex(llmm)).mae(llmm)),...
' ; R2Regression = ', num2str(NNSave{errorEstSumMaxIndex(llmm),llmm}.r),  ' ; mRegression = ', num2str(NNSave{errorEstSumMaxIndex(llmm),llmm}.m), ...
' ; bRegression = ', num2str(NNSave{errorEstSumMaxIndex(llmm),llmm}.b)]);

%NNSave{errorEstSumMaxIndex(llmm),llmm}.r, NNSave{errorEstSumMaxIndex(llmm),llmm}.m, NNSave{errorEstSumMaxIndex(llmm),llmm}.b
%errorEstSumMaxIndex2 =

     %8     3
%NNSave2{3,l}.r, NNSave2{3,2}.m, NNSave2{3,2}.b

figure(llmm)
plotregression(z,yy(errorEstSumMaxIndex(llmm),:),'Regression');

end


%% NN new input

    rest = dataNN.rest;
    sf = dataNN.sf;
    rf = dataNN.rf;
    dt = dataNN.dt;
    dCylDp = dataNN.dCylDp;
    ctrlStress = dataNN.ctrlStress;
    shearperc = dataNN.shearperc;
    
    lengthRest = length(rest);
    lengthSf = length(sf);
    lengthRf = length(rf);
    lengthDt = length(dt);
    lengthDCylDp = length(dCylDp);
    lengthCtrlStress = length(ctrlStress);
    lengthShearperc = length(shearperc);

    
    if isfield (dataNN, 'dens')
        dens = dataNN.dens;
        lengthDens = length(dens);
        totalLength = lengthRest*lengthSf*lengthRf*lengthDt*lengthDCylDp*lengthCtrlStress*lengthShearperc*lengthDens;
        newInput=ones(totalLength,8);
    else
         totalLength = lengthRest*lengthSf*lengthRf*lengthDt*lengthDCylDp*lengthCtrlStress*lengthShearperc;
         newInput=ones(totalLength,7);
        
    end



length1 = totalLength/lengthRest;
count1=0;
count12=1;
count13=1;
for i=1:length1
    newInput(1+count1:count1+lengthRest,1)=rest;
    
    
    newInput(1+count1:count1+lengthRest,2)=sf(count12);
    count12=count12+1;
    if count12==(lengthSf+1)
        count12=1;
    end
    

    
    count1 = count1 + lengthRest;
end
count1=0;
count12=1;
count13=0;
count14=1;

for i=1:(length1/lengthSf)
    newInput(1+count13:count13+lengthRest*lengthSf,3)=rf(count14);
    count14=count14+1;
    if count14==(lengthRf+1)
        count14=1;
    end
    
    count13 = count13 + lengthRest*lengthSf;
    

end

count15=0;
count16=1;

for i=1:(length1/lengthSf/lengthRf)
    newInput(1+count15:count15+lengthRest*lengthSf*lengthRf,4)=dt(count16);
    count16=count16+1;
    if count16==(lengthDt+1)
        count16=1;
    end
    
    count15 = count15 + lengthRest*lengthSf*lengthRf;
    

end

count17=0;
count18=1;

for i=1:(length1/lengthSf/lengthRf/lengthDt)
    newInput(1+count17:count17+lengthRest*lengthSf*lengthRf*lengthDt,5)=dCylDp(count18);
    count18=count18+1;
    if count18==(lengthDCylDp+1)
        count18=1;
    end
    
    count17 = count17 + lengthRest*lengthSf*lengthRf*lengthDt;
    

end


count19=0;
count20=1;

for i=1:(length1/lengthSf/lengthRf/lengthDt/lengthDCylDp)
    newInput(1+count19:count19+lengthRest*lengthSf*lengthRf*lengthDt*lengthDCylDp,6)=ctrlStress(count20);
    count20=count20+1;
    if count20==(lengthCtrlStress+1)
        count20=1;
    end
    
    count19 = count19 + lengthRest*lengthSf*lengthRf*lengthDt*lengthDCylDp;
    

end

%shearperc
count21=0;
count22=1;

for i=1:(length1/lengthSf/lengthRf/lengthDt/lengthDCylDp/lengthCtrlStress)
    newInput(1+count21:count21+lengthRest*lengthSf*lengthRf*lengthDt*lengthDCylDp*lengthCtrlStress,7)=shearperc(count22);
    count22=count22+1;
    if count22==(lengthShearperc+1)
        count22=1;
    end
    
    count21 = count21 + lengthRest*lengthSf*lengthRf*lengthDt*lengthDCylDp*lengthCtrlStress;
    

end

if isfield (dataNN, 'dens')
    count23=0;
    count24=1;

    for i=1:(length1/lengthSf/lengthRf/lengthDt/lengthDCylDp/lengthCtrlStress/lengthShearperc)
        newInput(1+count23:count23+lengthRest*lengthSf*lengthRf*lengthDt*lengthDCylDp*lengthCtrlStress*lengthShearperc,8)=dens(count24);
        count24=count24+1;
        if count24==(lengthDens+1)
            count24=1;
        end

        count23 = count23 + lengthRest*lengthSf*lengthRf*lengthDt*lengthDCylDp*lengthCtrlStress*lengthShearperc;


    end
end

newInput=newInput';

[nIrows nIcolumn] = size(newInput);

net1=NNSave{errorEstSumMaxIndex(1),1}.net;
net2=NNSave{errorEstSumMaxIndex(2),2}.net;
% 
newInput(nIrows+1,:)=net1(newInput);
newInput(nIrows+2,:)=net2(newInput(1:nIrows,:));
% 
if isfield (dataNN, 'dens')
    net3=NNSave{errorEstSumMaxIndex(3),3}.net;
    newInput(nIrows+3,:)=net3(newInput(1:nIrows,:));
end




return

%% 
% length2 = totalLength/length(sf);
% count2=0;
% for i=1:length2
%     newInput(1+count2:count2+length(sf),2)=sf;
%     count2 = count2 + length(sf);
% end
% 
% length3 = totalLength/length(rf);
% count3=0;
% for i=1:length3
%     newInput(1+count3:count3+length(rf),3)=rf;
%     count3 = count3 + length(rf);
% end
% 
% length4 = totalLength/length(dt);
% count4=0;
% for i=1:length4
%     newInput(1+count4:count4+length(dt),4)=dt;
%     count4 = count4 + length(dt);
% end
% 
% length5 = totalLength/length(dCylDp);
% count5=0;
% for i=1:length5
%     newInput(1+count5:count5+length(dCylDp),5)=dCylDp;
%     count5 = count5 + length(dCylDp);
% end
% 
% length6 = totalLength/length(ctrlStress);
% count6=0;
% for i=1:length6
%     newInput(1+count6:count6+length(ctrlStress),6)=ctrlStress;
%     count6 = count6 + length(ctrlStress);
% end
% 
% length7 = totalLength/length(shearperc);
% count7=0;
% for i=1:length7
%     newInput(1+count7:count7+length(shearperc),7)=shearperc;
%     count7 = count7 + length(shearperc);
% end