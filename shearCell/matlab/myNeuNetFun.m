function [NNSave, errorNN, x, t, errorEstSum, errorEstIndex, errorEstSumMaxIndex, yy] =   myNeuNetFun(nSimCases2,data2,avgMuR1bis,avgMuR2bis,trainFcn2,hiddenLayerSizeVector2,densityBulkBoxMean2)

for iijj=1:nSimCases2
    inputNN(iijj,3)=data2(iijj).rest;
    inputNN(iijj,1)=data2(iijj).fric;
    inputNN(iijj,2)=data2(iijj).rf;
    inputNN(iijj,4)=data2(iijj).dt;
    inputNN(iijj,5)=data2(iijj).dCylDp;
    
    if (exist('densityBulkBoxMean2'))
        targetNN(iijj,3)=densityBulkBoxMean2(iijj);
    end
    
    targetNN(iijj,2)=avgMuR1bis(iijj);
    targetNN(iijj,1)=avgMuR2bis(iijj);
end

x = inputNN';
t = targetNN';

if length(x)>1000
    parallel = 'yes';
else
    parallel = 'no';
end



% Create a Fitting Network

% Setup Division of data2 for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;


hiddenLayerSizeVectorLength = length(hiddenLayerSizeVector2);
kkll = 1;
for kkll = 1:hiddenLayerSizeVectorLength

hiddenLayerSize = hiddenLayerSizeVector2(kkll);
net = fitnet(hiddenLayerSize,trainFcn2);


% Train the Network
[net,tr] = train(net,x,t,'useParallel',parallel);

NNSave{kkll}.net = net;
NNSave{kkll}.tr = tr;

NNSave{kkll}.IWM = net.IW{1};
NNSave{kkll}.LWM  = net.LW{2,1}';
NNSave{kkll}.biasInput  = net.b{1};
NNSave{kkll}.biasOutput  = net.b{2};
NNSave{kkll}.divideParam = net.divideParam;
% Radial Basis Function Network
% eg = 0.02; % sum-squared error goal
% sc = 1;    % spread constant
% net = newrb(x,t,eg,sc);

% Test the Network
y = net(x);
yy(kkll,:,:) = y;
e = gsubtract(t,y);
% performance = perform(net,t,y); %
% meanAbsoluteError = mae(t-y);

%perf = mse(net,t,y);n
%[r,m,b] = regression(t,y)



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
for llkk = 1:4
    jjkk = 4*kkll + llkk-4;
   [errorNN(jjkk).r2 errorNN(jjkk).rmse] = rsquare(t(:,[errorNN(jjkk).index]),y(:,[errorNN(jjkk).index]));
    errorNN(jjkk).mae = mae(t(:,[errorNN(jjkk).index]),y(:,[errorNN(jjkk).index]));
    errorNN(jjkk).mse = mse(t(:,[errorNN(jjkk).index]),y(:,[errorNN(jjkk).index]));
    errorNN(jjkk).neuronNumber = hiddenLayerSize;
    errorNN(jjkk).errorEst = errorNN(jjkk).r2/(errorNN(jjkk).mae*errorNN(jjkk).mse);
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
for kkkk=1:4:(hiddenLayerSizeVectorLength*4)
errorEstSum(kkjj) = sum([errorNN(kkkk:(kkkk+3)).errorEst]);
%errorEstSum(kkjj)=sum(errorEst(i:i+3));
kkjj=kkjj+1;
end
[errorEstSumMax, errorEstSumMaxIndex]=max(errorEstSum);
errorEstIndex = errorEstSumMaxIndex*4-3;
disp(['#Neuron = ',num2str(errorNN(errorEstIndex).neuronNumber), ' ; transferFcn = ', num2str(net.layers{:}.transferFcn), ' ; trainFcn2 = ', trainFcn2,...
    ' ; R2tot = ', num2str(errorNN(errorEstIndex).r2), ' ; meanSquareErrorTot = ', num2str(errorNN(errorEstIndex).mse),...
' ; meanAbsoluteErrorTot = ', num2str(errorNN(errorEstIndex).mae)]);


plotregression(t,yy(errorEstSumMaxIndex,:),'Regression')
return

