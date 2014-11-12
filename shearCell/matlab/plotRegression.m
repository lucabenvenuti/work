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