function [NNSave, errorNN, x, zz, errorEstSum, errorEstIndex, errorEstSumMaxIndex, yyy, corrMatPca, numbersNeuronsWinner, NNSaveNeuronsWinner] =   myNeuNetFunPolidispersity(nSimCases2, data2, trainFcn2, hiddenLayerSizeVector2, target1, target2, target3)
        %[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2]=myNeuNetFun(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxMean);
for iijj=1:nSimCases2
    inputNN(iijj,3)=data2(iijj).rest;
    inputNN(iijj,1)=data2(iijj).fric;
    inputNN(iijj,2)=data2(iijj).rf;
    
    if isfield (data2(iijj), 'radmu')
        inputNN(iijj,4)=data2(iijj).radmu;
    end
    
    if isfield (data2(iijj), 'dCylDp')
        inputNN(iijj,5)=data2(iijj).dCylDp;
    end
    
    if (isfield (data2(iijj), 'ctrlStress') & isfield (data2(iijj), 'radsigma'))
        inputNN(iijj,6)=abs(data2(iijj).ctrlStress);
         inputNN(iijj,7)=data2(iijj).radsigma;
    end %elseif

%     if isfield (data2(iijj), 'shearperc')
%         inputNN(iijj,7)=data2(iijj).shearperc;
%     end
    
    if (exist('target1'))
        targetNN(iijj,1) = target1(iijj);
    %else
     %   warning('no target inserted'); 
      %  break
    end
    
    if (exist('target2'))
       targetNN(iijj,2) = target2(iijj);
    end
    
    
    if (exist('target3') | isfield (data2(iijj), 'deltaRatioAORLi'))

        if (exist('target3'))
            aa=7;
            %length(inputNN(iijj,:))
            inputNN(iijj,aa+1)=data2(iijj).dens;
            targetNN(iijj,3) = target3(iijj);
        else
            aa=5;
            inputNN(iijj,aa+1)=data2(iijj).dens;
            if isfield (data2(iijj), 'radsigma')
                inputNN(iijj,aa+2)=data2(iijj).radsigma;
            end
            
        end
    end
    
end



[rowsTargetNN columnTargetNN] = size(targetNN);
[rowsInputNN columnInputNN] = size(inputNN);

ITNN(:,1:columnInputNN) = inputNN(:,1:columnInputNN);
ITNN(:,(columnInputNN+1):(columnInputNN+columnTargetNN)) = targetNN(:,1:columnTargetNN);
%[rowsITNN columnITNN] = size(ITNN);

corrMatPca.corrMat = corrcoef(ITNN);
[corrMatPca.coeff,corrMatPca.score,corrMatPca.latent,corrMatPca.tsquare] = princomp(ITNN); %Principal Components Analysis
%[r,p] = corr(x,y,'type', 'Spearman');
%[r,p] = corr(x,y,'type', 'Pearson');

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

llmm = 1; %targetSel, targets MUST be trained indipendently !
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

        % Test the Network
        y = net(x);
        yy(kkll,:) = y;
        yyy(kkll,llmm,:) = y;
        e = gsubtract(z,y);
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
        for llkk = 1:4
            jjkk = 4*kkll + llkk-4;
           [errorNN(jjkk).r2(llmm) errorNN(jjkk).rmse(llmm)] = rsquare(z(:,[errorNN(jjkk).index]),y(:,[errorNN(jjkk).index]));
            errorNN(jjkk).mae(llmm) = mae(z(:,[errorNN(jjkk).index]),y(:,[errorNN(jjkk).index]));
            errorNN(jjkk).mse(llmm) = mse(z(:,[errorNN(jjkk).index]),y(:,[errorNN(jjkk).index]));
            errorNN(jjkk).neuronNumber(llmm) = hiddenLayerSize;
            errorNN(jjkk).errorEst(llmm) = errorNN(jjkk).r2(llmm)/(errorNN(jjkk).mae(llmm)*errorNN(jjkk).mse(llmm));
            errorNN(jjkk).errorEstIn = errorNN(jjkk).errorEst(llmm);
        end

end
kkkk=1;
kkjj=1;

for kkkk=4:4:(hiddenLayerSizeVectorLength*4)
    errorEstSumIn(kkjj) = errorNN(kkkk).r2(llmm);
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
numbersNeuronsWinner(llmm) = errorNN(errorEstIndex(llmm)).neuronNumber(llmm);
NNSaveNeuronsWinner(llmm) = NNSave{errorEstSumMaxIndex(llmm), llmm};
figure(llmm);
plotregression(z,yy(errorEstSumMaxIndex(llmm),:),'Regression');

end