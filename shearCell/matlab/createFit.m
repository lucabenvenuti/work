function pd1 = createFit(X)
%CREATEFIT    Create plot of datasets and fits
%   PD1 = CREATEFIT(X)
%   Creates a plot, similar to the plot in the main distribution fitting
%   window, using the data that you provide as input.  You can
%   apply this function to the same data you used with dfittool
%   or with different data.  You may want to edit the function to
%   customize the code and this help message.
%
%   Number of datasets:  1
%   Number of fits:  1
%
%   See also FITDIST.

% This function was automatically generated on 25-Oct-2014 15:53:19

% Output fitted probablility distribution: PD1

% Data from dataset "X data":
%    Y = X

% Force all inputs to be column vectors
X = X(:);

% Prepare figure
clf;
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "X data"
[CdfF,CdfX] = ecdf(X,'Function','cdf');  % compute empirical cdf
BinInfo.rule = 1;
[~,BinEdge] = internal.stats.histbins(X,[],[],BinInfo,CdfF,CdfX);
[BinHeight,BinCenter] = ecdfhist(CdfF,CdfX,'edges',BinEdge);
hLine = bar(BinCenter,BinHeight,'hist');
set(hLine,'FaceColor','none','EdgeColor',[0.333333 0 0.666667],...
    'LineStyle','-', 'LineWidth',1);
xlabel('Data');
ylabel('Density')
LegHandles(end+1) = hLine;
LegText{end+1} = 'X data';

% Create grid where function will be computed
XLim = get(gca,'XLim');
XLim = XLim + [-1 1] * 0.01 * diff(XLim);
XGrid = linspace(XLim(1),XLim(2),100);


% --- Create fit "fit 10"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd1 = ProbDistUnivParam('normal',[ 0.8346811985254, 0.6187407505421])
pd1 = fitdist(X, 'normal');
YPlot = pdf(pd1,XGrid);

% maxX = max(X);
% minX = min(X);
% a = min(find(XGrid>minX));
% b = max(find(XGrid<maxX));
% c=XGrid(a:b);
% d=YPlot(a:b);
% max(d);
% floor(c(1));
% round(c(end));
% floor(min(c));
% round(max(c));
%for 

hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fit 10';

%axis([floor(c(1)),round(c(end)),floor(min(c)),round(max(c))]);
% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 20, 'Location', 'NorthWest');
set(hLegend,'Interpreter','none');

figHandles = findobj('Type','figure');
set(gca,'FontSize',20) ;


end