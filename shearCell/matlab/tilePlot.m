k=1;
a = zeros(6000,101);
for j= 0.1:0.1:1
    for i = 0.1:0.1:1
     b= find(merge(:,1)<j & merge(:,1)>j-0.1 & merge(:,2)<i & merge(:,2)>i-0.1);
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

for i=1:w
    a1 = find(c(:,i)==0);
    a2 = find(c(:,i)<0.6 & c(:,i)>0.49);
    a3 = find(c(:,i)<0.7 & c(:,i)>0.6);
    a4 = find(c(:,i)<0.8 & c(:,i)>0.7);
    a5 = find(c(:,i)<0.9 & c(:,i)>0.8);
    
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
            g(i)= 224;
        elseif k==3
            g(i)= 128;
        elseif k==4
            g(i)= 96;
        elseif k==5
            g(i)= 0;
        end
        
    else g(i)= 255;
    end
    
    l(:)=0;
end
k=1;
hold on
for i=0.1:0.1:1
for j=0.1:0.1:1
   % Draw tile (i,j)
     if g(k)==255
           % g(i)= 255;
           h1=fill([i-0.1 i i i-0.1 i-0.1],[j-0.1 j-0.1 j j j-0.1], [g(k)/255 g(k)/255 g(k)/255])   ;
        elseif g(k)==224
           % g(i)= 224;
           h2=fill([i-0.1 i i i-0.1 i-0.1],[j-0.1 j-0.1 j j j-0.1], [g(k)/255 g(k)/255 g(k)/255])   ;
        elseif g(k)==128
          %  g(i)= 128;
          h3=fill([i-0.1 i i i-0.1 i-0.1],[j-0.1 j-0.1 j j j-0.1], [g(k)/255 g(k)/255 g(k)/255])   ;
        elseif g(k)==96
          %  g(i)= 96;
          h4=fill([i-0.1 i i i-0.1 i-0.1],[j-0.1 j-0.1 j j j-0.1], [g(k)/255 g(k)/255 g(k)/255])   ;
        elseif g(k)==0
            %g(i)= 0;
            h5=fill([i-0.1 i i i-0.1 i-0.1],[j-0.1 j-0.1 j j j-0.1], [g(k)/255 g(k)/255 g(k)/255])   ;
    end
    %fill([i-0.1 i i i-0.1 i-0.1],[j-0.1 j-0.1 j j j-0.1], [g(k)/255 g(k)/255 g(k)/255])   ;
    k=k+1;
end
end


% h1 = plot(x1, y1, color1);
% hold on;
% plot(x2, y2, color1);

% h2 = plot(x3, y3, color2);
% plot(x4, y4, color2);
% 
 legend([h1 h2 h3 h4 h5],{'no values', '0.5<COR<0.6','0.6<COR<0.7', '0.7<COR<0.8', '0.8<COR<0.9'},'Location','SouthWest');