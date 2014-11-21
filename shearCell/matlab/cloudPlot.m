function [coeffPirker] = cloudPlot(loadingString)
%UNTITLED Summary of this function goes here

load(loadingString);

%   Detailed explanation goes here
if (exist('coeffPirker')==0)
    coeffPirker = 1.0;
end

%     X=gloriaAugustaSchulzeNN(3,:); %sf
%     Y=gloriaAugustaSchulzeNN(4,:); %rf
%     Z=gloriaAugustaSchulzeNN(9,:); %density
%     S=gloriaAugustaSchulzeNN(2,:); %cor
%     C=gloriaAugustaSchulzeNN(10,:);%avgMuR2

%close all;
figure(1);
%plot(X,Y,'xb')
xlim([0.0 1.0])
ylim([0.0 1.0])
% c = S;
% x = X;
% y = Y;
scatter(X,Y,[],S, 'x');
set(gca,'FontSize',20) ;
xlabel('SF', 'FontSize', 20);
ylabel('RF', 'FontSize', 20);
colorbar;
h = colorbar;
ylabel(h, 'COR', 'FontSize', 20);
%title (['Parameters cloud - normal stress = 1068 Pa; coeff'], 'FontSize', 20);
%title (['Parameters cloud - normal stress = ', num2str(dataNN2.ctrlStress), ' [Pa], coeff. P. = ', num2str(coeffPirker)], 'FontSize', 20);
title (['Parameters cloud - AOR,  coeff. P. = ', num2str(coeffPirker)], 'FontSize', 20);
%legend('COR','normal distribution','FontSize', '20');
set(gca, 'xlim', [0 1], 'ylim', [0 1],'FontSize',20);
%set(gca,'FontSize',20) ;
saveas(gcf,['SFRFcloud - AOR - CP', num2str(coeffPirker),'.tif'], 'tiff');


%close all;
figure(2);
%plot(S,X,'xb')
xlim([0.0 1.0])
ylim([0.0 1.0])
scatter(S,X,[],Y, 'x');
set(gca,'FontSize',20) ;
xlabel('COR', 'FontSize', 20);
ylabel('SF', 'FontSize', 20);
colorbar;
h = colorbar;
ylabel(h, 'RF', 'FontSize', 20);
title (['Parameters cloud - normal stress = ', num2str(dataNN2.ctrlStress), ' [Pa], coeff. P. = ', num2str(coeffPirker)], 'FontSize', 20);
%legend('COR','normal distribution','FontSize', '20');
set(gca, 'xlim', [0 1], 'ylim', [0 1],'FontSize',20);
%set(gca,'FontSize',20) ;
saveas(gcf,['CORSFcloud',num2str(dataNN2.ctrlStress), 'CP', num2str(coeffPirker),'.png'], 'png');
%close all;



figure(3);
%plot(S,Y,'xb')
xlim([0.0 1.0])
ylim([0.0 1.0])
scatter(S,Y,[],X, 'x');
set(gca,'FontSize',20) ;
xlabel('COR', 'FontSize', 20);
ylabel('RF', 'FontSize', 20);
colorbar;
h = colorbar;
ylabel(h, 'SF', 'FontSize', 20);
title (['Parameters cloud - normal stress = ', num2str(dataNN2.ctrlStress), ' [Pa], coeff. P. = ', num2str(coeffPirker)], 'FontSize', 20);
%legend('COR','normal distribution','FontSize', '20');
set(gca, 'xlim', [0 1], 'ylim', [0 1],'FontSize',20);
%set(gca,'FontSize',20) ;
saveas(gcf,['CORRFcloud',num2str(dataNN2.ctrlStress), 'CP', num2str(coeffPirker),'.tif']);
%close all;


end

