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
%title (['Parameters cloud - AOR,  coeff. P. = ', num2str(coeffPirker)], 'FontSize', 20);
title (['Parameters cloud - Shear Cell: \sigma_n = 1068 [Pa] \cap \sigma_n = 10070 [Pa]  \cap AOR_{exp} = 38.85\circ , coeff. P. = ', num2str(coeffPirker)], 'FontSize', 20);
%legend('COR','normal distribution','FontSize', '20');
set(gca, 'xlim', [0 1], 'ylim', [0 1],'FontSize',20);
%set(gca,'FontSize',20) ;
saveas(gcf,['SFRFcloud - AOR - CP', num2str(coeffPirker),'.tif'], 'tiff');

figure(4);
%plot(X,Y,'xb')

% c = S;
% x = X;
% y = Y;
el1 = find (S < 0.6);
X1 = X(el1);
Y1 = Y(el1);
el2 = find(S<0.7 & S>0.6);
X2 = X(el2);
Y2 = Y(el2);
el3 = find(S<0.8 & S>0.7);
X3 = X(el3);
Y3 = Y(el3);
el4 = find(S<0.9 & S>0.8);
X4 = X(el4);
Y4 = Y(el4);
if length(X)>100000
    plot(X1(1:10:end),Y1(1:10:end),'kx',X2(1:10:end),Y2(1:10:end),'k+',X3(1:10:end),Y3(1:10:end),'k*',X4(1:10:end),Y4(1:10:end),'kv');
    short=1
elseif length(X)>50000
    plot(X1(1:2:end),Y1(1:2:end),'kx',X2(1:2:end),Y2(1:2:end),'k+',X3(1:2:end),Y3(1:2:end),'k*',X4(1:2:end),Y4(1:2:end),'kv');
    short=2
else
    plot(X1,Y1,'kx',X2,Y2,'k+',X3,Y3,'k*',X4,Y4,'kv');
    short=0
end
xlim([0.0 1.0])
ylim([0.0 1.0])
legend('0.5<COR<0.6','0.6<COR<0.7', '0.7<COR<0.8', '0.8<COR<0.9','Location','SouthWest');%,'FontSize',20)
title (['Shear Cell: \sigma_n = 10070 [Pa], coeff. P. = ', num2str(coeffPirker)], 'FontSize', 20);
%title (['AOR_{exp} = 38.85\circ, coeff. P. = ', num2str(coeffPirker)], 'FontSize', 20);
set(gca, 'xlim', [0 1], 'ylim', [0 1],'FontSize',20);
set(gca,'FontSize',20) ;
xlabel('\mu_s', 'FontSize', 20);
ylabel('\mu_r', 'FontSize', 20);
% colorbar;

% h = colorbar;
% ylabel(h, 'COR', 'FontSize', 20);
%title (['Parameters cloud - normal stress = 1068 Pa; coeff'], 'FontSize', 20);
%title (['Parameters cloud - normal stress = ', num2str(dataNN2.ctrlStress), ' [Pa], coeff. P. = ', num2str(coeffPirker)], 'FontSize', 20);
%title (['Parameters cloud - AOR,  coeff. P. = ', num2str(coeffPirker)], 'FontSize', 20);
title (['Shear Cell:  \sigma_n = 10070 [Pa]  \cap AOR_{exp} = 38.85\circ , coeff. P. = ', num2str(coeffPirker)], 'FontSize', 20);
%legend('COR','normal distribution','FontSize', '20');
set(gca, 'xlim', [0 1], 'ylim', [0 1],'FontSize',20);


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

