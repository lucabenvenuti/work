%dataNN2.ctrlStress = 1068; %1068;% [1068,2069,10070];
%coeffPirker = 1.0;
clear all;
close all;
clc;

%load('../results/sinterFineMatlabData/radarPlot1068sinterfine0_1range.mat');

i=1;
stringa{1} = 'radarPlot1068sinterfine0_1range';
stringa{2} = 'radarPlot1068sinterfine0_1rangePirker0dot8';
stringa{3} = 'radarPlot1068sinterfine0_1rangePirker1dot2';

stringa{4} = 'radarPlot10070sinterfine0_1range';
stringa{5} = 'radarPlot10070sinterfine0_1rangePirker0dot8';
stringa{6} = 'radarPlot10070sinterfine0_1rangePirker1dot2';

for i =2:6
clearvars -except stringa i coeffPirker2
close all;
coeffPirker2(i) = cloudPlot(['../results/sinterFineMatlabData/',stringa{i}, '.mat'])
end
% % % pippo =1
% % % 
% % % if (exist('coeffPirker')==0)
% % %     coeffPirker = 1.0
% % % end
% % % 
% % % %     X=gloriaAugustaSchulzeNN(3,:); %sf
% % % %     Y=gloriaAugustaSchulzeNN(4,:); %rf
% % % %     Z=gloriaAugustaSchulzeNN(9,:); %density
% % % %     S=gloriaAugustaSchulzeNN(2,:); %cor
% % % %     C=gloriaAugustaSchulzeNN(10,:);%avgMuR2
% % % 
% % % %close all;
% % % figure(1);
% % % %plot(X,Y,'xb')
% % % xlim([0 max(X)])
% % % ylim([0 max(Y)])
% % % % c = S;
% % % % x = X;
% % % % y = Y;
% % % scatter(X,Y,[],S, 'x');
% % % set(gca,'FontSize',20) ;
% % % xlabel('SF', 'FontSize', 20);
% % % ylabel('RF', 'FontSize', 20);
% % % colorbar;
% % % h = colorbar;
% % % ylabel(h, 'COR', 'FontSize', 20);
% % % %title (['Parameters cloud - normal stress = 1068 Pa; coeff'], 'FontSize', 20);
% % % title (['Parameters cloud - normal stress = ', num2str(dataNN2.ctrlStress), ' [Pa], coeff. P. = ', num2str(coeffPirker)], 'FontSize', 20);
% % % %legend('COR','normal distribution','FontSize', '20');
% % % set(gca,'FontSize',20) ;
% % % saveas(gcf,['SFRFcloud',num2str(dataNN2.ctrlStress), 'CP', num2str(coeffPirker),'.tif'], 'tiff');
% % % 
% % % 
% % % %close all;
% % % figure(2);
% % % %plot(S,X,'xb')
% % % xlim([0 max(S)])
% % % ylim([0 max(X)])
% % % scatter(S,X,[],Y, 'x');
% % % set(gca,'FontSize',20) ;
% % % xlabel('COR', 'FontSize', 20);
% % % ylabel('SF', 'FontSize', 20);
% % % colorbar;
% % % h = colorbar;
% % % ylabel(h, 'RF', 'FontSize', 20);
% % % title (['Parameters cloud - normal stress = ', num2str(dataNN2.ctrlStress), ' [Pa], coeff. P. = ', num2str(coeffPirker)], 'FontSize', 20);
% % % %legend('COR','normal distribution','FontSize', '20');
% % % set(gca,'FontSize',20) ;
% % % saveas(gcf,['CORSFcloud',num2str(dataNN2.ctrlStress), 'CP', num2str(coeffPirker),'.png'], 'png');
% % % %close all;
% % % 
% % % 
% % % 
% % % figure(3);
% % % %plot(S,Y,'xb')
% % % xlim([0 max(S)])
% % % ylim([0 max(Y)])
% % % scatter(S,Y,[],X, 'x');
% % % set(gca,'FontSize',20) ;
% % % xlabel('COR', 'FontSize', 20);
% % % ylabel('RF', 'FontSize', 20);
% % % colorbar;
% % % h = colorbar;
% % % ylabel(h, 'SF', 'FontSize', 20);
% % % title (['Parameters cloud - normal stress = ', num2str(dataNN2.ctrlStress), ' [Pa], coeff. P. = ', num2str(coeffPirker)], 'FontSize', 20);
% % % %legend('COR','normal distribution','FontSize', '20');
% % % set(gca,'FontSize',20) ;
% % % saveas(gcf,['CORRFcloud',num2str(dataNN2.ctrlStress), 'CP', num2str(coeffPirker),'.tif']);
% % % %close all;
% % % 
% % % 
% % % %col = S;
% % % % surface([x;x],[y;y],[z;z],[col;col],...
% % % %         'facecol','no',...
% % % %         'edgecol','interp',...
% % % %         'linew',2);
% % % %    