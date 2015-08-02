
% gg=find(X<0.4);
% X(gg)=0;

clearvars merge
% 
% 
merge(:,1)=Y';%(sf) %X'; (sf)
merge(:,2)=Z';%(rf) %Y'; (rf)
merge(:,3)=S';%(rad_sigma) %S'; (cor)

% merge = [merge1;merge2];


% X=gloriaAugustaSchulzeNN(2,:); %cor
% Y=gloriaAugustaSchulzeNN(3,:); %sf
% Z=gloriaAugustaSchulzeNN(4,:); %rf
% S=gloriaAugustaSchulzeNN(5,:); %rad_sigma

legend1 = 'radsigma' ;
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

%c(:,:) = merge(a(:,:),3);


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
    %     a1 = find(c(:,i)==0);
    %     a2 = find(c(:,i)<0.6 & c(:,i)>0.49);
    %     a3 = find(c(:,i)<0.7 & c(:,i)>0.6);
    %     a4 = find(c(:,i)<0.8 & c(:,i)>0.7);
    %     a5 = find(c(:,i)<0.9 & c(:,i)>0.8);
    
    %     a2 = find(c(:,i)<6.9e-05 & c(:,i)>2.5e-05);
    %     a3 = find(c(:,i)<1.1e-04 & c(:,i)>6.9e-05);
    %     a4 = find(c(:,i)<1.5e-04 & c(:,i)>1.1e-04);
    %     a5 = find(c(:,i)<2e-04 & c(:,i)>1.5e-04);
    
    a2 = find(c(:,i)<int1 & c(:,i)>minC);
    a3 = find(c(:,i)<int2 & c(:,i)>int1);
    a4 = find(c(:,i)<int3 & c(:,i)>int2);
    a5 = find(c(:,i)<maxC & c(:,i)>int3);
    
    if (~isempty(a2) | ~isempty(a3) | ~isempty(a4) | ~isempty(a5))
        %select max
        l(1) = 1;
        l(2) = length(a2);
        l(3) = length(a3);
        l(4) = length(a4);
        l(5) = length(a5);
        [h,k]=max(l);
        
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
    
    %    l(:)=0;
end
h7=figure(25)
k=1;
hold on
for i=app:app:1
    for j=app:app:1
        % Draw tile (i,j)
        if g(k)==255
            % g(i)= 255;
            h2=fill([i-app i i i-app i-app],[j-app j-app j j j-app], [g(k)/255 g(k)/255 g(k)/255]  , 'EdgeColor', 'none')   ; %
        elseif g(k)==224
            % g(i)= 224;
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


% h2 = plot(x1, y1, color1);
% hold on;
% plot(x2, y2, color1);

% h2 = plot(x3, y3, color2);
% plot(x4, y4, color2);
%
%legend([h2 h3 h4 h5],{'0.5<COR<0.6','0.6<COR<0.7', '0.7<COR<0.8', '0.8<COR<0.9'},'Location','SouthWest');
%legend([h2 h3 h4 h5],{'2.5e-05<rad-sigma<6.9e-05','6.9e-05<rad-sigma<1.1e-04', '1.1e-04<rad-sigma<1.5e-04', '1.5e-04<rad-sigma<2e-04'},'Location','SouthEast');
legend([h2 h3 h4 h5],{[num2str(minC),'<' ,legend1, '<', num2str(int1)],[num2str(int1),'<' ,legend1, '<', ...
    num2str(int2)], [num2str(int2),'<' ,legend1, '<', num2str(int3)], [num2str(int3),'<' ,legend1, '<', num2str(maxC)]},'Location','SouthEast');
title ([exp_file_name, 'SRSCT: normal stress = ', num2str(dataNN2.ctrlStress), ' [Pa], coeff. P. = ', num2str(coeffPirker)] ,'FontSize',24);
% legend([h2],{'0.5<COR<0.6'},'Location','SouthWest');
% legend([h2 h3 h4 ],{'0.5<COR<0.6','0.6<COR<0.7', '0.7<COR<0.8'},'Location','SouthWest');
% legend([h4 h5],{'0.7<COR<0.8', '0.8<COR<0.9'},'Location','SouthWest');
set(gca,'fontname','times new roman','FontSize',20)  % Set it to times
 set(h7, 'Position', [100 100 1500 800],'color','w');
%set(gca, 'Position', [0 0 8 ])
% set(ah,'PaperPositionMode', 'manual', ...
% 'PaperUnits','centimeters', ...
% 'Paperposition',[0 0 50 50])
xlabel('\mu_s [-]', 'FontSize', 20);
ylabel('\mu_r [-]', 'FontSize', 20);

formatOut = 'yyyy-mm-dd-HH-MM-SS';
date1 = datestr(now,formatOut);
export_fig([exp_file_name, 'SRSCTnormalstress', num2str(dataNN2.ctrlStress), 'PacoeffP', num2str(coeffPirker*10),'0',num2str(41+i),'cloudPlot',num2str(i),date1],'-jpg', '-nocrop', h1);

% print(h7,'-djpeg','-r300',[exp_file_name, 'SRSCTnormalstress', num2str(dataNN2.ctrlStress), 'PacoeffP', num2str(coeffPirker*10),'0',num2str(41+i),'cloudPlot',num2str(i),date1])
