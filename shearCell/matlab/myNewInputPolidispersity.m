function newInput = myNewInputPolidispersity(NNSave, errorEstSumMaxIndex, dataNN)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%[, errorNN, x, zz, errorEstSum, errorEstIndex, errorEstSumMaxIndex, yyy, corrMatPca, newInput] =   myNeuNetFun(nSimCases2,data2,trainFcn2,hiddenLayerSizeVector2,  dataNN, target1, target2, target3)

    rest = dataNN.rest;
    sf = dataNN.sf;
    rf = dataNN.rf;
    radmu = dataNN.radmu;
    dCylDp = dataNN.dCylDp;
    
    
    
    lengthRest = length(rest);
    lengthSf = length(sf);
    lengthRf = length(rf);
    lengthRadmu = length(radmu);
    lengthDCylDp = length(dCylDp);
    
    if isfield (dataNN, 'ctrlStress')
        ctrlStress = dataNN.ctrlStress;
        lengthCtrlStress = length(ctrlStress);
    end

    if isfield (dataNN, 'radsigma')
        radsigma = dataNN.radsigma;
        lengthRadsigma = length(radsigma);
    end
    
    if isfield (dataNN, 'radsigma')
        dens = dataNN.dens;
        lengthDens = length(dens);
    end

    
    if (isfield (dataNN, 'dens') & isfield (dataNN, 'radsigma') & isfield (dataNN, 'ctrlStress')) 
        dens = dataNN.dens;
        lengthDens = length(dens);
        totalLength = lengthRest*lengthSf*lengthRf*lengthRadmu*lengthDCylDp*lengthCtrlStress*lengthRadsigma*lengthDens;
        newInput=ones(totalLength,8);
    elseif (isfield (dataNN, 'radsigma') & isfield (dataNN, 'ctrlStress') & ~(isfield (dataNN, 'dens')))
         totalLength = lengthRest*lengthSf*lengthRf*lengthRadmu*lengthDCylDp*lengthCtrlStress*lengthRadsigma;
         newInput=ones(totalLength,7);
    elseif (isfield (dataNN, 'radsigma') & isfield (dataNN, 'dens') & ~(isfield (dataNN, 'ctrlStress')))  %AOR
         totalLength = lengthRest*lengthSf*lengthRf*lengthRadmu*lengthDCylDp*lengthDens*lengthRadsigma;
         newInput=ones(totalLength,7);
    elseif (isfield (dataNN, 'ctrlStress') & ~(isfield (dataNN, 'radsigma')) & ~(isfield (dataNN, 'dens')))
         totalLength = lengthRest*lengthSf*lengthRf*lengthRadmu*lengthDCylDp*lengthCtrlStress;
         newInput=ones(totalLength,6);
    elseif (isfield (dataNN, 'dens') & ~(isfield (dataNN, 'ctrlStress')) & ~(isfield (dataNN, 'radsigma')))
        dens = dataNN.dens;
        lengthDens = length(dens);
        totalLength = lengthRest*lengthSf*lengthRf*lengthRadmu*lengthDCylDp*lengthDens;
        newInput=ones(totalLength,6);
    else
        totalLength = lengthRest*lengthSf*lengthRf*lengthRadmu*lengthDCylDp;
        newInput=ones(totalLength,5);
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
    newInput(1+count15:count15+lengthRest*lengthSf*lengthRf,4)=radmu(count16);
    count16=count16+1;
    if count16==(lengthRadmu+1)
        count16=1;
    end
    
    count15 = count15 + lengthRest*lengthSf*lengthRf;
    

end

count17=0;
count18=1;

for i=1:(length1/lengthSf/lengthRf/lengthRadmu)
    newInput(1+count17:count17+lengthRest*lengthSf*lengthRf*lengthRadmu,5)=dCylDp(count18);
    count18=count18+1;
    if count18==(lengthDCylDp+1)
        count18=1;
    end
    
    count17 = count17 + lengthRest*lengthSf*lengthRf*lengthRadmu;
    

end

if isfield (dataNN, 'ctrlStress')

    count19=0;
    count20=1;

    for i=1:(length1/lengthSf/lengthRf/lengthRadmu/lengthDCylDp)
        newInput(1+count19:count19+lengthRest*lengthSf*lengthRf*lengthRadmu*lengthDCylDp,6)=ctrlStress(count20);
        count20=count20+1;
        if count20==(lengthCtrlStress+1)
            count20=1;
        end

        count19 = count19 + lengthRest*lengthSf*lengthRf*lengthRadmu*lengthDCylDp;

    end

    if isfield (dataNN, 'radsigma')    
        %shearperc
        count21=0;
        count22=1;

        for i=1:(length1/lengthSf/lengthRf/lengthRadmu/lengthDCylDp/lengthCtrlStress)
            newInput(1+count21:count21+lengthRest*lengthSf*lengthRf*lengthRadmu*lengthDCylDp*lengthCtrlStress,7)=radsigma(count22);
            count22=count22+1;
            if count22==(lengthRadsigma+1)
                count22=1;
            end

            count21 = count21 + lengthRest*lengthSf*lengthRf*lengthRadmu*lengthDCylDp*lengthCtrlStress;


        end

        if isfield (dataNN, 'dens')
            count23=0;
            count24=1;

            for i=1:(length1/lengthSf/lengthRf/lengthRadmu/lengthDCylDp/lengthCtrlStress/lengthRadsigma)
                newInput(1+count23:count23+lengthRest*lengthSf*lengthRf*lengthRadmu*lengthDCylDp*lengthCtrlStress*lengthRadsigma,8)=dens(count24);
                count24=count24+1;
                if count24==(lengthDens+1)
                    count24=1;
                end

                count23 = count23 + lengthRest*lengthSf*lengthRf*lengthRadmu*lengthDCylDp*lengthCtrlStress*lengthRadsigma;


            end
        end
        
      end
    
elseif isfield (dataNN, 'dens')
     
   
        count19=0;
        count20=1;

        for i=1:(length1/lengthSf/lengthRf/lengthRadmu/lengthDCylDp)
            newInput(1+count19:count19+lengthRest*lengthSf*lengthRf*lengthRadmu*lengthDCylDp,6)=dens(count20);
            count20=count20+1;
            if count20==(lengthDens+1)
                count20=1;
            end

            count19 = count19 + lengthRest*lengthSf*lengthRf*lengthRadmu*lengthDCylDp;

        end
%     if (~(isfield (dataNN, 'ctrlStress')) & ~(isfield (dataNN, 'radsigma')))
%     else
      if (isfield (dataNN, 'radsigma') & ~(isfield (dataNN, 'ctrlStress')))  %AOR
                count21=0;
        count22=1;

        for i=1:(length1/lengthSf/lengthRf/lengthRadmu/lengthDCylDp/lengthDens)
            newInput(1+count21:count21+lengthRest*lengthSf*lengthRf*lengthRadmu*lengthDCylDp*lengthDens,7)=radsigma(count22);
            count22=count22+1;
            if count22==(lengthRadsigma+1)
                count22=1;
            end

            count21 = count21 + lengthRest*lengthSf*lengthRf*lengthRadmu*lengthDCylDp*lengthDens;


        end
    end
%

end

newInput=newInput';

[nIrows nIcolumn] = size(newInput);

net1=NNSave{errorEstSumMaxIndex(1),1}.net;
net2=NNSave{errorEstSumMaxIndex(2),2}.net;
% 
newInput(nIrows+1,:)=net1(newInput);
newInput(nIrows+2,:)=net2(newInput(1:nIrows,:));
% 
if (isfield (dataNN, 'dens') & isfield (dataNN, 'radsigma') & isfield (dataNN, 'ctrlStress')) 
    net3=NNSave{errorEstSumMaxIndex(3),3}.net;
    newInput(nIrows+3,:)=net3(newInput(1:nIrows,:));
end

end

