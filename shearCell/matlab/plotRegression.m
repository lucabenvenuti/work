%load('radarPlot10070sinterfine0_1range.mat', 'NNSave2', 'avgMuR1', 'data', 'dataNN2', 'errorEstSumMaxIndex2', 'nSimCases')
z = avgMuR1';
iijj=1;
for iijj=1:nSimCases
    inputNN3(iijj,3)=data(iijj).rest;
    inputNN3(iijj,1)=data(iijj).fric;
    inputNN3(iijj,2)=data(iijj).rf;
    

        inputNN3(iijj,4)=data(iijj).dt;

    

        inputNN3(iijj,5)=data(iijj).dCylDp;


        inputNN3(iijj,6)=data(iijj).ctrlStress;


 
        inputNN3(iijj,7)=data(iijj).shearperc;

        inputNN3(iijj,8)=data(iijj).dens;

end   

inputNN4 = inputNN3';

net2=NNSave2{errorEstSumMaxIndex2(2),2}.net;

yy = net2(inputNN4);

figure(1)
plotregression(z,yy,'Regression');

%title('Regression: R=0.98044','Interpreter','none','FontSize',24);
%xlabel('Target','FontSize',24);
%ylabel('Output~=0.96*Target+0.046','FontSize',24);
%legend('Data','Fit','Y = T','FontSize', '20', 'Location', 'NorthWest' );
set(gca, 'FontSize',20);
%matlab2tikz( 'Regression.tikz' );

%errorNN2(3*4).r2(1)

% ans =
% 
%     0.6539
% 
% errorNN2(errorEstSumMaxIndex2(2)*4).r2(2)
% 
% ans =
% 
%     0.9735
% 
% errorNN2(errorEstSumMaxIndex2(3)*4).r2(3)
% 
% ans =
% 
%     0.9995

% plotRegression
% yyy = 0.97*z;
% hold on
% plot(z,yyy)
% yyy = 0.97*z+0.036;
% plot(z,yy,'o',z,yyy)
% plot(z,yy,'o',z,yyy)[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2, z2, yy3] =   myNeuNetFunBis(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1);
% xlim(0.8,1.5)[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFun(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxMin);

% figure(5)
% plot(z2,yy3(5,:),'o',z2,y5)
% figure(5)
% y5=0.94*z2+.073;
% figure(5)
% plot(z2,yy3(5,:),'ob',z2,y5,'b')
% figure(5)
% plot(z2,yy3(5,:),'ok',z2,y5,'b')
% xlim(0.8,1.5)
% xlim([0.8,1.5])
% xlim([0.8,1.8])
% figure(5)
% xlim([0.8,1.8])
% xlim([0.5,2])
% xlim([0.8,1.8])
% ylim([0.8,1.8])
% legend('training values','regression line')
% legend('training values','regression line','Location', 'NorthWest')
% xlabel('\mu_{psh,DEM} [-]');
% xlabel('\mu_{psh,ANN} [-]');
% xlabel('\mu_{psh,DEM} [-]');
% ylabel('\mu_{psh,ANN} [-]');
% set(gca,'fontname','times new roman','FontSize',24)  % Set it to times
% xlabel('\mu_{psh,DEM} [-]','fontname','times new roman','FontSize',24);
% ylabel('\mu_{psh,ANN} [-]','fontname','times new roman','FontSize',24);
 xlabel('\mu_{psh,DEM} [-]','fontname','times new roman','FontSize',36);
 ylabel('\mu_{psh,ANN} [-]','fontname','times new roman','FontSize',36);