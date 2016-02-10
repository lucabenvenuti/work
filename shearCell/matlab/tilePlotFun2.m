function a2 = tilePlotFun2( gloriaAugustaSchulzeNN, aorFlag, numFig, exp_file_name, legend1, coeffPirker)
%[ a2 ] = radarPrintVectorialFun( gloriaAugustaSchulzeNN, aorFlag, numFig, dataNN2, exp_file_name, coeffPirker)

switch aorFlag
    case 1 %aor
        merge(:,1) = gloriaAugustaSchulzeNN(3,:); %sf
        merge(:,2) = gloriaAugustaSchulzeNN(4,:); %rf
        merge(:,3) = gloriaAugustaSchulzeNN(2,:); %cor
    case 2 %mix
        merge(:,1) = gloriaAugustaSchulzeNN(2,:); %sf
        merge(:,2) = gloriaAugustaSchulzeNN(3,:); %rf
        merge(:,3) = gloriaAugustaSchulzeNN(1,:); %cor
    otherwise %sct
        merge(:,1) = gloriaAugustaSchulzeNN(3,:); %sf
        merge(:,2) = gloriaAugustaSchulzeNN(4,:); %rf
        merge(:,3) = gloriaAugustaSchulzeNN(2,:); %cor
end


k=1;
app =0.05;
a = zeros(6000,(1/app)^2+1);
for j= app:app:1
    for i = app:app:1
        b= find(merge(:,1)<j & merge(:,1)>j-app & merge(:,2)<i & merge(:,2)>i-app);
        if isempty(b)
        else a(1:length(b),k) = b;
        end
        % find();
        k=k+1;
    end
    
end


[v,w]=size(a);
c = zeros(v,w);
for i=1:v
    for j=1:w
        d=a(i,j);
        if d==0
            c(i,j)=0;
        else
            c(i,j)=merge(d,3);
        end
    end
end

minC = min(merge(:,3));
maxC = max(merge(:,3));
int1 = minC + (maxC - minC)/4;
int2 = minC + (maxC - minC)/2;
int3 = minC + (maxC - minC)*3/4;


for i=1:w
    a2 = find(c(:,i)<int1 & c(:,i)>minC);
    a3 = find(c(:,i)<int2 & c(:,i)>int1);
    a4 = find(c(:,i)<int3 & c(:,i)>int2);
    a5 = find(c(:,i)<maxC & c(:,i)>int3);
    
    if (~isempty(a2) | ~isempty(a3) | ~isempty(a4) | ~isempty(a5))
        l(1) = 1;
        l(2) = length(a2);
        l(3) = length(a3);
        l(4) = length(a4);
        l(5) = length(a5);
        [h,k] = max(l);
        
        if k==1
            g(i)= 255;
        elseif k==2
            g(i)= 192;
        elseif k==3
            g(i)= 128;
        elseif k==4
            g(i)= 96;
        elseif k==5
            g(i)= 0;
        end
        
    else g(i)= 255;
    end
end

clearvars h1 h2 h3 h4 h5 h6 h7

a2 = figure(numFig);
k = 1;
hold on
for i=app:app:1
    %%  Colours
    for j=app:app:1
        % Draw tile (i,j)
        if g(k)==255
            % g(i)= 255;
            h0=fill([i-app i i i-app i-app],[j-app j-app j j j-app], [g(k)/255 g(k)/255 g(k)/255]  , 'EdgeColor', 'none')   ; %white
        elseif g(k)==192
            h2=fill([i-app i i i-app i-app],[j-app j-app j j j-app], [255/255 0/255 0/255]);%, 'EdgeColor', 'none')   ; %red
        elseif g(k)==128
            h3=fill([i-app i i i-app i-app],[j-app j-app j j j-app], [102/255 204/255 0/255]);%, 'EdgeColor', 'none')   ; %green
        elseif g(k)==96
            h4=fill([i-app i i i-app i-app],[j-app j-app j j j-app], [0/255 128/255 255/255]);%, 'EdgeColor', 'none')   ; %blue
        elseif g(k)==0
            %g(i)= 0;
            h5=fill([i-app i i i-app i-app],[j-app j-app j j j-app], [g(k)/255 g(k)/255 g(k)/255]);%, 'EdgeColor', 'none')   ; %black
        end
        k = k + 1;
    end
    
    %%  B&W
    if (false)
        for j=app:app:1
            % Draw tile (i,j)
            if g(k)==255
                % g(i)= 255;
                h0=fill([i-app i i i-app i-app],[j-app j-app j j j-app], [g(k)/255 g(k)/255 g(k)/255]  , 'EdgeColor', 'none')   ; %
            elseif g(k)==192
                h2=fill([i-app i i i-app i-app],[j-app j-app j j j-app], [g(k)/255 g(k)/255 g(k)/255]);%, 'EdgeColor', 'none')   ;
            elseif g(k)==128
                %  g(i)= 128;
                h3=fill([i-app i i i-app i-app],[j-app j-app j j j-app], [g(k)/255 g(k)/255 g(k)/255]);%, 'EdgeColor', 'none')   ;
            elseif g(k)==96
                %  g(i)= 96;
                h4=fill([i-app i i i-app i-app],[j-app j-app j j j-app], [g(k)/255 g(k)/255 g(k)/255]);%, 'EdgeColor', 'none')   ;
            elseif g(k)==0
                %g(i)= 0;
                h5=fill([i-app i i i-app i-app],[j-app j-app j j j-app], [g(k)/255 g(k)/255 g(k)/255]);%, 'EdgeColor', 'none')   ;
                
            end
            %fill([i-0.1 i i i-0.1 i-0.1],[j-0.1 j-0.1 j j j-0.1], [g(k)/255 g(k)/255 g(k)/255])   ;
            k=k+1;
        end
    end
end

formatOut = 'yyyy-mm-dd-HH-MM-SS';
date1 = datestr(now,formatOut);

if (exist('h2') & exist('h3') & exist('h4') & exist('h5')) %all colours
    legend([h2 h3 h4 h5],{[num2str(minC, 3),' < ' ,legend1, ' < ', num2str(int1, 3)],[num2str(int1, 3),' < ' ,legend1, ' < ', ...
        num2str(int2, 3)], [num2str(int2, 3),' < ' ,legend1, ' < ', num2str(int3, 3)], [num2str(int3, 3),' < ' ,legend1, ' < ', num2str(maxC, 3)]},'Location','SouthEast');
    
elseif (exist('h2') & exist('h3') & exist('h4') & ~exist('h5')) %no black (h5)
    legend([h2 h3 h4],{[num2str(minC, 3),' < ' ,legend1, ' < ', num2str(int1, 3)],[num2str(int1, 3),' < ' ,legend1, ' < ', ...
        num2str(int2, 3)], [num2str(int2, 3),' < ' ,legend1, ' < ', num2str(int3, 3)]},'Location','SouthEast');    
    
elseif (exist('h2') & exist('h4') & exist('h5') & ~exist('h3')) %no green (h3)
    legend([h2 h4 h5],{[num2str(minC, 3),' < ' ,legend1, ' < ', num2str(int1, 3)], ...
        [num2str(int2, 3),' < ' ,legend1, ' < ', num2str(int3, 3)], [num2str(int3, 3),' < ' ,legend1, ' < ', num2str(maxC, 3)]},'Location','SouthEast');    
    
elseif (exist('h2') & exist('h3') & exist('h5') & ~exist('h4')) %no blue (h4)
    legend([h2 h3 h5],{[num2str(minC, 3),' < ' ,legend1, ' < ', num2str(int1, 3)],[num2str(int1, 3),' < ' ,legend1, ' < ', ...
        num2str(int2, 3)], [num2str(int3, 3),' < ' ,legend1, ' < ', num2str(maxC, 3)]},'Location','SouthEast'); 
    
elseif (~exist('h2') & exist('h3') & exist('h4') & exist('h5')) %no red (h2)
    legend([h3 h4 h5],{[num2str(int1, 3),' < ' ,legend1, ' < ', ...
        num2str(int2, 3)], [num2str(int2, 3),' < ' ,legend1, ' < ', num2str(int3, 3)], [num2str(int3, 3),' < ' ,legend1, ' < ', num2str(maxC, 3)]},'Location','SouthEast');    
    
elseif (exist('h2') & exist('h5') & ~exist('h3') & ~exist('h4')) %no green and no blue
    legend([h2 h5],{[num2str(minC, 3),' < ' ,legend1, ' < ', num2str(int1, 3)],...
        [num2str(int3, 3),' < ' ,legend1, ' < ', num2str(maxC, 3)]},'Location','SouthEast');

elseif (exist('h2') & exist('h3') & ~exist('h4') & ~exist('h5')) %all colours
    legend([h2 h3],{[num2str(minC, 3),' < ' ,legend1, ' < ', num2str(int1, 3)],[num2str(int1, 3),' < ' ,legend1, ' < ', ...
        num2str(int2, 3)]},'Location','SouthEast'); 
    
elseif (exist('h2') & ~exist('h3') & exist('h4') & ~exist('h5')) % no green no black
    legend([h2 h4 ],{[num2str(minC, 3),' < ' ,legend1, ' < ', num2str(int1, 3)], ...
        [num2str(int2, 3),' < ' ,legend1, ' < ', num2str(int3, 3)]},'Location','SouthEast');    
 
elseif (~exist('h2') & ~exist('h3') & exist('h4') & exist('h5')) %no red and no green
    legend([h4 h5],{[num2str(int2, 3),' < ' ,legend1, ' < ', num2str(int3, 3)], [num2str(int3, 3),' < ' ,legend1, ' < ', num2str(maxC, 3)]},'Location','SouthEast');
    
elseif (~exist('h2') & exist('h3') & ~exist('h4') & exist('h5')) %no red and no blue
    legend([h3 h5],{[num2str(int1, 3),' < ' ,legend1, ' < ', ...
        num2str(int2, 3)], [num2str(int3, 3),' < ' ,legend1, ' < ', num2str(maxC, 3)]},'Location','SouthEast');    
    
elseif (exist('h2') & ~exist('h3') & ~exist('h4') & ~exist('h5')) %only red
    legend(h2,[num2str(minC, 3),' < ' ,legend1, ' < ', num2str(int1, 3)],'Location','SouthEast');

elseif (~exist('h2') & exist('h3') & ~exist('h4') & ~exist('h5')) %only green
    legend(h3,{[num2str(int1, 3),' < ' ,legend1, ' < ', ...
        num2str(int2, 3)]},'Location','SouthEast');
    
elseif (~exist('h2') & ~exist('h3') & exist('h4') & ~exist('h5')) %only blue
    legend(h4,{[num2str(int2, 3),' < ' ,legend1, ' < ', num2str(int3, 3)]},'Location','SouthEast');    
    
elseif (~exist('h2') & ~exist('h3') & ~exist('h4') & exist('h5')) %only black
    legend(h5,{[num2str(int3, 3),' < ' ,legend1, ' < ', num2str(maxC, 3)]},'Location','SouthEast');    
    
else
    a2 = 0;
    warning(['no tile plot for ', exp_file_name]);
    return;
end    
    xlabel('\mu_s [-]', 'FontSize', 20);
    ylabel('\mu_r [-]', 'FontSize', 20);
    set(gca,'fontname','times new roman','FontSize',20)  % Set it to times
    set(a2, 'Position', [100 100 1500 800],'color','w');
    axis on
    box on
    
    switch aorFlag
        case 1 %aor
            savefig([num2str(numFig), 'TileAOR', exp_file_name, date1, '.fig']);
            export_fig([num2str(numFig), 'TileAOR', exp_file_name],'-png', '-nocrop', '-painters', a2);
        case 2 %mix
            savefig([num2str(numFig), 'TileMix', exp_file_name, date1, '.fig']);
            export_fig([num2str(numFig), 'TileMix', exp_file_name],'-png', '-nocrop', '-painters', a2);
        otherwise %sct
            savefig([num2str(numFig), 'TileSCT', exp_file_name, 'coeffP', num2str(coeffPirker), '-', date1, '.fig']);
            export_fig([num2str(numFig), 'TileSCT', exp_file_name, 'coeffP', num2str(coeffPirker)],'-png', '-nocrop', '-painters', a2);
    end
    
end
