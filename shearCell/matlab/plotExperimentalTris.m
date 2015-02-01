exp_file = ['20131129_0841_sinterfine0-315_test04' , '.FTD']; % name of the FTD FILE, with the exp values vs time
summaryFile = ['20131129_0841_sinterfine0-315_test04' , '.out']; % name of the out file, with the summary values
sumForceFile = ['20131129_0841_sinterfine0-315_test04' , '.inp']; % name of the inp file, with the forces summary values

 comma2point_overwrite(exp_file);    %substitution of commas with dots
 expFtd = importFTD(exp_file);
                    
time = expFtd.time;
tau = expFtd.tau;
dH = expFtd.dH;
rhoB = expFtd.rhoB;
                    
                    
comma2point_overwrite(summaryFile);
expOut = importOut(summaryFile);
                    
comma2point_overwrite(sumForceFile);
expInp = importInp(sumForceFile);
                    
coeffShear40 = expInp.tauAb40/expOut.sigmaAb40;
coeffShear60 = expInp.tauAb60/expOut.sigmaAb60;
coeffShear80 = expInp.tauAb80/expOut.sigmaAb80;
coeffShear100 = expOut.coeffShear100;



xlabel('time [s]')

xP = [427.452956989247;461.727150537634;491.633064516129;510.114247311828;583.030913978495;620.665322580645];
yP = [-7.64331210191085;7284.07643312102;7314.64968152866;7880.25477707006;4700.63694267516;6198.72611464968];
%aa=max(find (time<620.665322580645))
p = [207;548;840;1023;1460;1831];

x1=time(p(1):p(2))-time(p(1));
y1=tau(p(1):p(2));
x2=time(p(3):p(4))-time(p(3))+ max(x1);
y2=tau(p(3):p(4));
x3=time(p(5):p(6))-time(p(5))+ max(x2);
y3=tau(p(5):p(6));

x=[x1;x2;x3]/max(x2);%unnamed;
y=[y1;y2;y3]/5670.7;%expOut.sigmaAb100;%unnamed1;
%plot(x,y)


 %[xM,yM] = ginput(4);
 xM=[0.815927419354839;0.996169354838710;1.21633064516129;1.49697580645161];
 yM=[0.768917197452229;0.776050955414013;0.552866242038217;0.565095541401274];
 
 m = [430;523;639;785];
 
 figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'FontSize',24,'FontName','times new roman');
%% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0.5 1.08510211436917]);
box(axes1,'on');
hold(axes1,'all');

 % Create plot
plot(x,y,'Parent',axes1,'LineWidth',3,...
    'DisplayName','experimental coefficient of internal friction \mu_{ie}',...
    'Color',[0 0 0]);

yy2 = mean(y(m(1)):y(m(2)));

X2=[x(m(1));x(m(2))];
Y2=[yy2;yy2];

yy3=mean(y(m(3)):y(m(4)));

X3=[x(m(3));x(m(4))];
Y3=[yy3;yy3];

% Create plot
plot(X2,Y2,'Parent',axes1,'MarkerSize',10,'Marker','diamond','LineWidth',10,...
    'LineStyle','--',...
    'Color',[1 0 0],...
    'DisplayName','experimental coefficient of preshear \mu_{psh}');

% Create xlabel
xlabel('t^~ [-]','FontSize',24,'FontName','times new roman');

% Create ylabel
ylabel('\mu_{ie} [-]','FontSize',24,'FontName','times new roman');

% Create plot
plot(X3,Y3,'Parent',axes1,'MarkerSize',10,'Marker','hexagram',...
    'LineWidth',10,...
    'LineStyle',':',...
    'Color',[1 0 1],...
    'DisplayName','experimental coefficient of shear \mu_{sh}');

 legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.560069444444444 0.151537267300188 0.3421875 0.190684133915575]);
 


%%
%load numerical data first!!
ee=1909;
xL=[0.876196990424077;1.086867305061559;1.31942544459644;1.64090287277702];

n = [876;1087;1319;1641];

xN1 = data(ii).timesteps(1:ee)/xL(2);
yN1 = [data(ii).muR(1:n(2)); data(ii).muR(n(2)+1:ee)*.7713];



yN2 = mean(yN1(n(1)):yN1(n(2)));

X2=[xN1(n(1));xN1(n(2))];
Y2=[yN2;yN2];

yN3=mean(yN1(n(3)):yN1(n(4)));

X3=[xN1(n(3));xN1(n(4))];
Y3=[yN3;yN3];




figure2 = figure;

% Create axes
axes1 = axes('Parent',figure2,'FontSize',24,'FontName','times new roman');
%% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0.5 1.08510211436917]);
box(axes1,'on');
hold(axes1,'all');

 % Create plot
plot(xN1,yN1,'Parent',axes1,'LineWidth',3,...
    'DisplayName','numerical coefficient of internal friction \mu_{ie}',...
    'Color',[0 0 0]);

% yy2 = mean(y(m(1)):y(m(2)));
% 
% X2=[x(m(1));x(m(2))];
% Y2=[yy2;yy2];
% 
% yy3=mean(y(m(3)):y(m(4)));
% 
% X3=[x(m(3));x(m(4))];
% Y3=[yy3;yy3];

% Create plot
plot(X2,Y2,'Parent',axes1,'MarkerSize',10,'Marker','diamond','LineWidth',10,...
    'LineStyle','--',...
    'Color',[1 0 0],...
    'DisplayName','numerical coefficient of preshear \mu_{psh}');

% Create xlabel
xlabel('t^~ [-]','FontSize',24,'FontName','times new roman');

% Create ylabel
ylabel('\mu_{ie} [-]','FontSize',24,'FontName','times new roman');

% Create plot
plot(X3,Y3,'Parent',axes1,'MarkerSize',10,'Marker','hexagram',...
    'LineWidth',10,...
    'LineStyle',':',...
    'Color',[1 0 1],...
    'DisplayName','numerical coefficient of shear \mu_{sh}');

 legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.560069444444444 0.151537267300188 0.3421875 0.190684133915575]);


ylim([0.0 1.5]);


% figure(5)
% plot(xN1,yN1);
% 
% 
% %ylabel('\mu_{ie}')
% ylabel('\mu_{ie} [-]')
% %title (['Sinter fine - normal stress = 2000 [Pa]', 'FontSize',24)
% title (['Sinter fine - normal stress = 2000 [Pa]'], 'FontSize',24)
% set(gca,'fontname','times new roman')
% set(gca,'FontSize',20) ;
% xlabel('time [s]','FontSize', 20);
% ylabel('\mu_{ie} [-]', 'FontSize', 20);
% title (['Sinter fine - experimental - normal stress = 2000 [Pa]'], 'FontSize',24)
% a=find(y<0.01);
% a=find(y<0.05);
% a=find(x==300);
% a=max(find(x<300));
% b=min(find(x>350));
% x=unnamed(1:a,b:end);
% x=unnamed(1:a);
% length(unnamed)
% length(unnamed)-b
% x(a+1:a+length(unnamed)-b) = unnamed(b:end)
% x(a+1:a+length(unnamed)-b+1) = unnamed(b:end)
% y=unnamed1(1:a);
% y(a+1:a+length(unnamed1)-b+1) = unnamed1(b:end)
% plot(x,y)
% for i=(a+1):(a+length(unnamed)-b+1)
% x(i)=x(i)-50
% end
% plot(x,y)
% title (['Sinter fine - experimental - normal stress = 2000 [Pa]'], 'FontSize',24)
% xlabel('time [s]','FontSize', 20);
% ylabel('\mu_{ie} [-]', 'FontSize', 20);