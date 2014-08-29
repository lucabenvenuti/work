%plotAreaData
clear all;
close all;
clc;

maxNonZeroCutPlus1 = 0;
nOfCuts = 8;
dirfile = '../area';
filepattern = 'area_*';
filepattern2 = 'angle_*';
saveDir = '../images';
listfile = dir(fullfile(dirfile,filepattern));
listfile2 = dir(fullfile(dirfile,filepattern2));
nFiles = length(listfile);
leg = cell(1,nFiles);

disp([num2str(nFiles), ' files to process ...']);
i=1;
cc=1;

for i = 1:nFiles
    % name
    iName = listfile(i).name;
    iName2 = listfile2(i).name;
    info = dlmread(fullfile(dirfile,['angle_',num2str(i)]));
    leg{1,i} = ['corf ',num2str(info(1,1),'%6.4f'),' angle ',num2str(info(2,1))];
    disp(['Processing ', iName, ' ...']);
    data = loaddata(fullfile(dirfile,iName),3,0);
    data2 = loaddata(fullfile(dirfile,iName2),1,0);
    
    rf(i) = data2(1,1);
    AOR(i)= data2(1,2);
    
    %
    if i>1 
        aa=length(zPos(1,:));
        if aa>cc
            cc = aa;
        else 
            aa = cc;
        end
        bb=length(data(1,:));
        %zPos(i,:) = zeros(1,aa)+data(1,:);
        zPos(i,1:bb) = data(1,:);
        zPos(i,(bb+1):aa) = zeros(1,(aa-bb));
        rad(i,1:bb) = data(3,:);
        rad(i,(bb+1):aa) = zeros(1,(aa-bb));
    else
        zPos(i,:) = data(1,:);
        rad(i,:) = data(3,:);
    end
    
    nOfCuts = size(data, 2);
    for j = 1:nOfCuts-1
        if rad(i,j+1) == 0 && rad(i,j) == 0
            if j > maxNonZeroCutPlus1
                maxNonZeroCutPlus1 = j;
            end
            break
        end
        drad = abs(rad(i,j+1)-rad(i,j));
        if drad == 0
            angles(i,j)=90;
        else
            angles(i,j)=atan(abs(zPos(i,j+1)-zPos(i,j))/drad)*180/pi;
        end
    end
end




hFig=figure;
plot(rad(:,1:maxNonZeroCutPlus1)',zPos(:,1:maxNonZeroCutPlus1)','+-');
grid on;
legend(leg{1,1:nFiles}, 'location', 'northeast');
title('Convex Hull Cuts of the AOR at different z-Positions');
xlabel('radius [m]');
ylabel('zPos [m]');
disp(angles);
hold on
text(rad(end,1),zPos(end,1)+zPos(end,1)*0.3,'1');
for i = 2:nOfCuts
    if rad(end,i) == 0, break, end
    text(rad(end,i)*1.05,zPos(end,i)+zPos(end,1)*0.3,num2str(i));
end

warning ('off','all');
print(hFig, fullfile(saveDir, 'figure.png'), '-dpng');

