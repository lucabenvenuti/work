%plotAreaData
clear all;
close all;
clc;

unitSysDefault = 'si';  % 'si' or 'cgs'

% select files that should be postprocessed
sim_dir = '../results'; % directory, where simulation files can be found
filepattern = 'area_fid*.txt'; % e.g. 'force.*.txt' %Andi
filepatterncsv = 'sim_parAOR_fid*.csv'; % e.g. 'force.*.txt' %Andi
filepatternangle = 'angle_fid*.txt'; % e.g. 'force.*.txt' %Andi


% select interesting cases (same names as in the csv file!!)
% example: searchCases = {'fric' 0.6
%                         'rf'   [0.2 0.4]};
%   for all cases use empty searchCases = {};
searchCases = {...'fric' 0.4 %[0.4 0.8]
               ...'rf'   0.4 %[0.4 0.8]
               ...'fid'  [	20025	20026	20027	20028	20029	20030 20035		20201	20202	20203	20204 20205] %20101	20102	20103	20125	20126 20001	20002
               ...'dens' 1500
               };
           
% define column of forces/position in the data file
col_X = 1;
col_Y = 2;
col_Z = 3;

           
%doNN
NNFlag = false;
hiddenLayerSizeVector = 5:14;           
           
% save images
saveFlag = false;           
saveDir = '../images';

%% The magic of regular expressions!
% get from file name:
%           fieldname after underscore (lower case)
%           Number of case (Upper case or number)
%expr = '((?<=[_.])[a-z]*)|((?<=[_.][a-z]*)([A-Z0-9]*(\.[0-9]+)?))'; % without e-formated numbers
expr = '((?<=[_.])[a-z]*)|((?<=[_.][a-z]*)([A-Z0-9]*(\.[0-9]+)?(e\-[0-9]+)?))';

%% read all data; prepare data structure; area correction;
% 
listfile = dir(fullfile(sim_dir,filepattern));
nFiles = length(listfile);

if (nFiles == 0)
    error('No files are selected. Check the filepattern.');
end

listfilecsv = dir(fullfile(sim_dir,filepatterncsv));
nFilescsv = length(listfilecsv);

if (nFilescsv == 0) || (nFilescsv ~= nFiles)
    error('No or incorrect number of csv-files. Check the filepattern.');
end


listfileangle = dir(fullfile(sim_dir,filepatternangle));
nFilesangle = length(listfileangle);

if (nFilesangle == 0) || (nFilesangle ~= nFiles)
    error('No or incorrect number of angle-files. Check the filepattern.');
end

idxCsv = 1; % counter for number of csv-files
for ii=1:nFilescsv
    % name
    iName = listfilecsv(ii).name;
    disp(['Prozessing ',iName,' ...']);
    % get info from file name (file id)
    [flags] = regexp(iName,expr,'match');
    idxFid = find(strcmp('fid',flags));
    iFid = str2double(flags{idxFid+1}); % current fid
    
    % check if id already exists
    
    if ( exist('data','var') && ~isempty(find([data(:).fid]==iFid,1)) )
        % file-id already exists in the data structure
        disp(['The fileID = ',num2str(iFid),' already exists.']);
    else
        % create new simulation case in the data structure
        data(idxCsv).fid = iFid;
        
        % set default values; may be overwritten by csv-data
        data(ii).svwall = 3; % scale for wall velocity: vWall = svwall*rp (default = 3)
        
        % import data file
        csv = importdata(fullfile(sim_dir,iName));
        
        % export csv data as structure fields
        for jj=1:length(csv.data)
            data(idxCsv).(strtrim(csv.colheaders{jj})) = csv.data(jj);
        end
        idxCsv = idxCsv+1;
    end
end

clear iFid idxCsv idxFid iName csv flags ii nFilescsv listfilecsv

% select only interesting cases
if ~isempty(searchCases)
    nData = length(data);
    idxSearch = ones(1,nData);
    for ii=1:size(searchCases,1)
        searchProp = searchCases{ii,1};
        searchValues = searchCases{ii,2};
        nSearchValues = length(searchValues);
        tmpSearch = zeros(1,nData);
        for jj=1:length(searchValues)
            tmpSearch = tmpSearch|([data(:).(searchProp)]==searchValues(jj)); % logic-or for different numbers of same property
        end
        idxSearch = idxSearch&tmpSearch; % logic-and for different properties
    end
    if isempty(find(idxSearch,1))
        error('No case selected. Check your searchCases.');
    else
        data = data(idxSearch);
    end
end

% check all force files
for ii=1:nFiles
    % name
    iName = listfile(ii).name;
    disp(['Prozessing ',iName,' ...']);
    % get info from file name
    [flags] = regexp(iName,expr,'match');
    idxFid = find(strcmp('fid',flags));
    iFid = str2double(flags{idxFid+1}); % current fid
    
    % find fid in data
    idxData = find([data(:).fid]==iFid);
    if isempty(idxData)
        disp('... skipped');
        continue; % this file-id may be removed by the search algorithm
    end
    
    %col_X
    
    % get cad number
    %idxCad = find(strcmp('cad',flags));
    %iCad = str2double(flags{idxCad+1}); % current cad
    
    % import data file
    data(idxData).vecData = importdata(fullfile(sim_dir,iName))';
    
    % generate structure
    
%     data(idxData).cad(iCad).header = force.colheaders;
%     data(idxData).cad(iCad).values = force.data;
%     data(idxData).cad(iCad).flags  = flags; % only for test
    if isfield (data(ii), 'uniSys')
       if data(ii).uniSys==2
           unitSys = 'cgs';
       else
           unitSys = 'si';
       end
    else
       unitSys = unitSysDefault; %default value in the user input
    end
    
    switch unitSys
        case 'si'
            scaleLength = 1; % is the same for velocity
            scaleMass = 1;
            scaleForce = 1;
            scaleDens = 1;
        case 'cgs'
            scaleLength = 1e-2; % cm -> m; also velocity: cm/s -> m/s
            scaleMass = 1e-3; % g -> kg;
            scaleForce = 1e-5; % dyne -> newton
            scaleDens = scaleMass/scaleLength^3; % g/cm^3 -> kg/m^3
    end
    
    data(ii).scaleLength = scaleLength;
    data(ii).scaleMass = scaleMass;
    data(ii).scaleForce = scaleForce;
    data(ii).scaleDens = scaleDens;
    rolfrtypnum = data(ii).rolfrtypnum;
    
    if rolfrtypnum == 1
        rolfrtyp =	'no';
    elseif rolfrtypnum == 2
        rolfrtyp =	'cdt';
    elseif rolfrtypnum == 3
        rolfrtyp =	'epsd';
    else
        rolfrtyp =	'epsd2';
    end
    
    % generate name for legends
    iName  = ['aor.rad',num2str(data(ii).rad),'_dcyldp',num2str(data(ii).dCylDp),...
        '_density',num2str(data(ii).dens),'_rest',num2str(data(ii).rest),...
        '_fric', num2str(data(ii).fric), '_rf', num2str(data(ii).rf), ...
        '_dt', num2str(data(ii).dt),  ...
        '_rolfrtyp', rolfrtyp,    ...
        '_sysunit_', unitSys, '_fileID', num2str(data(ii).fileID)   ];
    data(ii).name = iName;
    
    %angle
    iNameAngle = listfileangle(ii).name;
    data(ii).nameAngle =  iNameAngle;
    angleFile = importdata(fullfile(sim_dir,iNameAngle));
    data(ii).angleLi = angleFile(2);
end


%% %% line styles and color maps
lineStyles={'-','--',':','-.'};  % possible linestyles
nSimCases = length(data);
cmap = lines(nSimCases); % color map for all files
cmapCad = lines(nSimCases/3); % color map for one cad geometry

%%


maxNonZeroCutPlus1 = 0;
nOfCuts = 8;
%dirfile = '../area';
%filepattern = 'area_*';
%filepattern2 = 'angle_*';

%listfile = dir(fullfile(dirfile,filepattern));
%listfile2 = dir(fullfile(dirfile,filepattern2));
%nFiles = length(listfile);
leg = cell(1,nFiles);

%disp([num2str(nFiles), ' files to process ...']);
i=1;
cc=1;

for i = 1:nSimCases
    % name
%     iName = listfile(i).name;
%     iName2 = listfile2(i).name;
%     info = dlmread(fullfile(dirfile,['angle_',num2str(i)]));
     %leg{1,i} = ['corf ',num2str(info(1,1),'%6.4f'),' angle ',num2str(info(2,1))];
     leg{1,i} = data(ii).name;
%     disp(['Processing ', iName, ' ...']);
%     data = loaddata(fullfile(dirfile,iName),3,0);
%     data2 = loaddata(fullfile(dirfile,iName2),1,0);
    
%     rf(i) = data2(1,1);
%     AOR(i)= data2(1,2);
    
    %
    if i>1 
        aa=length(zPos(1,:));
        if aa>cc
            cc = aa;
        else 
            aa = cc;
        end
        bb=length(data(i).vecData(1,:));
        %zPos(i,:) = zeros(1,aa)+data(1,:);
        zPos(i,1:bb) = data(i).vecData(1,:);
        zPos(i,(bb+1):aa) = zeros(1,(aa-bb));
        rad(i,1:bb) = data(i).vecData(3,:);
        rad(i,(bb+1):aa) = zeros(1,(aa-bb));
    else
        zPos(i,:) = data(i).vecData(1,:);
        rad(i,:) = data(i).vecData(3,:);
    end
    
    nOfCuts = size(data(i).vecData, 2);
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
    
    data(i).angleMa = mean(angles(i,:));
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

dataAOR = data;

clear data

%% save matlab data
i=1;
j=1;
[a,b]=size(searchCases);

searchName{1} = 'an';

for i=1:a
       j=i+1;
       searchName{j}=([searchName{i},searchCases{i,1},num2str(searchCases{i,2})]);
end

save(['AOR',searchName{end}, '.mat'], 'dataAOR');
%save(['AOR', ], dataAOR);%,'name','off', 'fanspeed', 'indata', 'meanoff', '-mat'); %

%% Neural Network
if (NNFlag)
    
    % Choose a Training Function
    %help nntrain
    % For a list of all training functions type: help nntrain
    % 'trainlm' is usually fastest.
    % 'trainbr' takes longer but may be better for challenging problems. 
    % 'trainscg' uses less memory. NFTOOL falls back to this in low memory situations.
    trainFcn = 'trainscg'; 
    %     trainb    - Batch training with weight & bias learning rules.
    %     trainc    - Cyclical order weight/bias training.
    %     trainr    - Random order weight/bias training.
    %     trains    - Sequential order weight/bias training.
    addpath('/mnt/DATA/liggghts/work/shearCell/matlab');
    if (exist('densityBulkBoxMean'))
        %targetNN(iijj,3)=densityBulkBoxMean(iijj);
        [NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFun(nSimCases,dataAOR,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxMean);
    else
        [NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFun(nSimCases,dataAOR,trainFcn,hiddenLayerSizeVector, dataAOR(:).angleLi, dataAOR(:).angleMa);
    end
    
    %myNeuNetFun(nSimCases,data
        net=NNSave2{errorEstSumMaxIndex2(1),1}.net;
        yy3=net(x2);
        yy4(1,1,:)=yy3;
        %yy4-yy2(errorEstSumMaxIndex2,:,:) this should be zero
        net=NNSave2{errorEstSumMaxIndex2(2),2}.net;
        yy5=net(x2);
        yy6(1,2,:)=yy5;

end