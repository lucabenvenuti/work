% Postprocessing script for the shear cell simulation
%
%
% Author:  Andreas Aigner & Luca Benvenuti
% Date:    01/Apr/2014
% Version: 3.18

%% clear workspace
clear all
close all
clc

%% set font size!!
%get(0,'DefaultAxesFontSize') % --> 10 was default
set(0,'DefaultAxesFontSize',12);
%get(0,'DefaultTextFontSize') % --> 10 was default
set(0,'DefaultTextFontSize',12);


%% ### user input #########################################################

% simulation results and cvs-data are scaled from 'cgs' to 'si', if required
% may be overwritten by cvs-data
unitSysDefault = 'si';  % 'si' or 'cgs'

% select files that should be postprocessed
sim_dir = '/mnt/scratchPFMDaten/Luca/redoCheckShearCell/results'; % directory, where simulation files can be found
%sim_dir = 'S:\Luca\testPolidispersityShearCellCokeCoarseCokeFineSinterFineLimestoneFine';
%sim_dir = '/mnt/transfer/to_Luca/test';
filepattern = 'force.cad*_fid*.txt'; % e.g. 'force.*.txt' %Andi
filepatterncsv = 'sim_par*_fid*.csv'; % e.g. 'force.*.txt' %Andi

% select interesting cases (same names as in the csv file!!)
% example: searchCases = {'fric' 0.6
%                         'rf'   [0.2 0.4]};
%   for all cases use empty searchCases = {};

searchCases = {...'fric' 0.6 %[0.4 0.8]
    ...'rf' 0.6 %[0.4 0.8]
    
    ...'rest'   [0.5 0.9]
    ...'fid'   23141 %[	23168 23141 ]%	20026	20027	20028	20029	20030 20035		20201	20202	20203	20204 20205] %20101	20102	20103	20125	20126 20001	20002
    'shearperc' 1.0
    ... 'ctrlStress' -1.007001977856750e+04
    ... 'expMass' 8.7452 %0.9275 %
    ... 'dens' 3500 %[2500 3500]
    ...'dt' 1.0e-6
    ...'dCylDp' 20
    ...'radmu' 0.000551
    };

% define column of forces/position in the data file
col_fX = 1;
col_fZ = 3;
col_X = 7;
col_Z = 9;
col_massCol = 10;
col_mPartCol = 10;
col_massBox = 11;
col_numCol = 12;
col_numBox = 13;

% experimental data
exp_flag = true; % enable the comparision to experimental data
exp_dir = '.'; % directory, where the files can be found
legendExpFlag = 'schulze'; % choose between jenike & schulze
polidispersity_flag = true; %

if (exp_flag)
    switch legendExpFlag
        case {'jenike','poorMan'}
            exp_file = 'test05sinterfine-0-315mm'; %.mat %name of the mat-file, created with the script available at 'gemeinsames'; it must contain 'Fr' and 't'
            
            
        case 'schulze'
            exp_file = ['/mnt/benvenutiPFMDaten/Materials2Simulation2Application_RnR/BS/Luca_final/20131129_0841_sinterfine0-315_test04' , '.FTD']; % name of the FTD FILE, with the exp values vs time
            summaryFile = ['/mnt/benvenutiPFMDaten/Materials2Simulation2Application_RnR/BS/Luca_final/20131129_0841_sinterfine0-315_test04' , '.out']; % name of the out file, with the summary values
            sumForceFile = ['/mnt/benvenutiPFMDaten/Materials2Simulation2Application_RnR/BS/Luca_final/20131129_0841_sinterfine0-315_test04' , '.inp']; % name of the inp file, with the forces summary values
    end
    
end



% legend style ('std','latex')
legendFlag = 'std';

%dCylDp confrontation
dCylDpConfrontationFlag = false;
dCylDpConfrontationFlag2 = false;

%doNN
NNFlag = false;
hiddenLayerSizeVector = [5:40];
newInputFlag = false;
gloriaWinFlag = false;

% save images
saveFlag = false;
saveDir = './images';

% TEST: Add normal stress due to particle column
%   the column height is one cylinder radius for the given stl-geometry!
%   material density is defined in the cvs-files!
% ATTENTION: This is hardcoded in the script!
fracPart = 0.6; % particle fraction for the calculation of the bulk density %0.6 is correct
fracColMass = 1.0; %0.12;

manualPlateauFlag = false;
%doImage
imageFlag = true; %~manualPlateauFlag; % "~" gives the opposite of the boolean

startPlateauPreShearValue = .25;%.38;
stopPlateauPreShearValue = .35;%.48;
startPlateauShearValue = .75;%.80;
stopPlateauShearValue = .85;%.98;


% TEST: shift experimental data
% shiftFlag = false;

% ATTENTION:
%   Fieldnames are hardcoded. If filepattern changes, you have to adapt the code.
%   Simulation run time, settle time, ... is hardcoded!!
%   Take care if you change anything in the LIGGGHTS input script outside
%   of the 'user input' area!

% #########################################################################


%% The magic of regular expressions!
% get from file name:
%           fieldname after underscore (lower case)
%           Number of case (Upper case or number)
%expr = '((?<=[_.])[a-z]*)|((?<=[_.][a-z]*)([A-Z0-9]*(\.[0-9]+)?))'; % without e-formated numbers
expr = '((?<=[_.])[a-z]*)|((?<=[_.][a-z]*)([A-Z0-9]*(\.[0-9]+)?(e\-[0-9]+)?))';


%% read all data; prepare data structure; area correction;

listfile = dir(fullfile(sim_dir,filepattern));
nFiles = length(listfile);

if (nFiles == 0)
    error('No files are selected. Check the filepattern.');
end

listfilecsv = dir(fullfile(sim_dir,filepatterncsv));
nFilescsv = length(listfilecsv);

if (nFilescsv == 0) || (nFilescsv ~= nFiles/3)
    error('No or incorrect number of csv-files. Check the filepattern.');
end

% check all csv files
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
        lengthCsvData=length(csv.data);
        for jj=1:lengthCsvData
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
    sizeSearchCases=size(searchCases,1);
    for ii=1:sizeSearchCases
        searchProp = searchCases{ii,1};
        searchValues = searchCases{ii,2};
        nSearchValues = length(searchValues);
        tmpSearch = zeros(1,nData);
        %length(searchValues)
        for jj=1:nSearchValues
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
    
    % get cad number
    idxCad = find(strcmp('cad',flags));
    iCad = str2double(flags{idxCad+1}); % current cad
    
    % import data file
    force = importdata(fullfile(sim_dir,iName));
    
    % generate structure
    data(idxData).cad(iCad).header = force.colheaders;
    data(idxData).cad(iCad).values = force.data;
    data(idxData).cad(iCad).flags  = flags; % only for test
end



%% line styles and color maps
lineStyles={'-','--',':','-.'};  % possible linestyles
nSimCases = length(data);
cmap = lines(nSimCases); % color map for all files
cmapCad = lines(nSimCases/3); % color map for one cad geometry

% after reading all data; do some calculations
for ii=1:nSimCases
    
    %% set right units scale
    % scale all simulation data to SI units!!
    % simulation results and cvs-data are scaled from 'cgs' to 'si', if required
    % uniSys ... 1=SI, 2=CGS
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
    
    % get data for calculations from the data-structure
    % data from the csv file are in the LIGGGHTS units system -> scale to SI
    rad     = data(ii).rad*scaleLength; % particle radius in m
    dt      = data(ii).dt;              % time step
    svwall  = data(ii).svwall*scaleLength;          % scale for wall velocity: vWall = svwall*rp (default = 3)
    density = data(ii).dens*scaleDens;  % particle density (required for normal stress correction)
    data(ii).density = data(ii).dens*scaleDens;  % particle density (required for normal stress correction)
    % compare experimental data (ALWAYS SI UNITS)
    exp_area = (data(ii).expDiam*scaleLength)^2*0.25*pi; % the experimental set-up has a diameter of 10.415 cm
    exp_mass = data(ii).expMass*scaleMass;           % ATTENTION: The mass used to apply the normal stress during the experiment. VERY IMPORTANT!
    
    % constants - should not change, but may be
    dp         = 2*rad;
    skin       = 0.5*rad;
    vMax       = 0.49*skin/dt;
    vWall      = svwall*rad;
    
    nDump      = round(1e-2/dt);
    nDumpForce = round(1e-3/dt);
    
    g          = 9.81*scaleLength; % acceleration due to gravity in m/s2
    
    % get rolling friction type and set string for legend name
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
    iName  = ['force.rad',num2str(data(ii).rad),'_dcyldp',num2str(data(ii).dCylDp),...
        '_density',num2str(density),'_rest',num2str(data(ii).rest),...
        '_fric', num2str(data(ii).fric), '_rf', num2str(data(ii).rf), ...
        '_dt', num2str(data(ii).dt), '_ctrlStress', num2str(data(ii).ctrlStress), ...
        '_shearperc', num2str(data(ii).shearperc),'_rolfrtyp', rolfrtyp,    ...
        '_sysunit_', unitSys, '_fileID', num2str(data(ii).fileID)   ];
    data(ii).name = iName;
    
    % generate time vector
    %(cad 1,2, and 3 should have same length of data vector --> only one timevector)
    data(ii).timesteps = (1:1:length(data(ii).cad(1).values(:,1))).*nDumpForce.*dt;
    
    % calculate cylinder area
    data(ii).cylDiam = dp*data(ii).dCylDp;
    data(ii).area = (data(ii).cylDiam)^2*0.25*pi;
    
    % calculate index for time shift (Hardcoded time steps!!)
    if isfield(data(ii),'nStepsSettle')
        data(ii).idxStartTime = data(ii).nStepsSettle; % use data from the csv file
    else
        pz = 1.55*0.5*data(ii).cylDiam;
        nStepsSettle = round(pz/(0.5*vMax*dt));
        data(ii).idxStartTime = nStepsSettle; % writing force data starts delayed; dump is already discarded at start
    end
    
    % shift data & calculate corrected area
    data(ii).timesteps = data(ii).timesteps - data(ii).idxStartTime*dt;
    
    delta = vWall * data(ii).timesteps;
    height = 0.5* (data(ii).cylDiam - delta);
    alpha = 2* acos(1-(height/(0.5*data(ii).cylDiam)));
    data(ii).corrArea = (0.5*data(ii).cylDiam)^2*(alpha-sin(alpha));
    idx = ceil(data(ii).idxStartTime/nDumpForce);
    data(ii).corrArea(1:idx-1) = data(ii).corrArea(idx); % constant area at the start
    
    
    % weight force of the particle column above the shear layer
    % the column height is rCyl for the given stl-geometry!
    %data(ii).fPartColumnWeight = data(ii).cylDiam*0.5*density*fracPart*g*data(ii).area;
    if (size(data(ii).cad(3).values,2) >= col_Z) % should be calculated only for cad3, since it is the servo wall
        data(ii).fPartColumnWeight = (data(ii).cad(3).values(end,col_Z)*scaleLength-0.25*data(ii).cylDiam)*density*fracPart*g*data(ii).area;  %[N]
        data(ii).fPartColOld = data(ii).fPartColumnWeight;
    else
        warning('Warn:NormalStressCorr','Was there a servo wall.');
        data(ii).fPartColOld = zeros(size(data(ii).timesteps)); % dummy
    end
    
    %understand if the Dump File 3 has also mass indications
    data(ii).numColDump3 = length(data(ii).cad(3).header);
    
    if data(ii).numColDump3 > 12
        
        data(ii).numPartBox = data(ii).cad(3).values(:,col_numBox);
        data(ii).numPartCol = data(ii).cad(3).values(:,col_numCol);
        data(ii).massPartBox = data(ii).cad(3).values(:,col_massBox)*scaleMass; %[kg]
        data(ii).massPartCol = data(ii).cad(3).values(:,col_massCol)*scaleMass; %[kg]
        
    elseif data(ii).numColDump3 > 11
        
        data(ii).numPartCol = data(ii).cad(3).values(:,col_numCol);
        data(ii).massPartBox = data(ii).cad(3).values(:,col_massBox)*scaleMass; %[kg]
        data(ii).massPartCol = data(ii).cad(3).values(:,col_massCol)*scaleMass; %[kg]
        
        
    elseif data(ii).numColDump3 > 10
        
        data(ii).massPartBox = data(ii).cad(3).values(:,col_massBox)*scaleMass; %[kg]
        data(ii).massPartCol = data(ii).cad(3).values(:,col_massCol)*scaleMass; %[kg]
        
    elseif data(ii).numColDump3 > 9
        
        data(ii).massPartCol = data(ii).cad(3).values(:,col_massCol)*scaleMass; %[kg]
    end
    
    % normal uset(gca,'fontname','times new roman','FontSize',24)  % Set it to timesnd shear stress
    data(ii).sigmaZ  = (data(ii).cad(3).values(:,col_fZ).*scaleForce)./data(ii).area; % only servo-wall; without normal stress correction
    data(ii).sigmaZTot  = (data(ii).cad(3).values(:,col_fZ).*scaleForce+ data(ii).fPartColOld)./data(ii).area; % old normal stress correction
    data(ii).tauXZ    = data(ii).cad(2).values(:,col_fX).*scaleForce./data(ii).area;  % shear stress without correction
    data(ii).corrTauXZ = data(ii).cad(2).values(:,col_fX).*scaleForce./data(ii).corrArea'; % shear stress with corrected contact area
    
    if isfield (data(ii), 'massPartCol')
        data(ii).fPartColumnWeight2 = data(ii).fPartColumnWeight;
        data(ii).fPartColumnWeight = data(ii).massPartCol*g; %[N]
        data(ii).fPartColNew = data(ii).massPartCol*g; %[N]
        data(ii).sigmaZTot2 = (data(ii).cad(3).values(:,col_fZ).*scaleForce+ data(ii).fPartColNew)./data(ii).area; % new normal stress correction
        data(ii).muR = data(ii).corrTauXZ./data(ii).sigmaZTot2; % with new normal stress correction + corrected contact area
    else
        warning('Warn:NormalStressCorr','No mass of the particle column was saved.');
        data(ii).fPartColNew = zeros(size(data(ii).timesteps)); % dummy
        data(ii).muR = data(ii).corrTauXZ./data(ii).sigmaZTot;
    end
    
    
    
    
    
    % coefficient of friction (ratio shear stress / normal stress)
    %data(ii).muR = data(ii).TauXZ./data(ii).sigmaZ; % without any correction
    %
    
    
    %Volumes, void fraction and porosity of the whole cell & of the column
    data(ii).volPar = 4/3*pi*rad^3;
    volPar = 4/3*pi*rad^3;
    data(ii).zzzz = data(ii).cad(3).values(:,col_Z)*scaleLength;
    
    if isfield (data(ii), 'numPartBox')
        data(ii).volSolidBox = data(ii).volPar*data(ii).numPartBox;  %da count, ok only for monodispersed
        data(ii).volSolidCol = data(ii).volPar*data(ii).numPartCol;  %da count, ok only for monodispersed
        data(ii).volumeTotBox =  data(ii).area*data(ii).zzzz;       %da z
        data(ii).volumeTotCol =  data(ii).area*(data(ii).zzzz-0.25*data(ii).cylDiam); %da z
        
        data(ii).voidFracBox = (data(ii).volumeTotBox - data(ii).volSolidBox)./data(ii).volSolidBox; %da count, ok only for monodispersed
        data(ii).porosityBox = (data(ii).volumeTotBox - data(ii).volSolidBox)./data(ii).volumeTotBox;  %da count, ok only for monodispersed
        data(ii).voidFracCol = (data(ii).volumeTotCol - data(ii).volSolidCol)./data(ii).volSolidCol; %da count, ok only for monodispersed
        data(ii).porosityCol = (data(ii).volumeTotCol - data(ii).volSolidCol)./data(ii).volumeTotCol;  %da count, ok only for monodispersed
        
        
        data(ii).densityBulkBox = data(ii).massPartBox./data(ii).volumeTotBox; %da mass  %[kg/m3]
        densityBulkBoxMean(ii,1) = mean(data(ii).densityBulkBox);
        densityBulkBoxMin(ii,1) = min(data(ii).densityBulkBox);
        densityBulkBoxMax(ii,1) = max(data(ii).densityBulkBox);
        data(ii).densityParticleFromCountMass = data(ii).densityBulkBox./(1 - data(ii).porosityBox);
        
        psi = floor(length(data(ii).densityBulkBox)/2);
        
        startBulkPre = floor(length(data(ii).densityBulkBox)*0.2);
        endBulkPre = floor(length(data(ii).densityBulkBox)*0.4);
        
        startBulkPost = floor(length(data(ii).densityBulkBox)*0.7);
        endBulkPost = floor(length(data(ii).densityBulkBox)*0.9);
        
        densityBulkBoxPreShearMean(ii,1) = mean(data(ii).densityBulkBox(startBulkPre:endBulkPre));
        densityBulkBoxPreShearMin(ii,1) = min(data(ii).densityBulkBox(startBulkPre:endBulkPre));
        densityBulkBoxPreShearMax(ii,1) = max(data(ii).densityBulkBox(startBulkPre:endBulkPre));
        
        densityBulkBoxShearMean(ii,1) = mean(data(ii).densityBulkBox(startBulkPost:endBulkPost));
        densityBulkBoxShearMin(ii,1) = min(data(ii).densityBulkBox(startBulkPost:endBulkPost));
        densityBulkBoxShearMax(ii,1) = max(data(ii).densityBulkBox(startBulkPost:endBulkPost));
        
        %data(ii).density = 1368;
        %     %data(ii).fPartColumnWeight2 = data(ii).fPartColumnWeight;
        %     data(ii).fracPart1 = data(ii).fPartColumnWeight/((data(ii).cad(3).values(end,col_Z)*scaleLength-0.25*data(ii).cylDiam)*data(ii).density*g*data(ii).area);
        %     data(ii).fPartColumnWeight2 = data(ii).massPartCol;
        %     data(ii).fracPart2 = data(ii).fPartColumnWeight2/((data(ii).cad(3).values(end,col_Z)*scaleLength-0.25*data(ii).cylDiam)*data(ii).density*g*data(ii).area);
        %     data(ii).numPar = data(ii).massPartBox/volPar/1500/g;
        %     data(ii).porosity = 1 - data(ii).densityFromCountMass/data(ii).density;
        %     data(ii).fracPart5 = data(ii).porosity./(1-data(ii).porosity);
        %     data(ii).fPartColumnWeight5 = (data(ii).cad(3).values(end,col_Z)*scaleLength-0.25*data(ii).cylDiam)*density*data(ii).fracPart5*g*data(ii).area;
        %     %     data(ii).fracPart3 = data(ii).fPartColumnWeight./((data(ii).cad(3).values(end,col_Z)*scaleLength-0.25*data(ii).cylDiam)*data(ii).densityFroMass*g*data(ii).area);
        % %     data(ii).fracPart4 = data(ii).fPartColumnWeight2./((data(ii).cad(3).values(end,col_Z)*scaleLength-0.25*data(ii).cylDiam)*data(ii).densityFroMass*g*data(ii).area);
        %        % data(ii).fracPart5 =
        
        % TEST
        data(ii).volPartColServo = (data(ii).cad(3).values(:,col_Z)*scaleLength-0.25*data(ii).cylDiam)*data(ii).area;
        data(ii).volPartColMass = data(ii).cad(3).values(:,col_mPartCol)*scaleMass/density;
        
        data(ii).volFrac = data(ii).volPartColMass./data(ii).volPartColServo;
        disp(['Mean volume fraction in the particle column is ',num2str(mean(data(ii).volFrac)), '_fileID', num2str(data(ii).fileID)]);
        %disp(['Mean void fraction in the whole box is ',num2str(mean(data(ii).voidFracBox)), '_fileID', num2str(data(ii).fileID)]);
    end
    
end




%% init figures and plot graphs
% init figures
hFig(1) = figure; % position
hFig(2) = figure; % z-force
hFig(3) = figure; % x-force
hFig(4) = figure; % total exp. shear force

hFig(5) = figure; % ratio shear stress / normal stress

if (exp_flag)
    hFig(6) = figure;
end
hFig(7) = figure;

% legend parameters
leg = cell(7,1); % 7 figures for latex, 6 for std
iCnt = ones(7,1);

% container for comparision of the average coefficient of friction
avgMuR = zeros(2,nSimCases);

for ii=1:nSimCases
    
    
    scaleLength = data(ii).scaleLength;
    scaleMass = data(ii).scaleMass;
    scaleForce = data(ii).scaleForce;
    scaleDens = data(ii).scaleDens;
    
    fname = data(ii).name;
    afilename{ii,1} = data(ii).name;
    timesteps = data(ii).timesteps;
    
    % plot x/z-vel; plot x/z-position
    for jj=2:3 % check only cad 2 and 3
        if size(data(ii).cad(jj).values,2)>=col_Z
            % depending on geometry other coordinates are interesting
            if jj == 2
                pos = data(ii).cad(jj).values(:,col_X)*scaleLength;
                vel = (pos(2:end)-pos(1:end-1))/(nDumpForce*dt);
            else
                pos = data(ii).cad(jj).values(:,col_Z)*scaleLength;
                vel = (pos(2:end)-pos(1:end-1))/(nDumpForce*dt);
            end
            
            if (imageFlag)
                figure(hFig(1));
                subplot(2,1,1); hold on
                plot(timesteps,pos,'Color',cmap(ii,:));
                
                subplot(2,1,2); hold on
                plot(timesteps(1:end-1),vel,'Color',cmap(ii,:));
            end
            % legend for postion plot
            leg{1,iCnt(1)} = fname;
            iCnt(1) = iCnt(1)+1;
        end
    end
    
    % plot z-force (only cad 3)
    %%sigmaZ = data(ii).cad(3).values(:,col_fZ).*scaleForce./data(ii).area;
    sigmaZ = data(ii).sigmaZ;
    
    if (imageFlag)
        figure(hFig(2)); hold on
        plot(timesteps,sigmaZ,'Color',cmap(ii,:),'LineWidth',2);
    end
    %xlim([-0.05 0.5]);
    
    % legend for postion plot
    leg{2,iCnt(2)} = fname;
    iCnt(2) = iCnt(2)+1;
    
    % calculate average normal stress
    meanSigmaZ = mean(sigmaZ(round(length(sigmaZ)*2/3):end)); % mean value of the last third
    display1=[fname,': Mean normal stress for z direction (last third of the signal) = ',num2str(meanSigmaZ)];
    % display1=[fname,': Mean  = ',num2str(meanSigmaZ)];
    disp(display1);
    
    
    % plot total x-force (only cad 2)
    %tauXZ = data(ii).cad(2).values(:,col_fX).*scaleForce./data(ii).area;
    %corrTauXZ = data(ii).cad(2).values(:,col_fX).*scaleForce./data(ii).corrArea';
    if (imageFlag)
        figure(hFig(3)); hold on
        %plot(timesteps,data(ii).values(:,col_fX),'Color',cmap(ii,:)); % original data / force
        %plot(timesteps,tauXZ,'Color',cmap(ii,:)); % non-corrected area
        %plot(timesteps,data(ii).tauXZ,'Color',cmap(ii,:)); % non-corrected area
        %plot(timesteps,corrTauXZ,'Color',cmap(ii,:)); % corrected area
        plot(timesteps,data(ii).corrTauXZ,'Color',cmap(ii,:)); % corrected area
        %plot(timesteps,corrTauXZ,'LineStyle',lineStyles{mod(ii,numel(lineStyles))+1}{iCnt(3)},'Color','black','LineWidth',2); % for documentation purposes
        %plot(timesteps,data(ii).corrTauXZ,'LineStyle',lineStyles{mod(ii,numel(lineStyles))+1}{iCnt(3)},'Color','black','LineWidth',2); % for documentation purposes
    end
    %legend for force plots
    leg{3,iCnt(3)} = fname;
    iCnt(3) = iCnt(3)+1;
    %leg{3,iCnt(3)} = fname; % if more lines are plotted per file
    %iCnt(3) = iCnt(3)+1;
    
    % show used contact area
    %disp([data(ii).name,': The cylinder area = ',num2str(data(ii).area),' and corrected = ',num2str(data(ii).corrArea(1))]);
    
    %%
    % plots of the coefficient of friction
    muR = data(ii).muR;
    lMuR = length(muR);
    
    
    
    data(ii).maxMuR = max(muR(round(lMuR/10):end)); % skip initial peaks
    maxMuR(ii)=data(ii).maxMuR;
    %disp([fname{ii},': Maximum coefficient of friciton is ',num2str(maxMuR)]);
    
    maxMuRall=max(maxMuR);
    
    
    
end



%% TEST ratio shear stress / normal stress

clear timesteps sigmaZ tauXZ corrTauXZ fname


usedData = false(size(data));

%     nSimCases = length(data);
%     cmap = lines(nSimCases);
ijk = 1;
% NEW: Simplified since data is a structure for each simulation case
for ii=1:nSimCases
    
    fname = data(ii).name;
    
    scaleLength = data(ii).scaleLength;
    scaleMass = data(ii).scaleMass;
    scaleForce = data(ii).scaleForce;
    scaleDens = data(ii).scaleDens;
    
    % calculate data for this simulation case
    % normal stress with correction due to particle weight
    %sigmaZ = (data(ii).cad(3).values(:,col_fZ).*scaleForce+data(ii).fPartColumnWeight)./data(ii).area;
    
    % shear stress with corrected contact area
    %tauXZ = data(ii).cad(2).values(:,col_fX).*scaleForce./data(ii).area;
    %corrTauXZ = data(ii).cad(2).values(:,col_fX).*scaleForce./data(ii).corrArea';
    
    % ratio shear stress / normal stress
    %muR = corrTauXZ./sigmaZ;
    %murRR(ii)=;
    muR = data(ii).muR;
    
    %figure(hFig(5));
    %subplot(2,1,1);
    %hold on
    %plot(data(ii).timesteps,smooth(muR,200,'moving'),'LineStyle',lineStyles{mod(ii,numel(lineStyles))+1},'Color',cmap(mod(ii,size(cmap,1))+1,:),'LineWidth',2);
    %plot(data(ii).timesteps,muR,'LineStyle',lineStyles{mod(ii,numel(lineStyles))+1},'Color',cmap(mod(ii,size(cmap,1))+1,:),'LineWidth',2);
    %ylim([0 1.5]);
    
    
    
    
    %legend for force plots
    leg{6,iCnt(6)} = fname;
    iCnt(6) = iCnt(6)+1;
    
    %calc average and maximum coefficient of friction
    lMuR = length(muR);
    %avgMuR = mean(muR(round(lMuR/2):end));
    %maxMuR(ii) = max(muR(round(lMuR/10):end));
    maxMuR(ii)=data(ii).maxMuR;
    %disp([fname{ii},': Maximum coefficient of friciton is ',num2str(maxMuR)]);
    
    %maxMuRall=max(maxMuR);
    
    %         %new plot with just the simulations
    %         figure(hFig(6));
    %         hold on
    %         plot(data(ii).timesteps,muR,'LineStyle',lineStyles{mod(ii,numel(lineStyles))+1},'Color',cmap(mod(ii,size(cmap,1))+1,:),'LineWidth',2);
    %         ylim([0 maxMuRall]);
    %         %legend for force plots
    %         leg{6,iCnt(6)} = fname;
    %         iCnt(6) = iCnt(6)+1;
    
    data(ii).lTimeSteps=length(data(ii).timesteps);
    lTimeSteps = data(ii).lTimeSteps;
    %ff=length(muR);
    
    lTimeStepsDiv10=floor(lTimeSteps/10);
    hh=floor(lMuR/10);
    
    nn=0;
    
    for nn=1:lTimeStepsDiv10
        
        data(ii).timeStepSh(nn) = data(ii).timesteps(nn*10);
        data(ii).muRShMean(nn) = mean(muR((nn*10-9):1:(nn*10)));
        
    end
    
    
    %new plot with just the simulations with less points
    switch legendFlag
        case 'latex'
            data(ii).timestepsShort = data(ii).timesteps(1:10:end);
            muRshort = muR(1:10:end);
            
            if (imageFlag)
                figure(hFig(7));
                hold on
                %plot(data(ii).timestepsShort,muRshort,'LineStyle',lineStyles{mod(ii,numel(lineStyles))+1},'Color',cmap(mod(ii,size(cmap,1))+1,:),'LineWidth',2);
                plot(data(ii).timeStepSh,data(ii).muRShMean,'LineStyle',lineStyles{mod(ii,numel(lineStyles))+1},'Color',cmap(mod(ii,size(cmap,1))+1,:),'LineWidth',2);
                ylim([0 maxMuRall]);
            end
            %legend for force plots
            leg{7,iCnt(7)} = fname;
            iCnt(7) = iCnt(7)+1;
    end
    
    if (manualPlateauFlag)
        %    if (imageFlag)
        figure(13);
        plot(data(ii).timesteps,data(ii).muR)
        title('coefficient of internal friction identification');
        xlabel('time (s)');
        ylabel('\mu_{e}');
        grid on
        
        %find on figure the start and end point of the plateau
        [x,y] = ginput(4);
        
        
        %get the index of the start and end point of the plateau
        a=size(x);
        t=data(ii).timesteps;
        for i=1:a
            [N,bin]=histc(x(i),t);
            
            index=bin+1;
            if abs(x(i)-t(bin))<abs(x(i)-t(bin+1))
                fclosest=t(bin);
                index=bin;
            else
                fclosest=t(index);
            end
            fclose(i)=fclosest;
            indexer(i)=bin;
            
        end
        
        data(ii).startPlateauPreShear = indexer(1);
        data(ii).stopPlateauPreShear = indexer(2);
        data(ii).startPlateauShear = indexer(3);
        data(ii).stopPlateauShear  = indexer(4);
        data(ii).startPlateauPreShearValueMan = data(ii).startPlateauPreShear/lMuR; %length(data(ii).muR);
        data(ii).stopPlateauPreShearValueMan = data(ii).stopPlateauPreShear/lMuR; %length(data(ii).muR);
        data(ii).startPlateauShearValueMan = data(ii).startPlateauShear/lMuR; %length(data(ii).muR);
        data(ii).stopPlateauShearValueMan = data(ii).stopPlateauShear/lMuR; %length(data(ii).muR);
        
    else
        data(ii).startPlateauPreShear = floor(lMuR*startPlateauPreShearValue); %%             startPlateauPreShearValue = .38;
        data(ii).stopPlateauPreShear = floor(lMuR*stopPlateauPreShearValue); % stopPlateauPreShearValue = .48;
        data(ii).startPlateauShear = floor(lMuR*startPlateauShearValue); % startPlateauShearValue = .80;
        data(ii).stopPlateauShear = floor(lMuR*stopPlateauShearValue); % stopPlateauShearValue = .95;
    end
    %   end
    
    startPlateauPreShear = data(ii).startPlateauPreShear;
    stopPlateauPreShear = data(ii).stopPlateauPreShear;
    startPlateauShear = data(ii).startPlateauShear;
    stopPlateauShear = data(ii).stopPlateauShear;
    avgMuR1(ii,1) = mean(muR(startPlateauPreShear:stopPlateauPreShear));
    avgMuR2(ii,1) = mean(muR(startPlateauShear:stopPlateauShear));
    bavgMuR1min(ii,1) = 0.95*avgMuR1(ii,1);
    
    if avgMuR2(ii,1) > bavgMuR1min(ii,1)
        disp(num2str(data(ii).fid))
        correct(ijk)=data(ii).fileID;
        ijk=ijk+1;
    end
    
    disp([fname,': Average coefficient of friciton pre-shear is ',num2str(avgMuR1(ii,1))]);
    disp([fname,': Average coefficient of friciton shear is ',num2str(avgMuR2(ii,1))]);
    
    
    % calc average and maximum coefficient of friction
    % save average value and shear cell size for plot
    avgMuR(1,ii) = avgMuR2(ii);%mean(muR(round(lMuR*2/3):end));
    avgMuR(2,ii) = data(ii).dCylDp;
    dCylDpList(ii,1) = data(ii).dCylDp;
    %new plot with just the simulations
    if (imageFlag)
        figure(hFig(5));
        hold on
        
        %         t=data(ii).timesteps;
        %         for ijhk=1383:1812
        %             data(ii).timesteps(ijhk)=  data(ii).timesteps(ijhk) - (t(1383)-t(1261));
        %         end
        %
        % plot(data(ii).timesteps([1:1261,1383:1775])/x,data(ii).muR([1:1261,1383:1775]),'LineStyle',lineStyles{mod(ii,numel(lineStyles))+1},'Color',cmap(mod(ii,size(cmap,1))+1,:),'LineWidth',2);
        plot(data(ii).timesteps,data(ii).muR,'LineStyle',lineStyles{mod(ii,numel(lineStyles))+1},'Color',cmap(mod(ii,size(cmap,1))+1,:),'LineWidth',2);
        ylim([0 maxMuRall]);
        %legend for force plots
        leg{5,iCnt(5)} = fname;
        iCnt(5) = iCnt(5)+1;
    end
    if (dCylDpConfrontationFlag)
        % TEST: Plot weight of particle column (old and new)
        figure(11);
        hold on;
        plot(data(ii).timesteps,data(ii).fPartColOld,'-b',data(ii).timesteps,data(ii).fPartColNew,'-r');
        legend('old style','new style');
    end
    
end

%%   Average Plateaux
if (manualPlateauFlag)
    ii=1;
    sappsvmm = (mean([data(:).startPlateauPreShearValueMan])); %  startPlateauPreShearValueManMean
    soppsvmm = (mean([data(:).stopPlateauPreShearValueMan]));
    sapsvmm = (mean([data(:).startPlateauShearValueMan]));
    sopsvmm = (mean([data(:).stopPlateauShearValueMan]));
    %      startPlateauPreShearMeanMan = floor(length(data(ii).muR)*startPlateauPreShearValueManMean);
    %      stopPlateauPreShear = (mean([data(:).stopPlateauPreShear]));
    %      startPlateauShear = (mean([data(:).startPlateauShear]));
    %      stopPlateauShear = (mean([data(:).stopPlateauShear]));
    
    for ii=1:nSimCases
        lMuR = length(data(ii).muR);
        avgMuR5(ii,1) = mean(data(ii).muR(floor(lMuR*sappsvmm):floor(lMuR*soppsvmm)));
        avgMuR6(ii,1) = mean(data(ii).muR(floor(lMuR*sapsvmm):floor(lMuR*sopsvmm)));
    end
end
%%
if (dCylDpConfrontationFlag)
    % TEST: Calc mean and std; Plot data
    meanAvgMuR = mean(avgMuR(1,:));
    
    figure(12);
    hold on
    plot(avgMuR(2,:),avgMuR(1,:)/meanAvgMuR,'x');
    %xlim([min(avgMuR(2,:))-5 max(avgMuR(2,:))+5]);
    xlabel('dCyl / dP');
    ylabel('muR / mean(muR)');
    title(['Comparision: mean(muR) = ',num2str(meanAvgMuR),'.']);
    %
    %end
    
    % Fit function
    tmpX = 15:150;
    p = polyfit(avgMuR(2,:),meanAvgMuR./avgMuR(1,:),2);
    tmpMuR = polyval(p,tmpX);
    plot(tmpX,1./tmpMuR,'r');
    
    plot(avgMuR(2,:),avgMuR(1,:)/meanAvgMuR.*polyval(p,avgMuR(2,:)),'ro');
    
    % Manual fit: a + c*x^-2 = y
    xData = avgMuR(2,:)';
    yData = avgMuR(1,:)'/meanAvgMuR;
    
    M=[xData.^(-2), ones(size(xData))];
    coeffs = M\yData;
    cFit=coeffs(1);
    aFit=coeffs(2)*meanAvgMuR;
    
    M2 = [tmpX'.^(-2), ones(size(tmpX'))];
    plot(tmpX,M2*coeffs,'g');
    
    plot(avgMuR(2,:),avgMuR(1,:)/meanAvgMuR./(M*coeffs)','go');
    
    avgMuR3 = aFit+cFit*(1e300)^-2;
    
    % Coeffs for later comparison:
    % Normalized for a=1 --> c=1.73979e+2
    
    %% Fit: 'a+b*x-2fit'.
    if (dCylDpConfrontationFlag2)
        [xData, yData] = prepareCurveData( dCylDpList, avgMuR2 );
        
        % Set up fittype and options.
        ft = fittype( {'1', '((x)^-2)'}, 'independent', 'x', 'dependent', 'y', 'coefficients', {'a', 'b'} );
        
        % Fit model to data.
        [fitresult, gof] = fit( xData, yData, ft );
        
        % Plot fit with data.
        figure(14)
        title( ['Name', 'a+b*x-2fit'] );
        h = plot( fitresult, xData, yData );
        legend( h, 'avgMuR2 vs. dCylDpList', 'a+b*x-2fit', 'Location', 'NorthEast' );
        % Label axes
        xlabel( 'dCylDpList' );
        ylabel( 'avgMuR2' );
        grid on
        
        avgMuR4 = fitresult.a+fitresult.b*(1e300)^-2;
    end
    
end

%% load experimental data
if (exp_flag)
    switch legendExpFlag
        case {'jenike','poorMan'}
            load(fullfile(exp_dir,exp_file), 'Fr', 't');
            exp_shear = Fr./exp_area;
            
            figure(hFig(4)); hold on
            plot(t,exp_shear,'Color','red','LineWidth',2);
            %xlim([-1 data(1).timesteps(end)+1]);
            
            leg{4,iCnt(4)} = exp_file;
            iCnt(4) = iCnt(4)+1;
            
            %figure(hFig(4))
            %plot(t,exp_shear);
    end
end

%% TEST shift experiment data
% if (shiftFlag && exp_flag)
%
%     figure(hFig(3));
%     %[x,y] = ginput(2);
%     [x,y] = ginput(1);
%
%
%     hFig(4) = figure; hold on;
%
%     for ii=1:nFiles
%
%         fname = data(ii).name;
%         timesteps = data(ii).timesteps;
%
%
%
%         % plot total x-force
%         if (strcmp(data(ii).cad,'2'))
%             tauXZ = data(ii).values(:,col_fX).*scaleForce./data(ii).area;
%             corrTauXZ = data(ii).values(:,col_fX).*scaleForce./data(ii).corrArea';
%
%             figure(hFig(4)); hold on
%             plot(timesteps,tauXZ,'Color',cmap(ii,:));
%             plot(timesteps,corrTauXZ,'Color',cmap(ii,:),'LineWidth',1);
%
%         end
%
%     end
%
%     load(fullfile(exp_dir,exp_file), 'Fr', 't');
%     exp_shear = Fr./exp_area;
%
%     %nStart = find(t>min(x),1,'first');
%     %nEnd   = find(t>max(x),1,'first');
%
%     %tmp_shear = zeros(size(exp_shear));
%     %tmp_shear((nEnd-nStart):end)=exp_shear(1:(end-(nEnd-nStart-1)));
%     t=t-x;
%
%     figure(hFig(4)); hold on
%     %plot (t,tmp_shear,'Color',cmap(nFiles+1,:));
%     plot (t,exp_shear,'Color','red');
%     xlim([-1 max(data(1).timesteps)+1]);
%
% end


if (exp_flag)
    for ii=1:nSimCases
        
        if (imageFlag)
            figure(hFig(6));
            subplot(2,1,1);
            hold on
        end
        
        %legend for force plots
        leg{6,iCnt(6)} = fname;
        leg{6,iCnt(6)+1} = fname;
        iCnt(6) = iCnt(6)+2;
        
        muR = data(ii).muR;
        
        % plot coefficient of friction
        if (imageFlag)
            figure(hFig(6));
            subplot(2,1,1);
            hold on
            %plot(data(ii).timesteps,smooth(muR,200,'moving'),'LineStyle',lineStyles{mod(ii,numel(lineStyles))+1},'Color',cmap(mod(ii,size(cmap,1))+1,:),'LineWidth',2);
            %plot(data(ii).timesteps,muR,'LineStyle',lineStyles{mod(ii,numel(lineStyles))+1},'Color',cmap(mod(ii,size(cmap,1))+1,:),'LineWidth',2);
            plot(data(ii).timesteps,data(ii).corrTauXZ,'LineStyle',lineStyles{mod(ii,numel(lineStyles))+1},'Color',cmap(mod(ii,size(cmap,1))+1,:),'LineWidth',2);
            %line([data(ii).timesteps(1) data(ii).timesteps(end)],[avgMuR2(ii,1) avgMuR2(ii,1)],'Color',cmap(mod(ii,size(cmap,1))+1,:));
            %ylim([0 1.5]);
        end
        %         if avgMuR2(ii,1) > avgMuR1(ii,1)
        %             disp(fname)
        %
        %         end
        
        
        %         musavg(ii,1)=avgMuR;
        %         musmean(ii,1)=mean(muR(2000:3500));
        %         musmedian(ii,1)=median(muR(2000:3500));
    end
    
    
    % % % % % %     exp_sigma = 9.81*exp_mass/exp_area;
    
    
    switch legendExpFlag
        
        case 'schulze'
            
            
            
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
            if (imageFlag)
                figure(hFig(4)); hold on
                plot(time,tau,'Color','red','LineWidth',2);
                %xlim([-1 data(1).timesteps(end)+1]);
                
                leg{4,iCnt(4)} = exp_file;
                iCnt(4) = iCnt(4)+1;
                
                figure(hFig(6));
                subplot(2,1,2);
                plot(time,tau,'LineWidth',2);
            end
            jjj=1;
            ii=1;
            for ii=1:nSimCases
                if (data(ii).ctrlStress*-1*.95 < expOut.sigmaAnM <data(ii).ctrlStress*-1*1.05)
                    
                    switch data(ii).shearperc
                        case 0.4
                            data(ii).ratioShear = avgMuR2(ii)/coeffShear40;
                            data(ii).ratioPreShear = avgMuR1(ii)/expOut.coeffPreShear40;
                            data(ii).tauAb = expInp.tauAb40;
                            data(ii).sigmaAb = expOut.sigmaAb40;
                            data(ii).coeffShear = coeffShear40;
                            data(ii).tauAbPr = expOut.tauAbPr40;
                            data(ii).coeffPreShear = expOut.coeffPreShear40;
                            
                        case 0.6
                            data(ii).ratioShear = avgMuR2(ii)/coeffShear60;
                            data(ii).ratioPreShear = avgMuR1(ii)/expOut.coeffPreShear60;
                            data(ii).tauAb = expInp.tauAb60;
                            data(ii).sigmaAb = expOut.sigmaAb60;
                            data(ii).coeffShear = coeffShear60;
                            data(ii).tauAbPr = expOut.tauAbPr60;
                            data(ii).coeffPreShear = expOut.coeffPreShear60;
                            
                        case 0.8
                            data(ii).ratioShear = avgMuR2(ii)/coeffShear80;
                            data(ii).ratioPreShear = avgMuR1(ii)/expOut.coeffPreShear80;
                            data(ii).tauAb = expInp.tauAb80;
                            data(ii).sigmaAb = expOut.sigmaAb80;
                            data(ii).coeffShear = coeffShear80;
                            data(ii).tauAbPr = expOut.tauAbPr80;
                            data(ii).coeffPreShear = expOut.coeffPreShear80;
                            
                            
                        case 1.0
                            data(ii).ratioShear = avgMuR2(ii)/coeffShear100;
                            data(ii).ratioPreShear = avgMuR1(ii)/expOut.coeffPreShear100;
                            data(ii).tauAb = expOut.tauAbPr100;
                            data(ii).sigmaAb = expOut.sigmaAb100;
                            data(ii).coeffShear = coeffShear100;
                            data(ii).tauAbPr = expOut.tauAbPr100;
                            data(ii).coeffPreShear = expOut.coeffPreShear100;
                            
                    end
                    
                    data(ii).deltaRatioShear = abs(1-data(ii).ratioShear);
                    data(ii).deltaRatioPreShear = abs(1-data(ii).ratioPreShear);
                    
                    if ((data(ii).deltaRatioShear<0.05) & (data(ii).deltaRatioPreShear<0.05))
                        gloriaAugustaSchulze{jjj,1} = data(ii).name;
                        gloriaAugustaSchulze{jjj,2} = avgMuR1(ii);
                        gloriaAugustaSchulze{jjj,3} = avgMuR2(ii);
                        gloriaAugustaSchulze{jjj,4} = data(ii).tauAb;
                        gloriaAugustaSchulze{jjj,5} = data(ii).sigmaAb;
                        gloriaAugustaSchulze{jjj,6} = data(ii).coeffShear;
                        gloriaAugustaSchulze{jjj,7} = data(ii).ratioShear;
                        gloriaAugustaSchulze{jjj,8} = data(ii).deltaRatioShear;
                        gloriaAugustaSchulze{jjj,9} = data(ii).tauAbPr;
                        gloriaAugustaSchulze{jjj,10} = data(ii).coeffPreShear;
                        gloriaAugustaSchulze{jjj,11} = data(ii).ratioPreShear;
                        gloriaAugustaSchulze{jjj,12} = data(ii).deltaRatioPreShear;
                        jjj=jjj+1;
                    end
                end
            end
            
            
            
            
        case {'jenike','poorMan'}
            %plot(t,exp_shear./exp_sigma,'LineWidth',2)
            if (imageFlag)
                figure(hFig(6));
                subplot(2,1,2);
                plot(t,exp_shear,'LineWidth',2);
            end
            %ylim([0 1.5]);
            %xlim([0.0 60.0]); %%%%%%%%%%%experrimental time plotted
            
    end
    
end

if (exp_flag)
    switch legendExpFlag
        
        case 'jenike'
            
            load(fullfile(exp_dir,exp_file),'mueSPlateauPreShear', 'mueSPlateauShear', 'normalForceShear', 'normalforce', 'particletype');
            expJenikeArea = (0.1)^2*0.25*pi;%'mueSPlateauPreShear', 'mueSPlateauShear', 'normalForceShear', 'normalforce', 'particletype'
            normalStressJenike = normalforce/expJenikeArea;
            shearPercJenike = normalForceShear/normalforce;
            jjj=1;
            ii=1;
            for ii=1:nSimCases
                if (data(ii).ctrlStress*-1*.8 < normalStressJenike <data(1).ctrlStress*-1*1.2 && data(ii).shearperc*.8 < shearPercJenike < data(ii).shearperc*1.2)
                    data(ii).ratioShear = avgMuR2(ii)/mueSPlateauShear;
                    data(ii).ratioPreShear = avgMuR1(ii)/mueSPlateauPreShear;
                    data(ii).deltaRatioShear = abs(1-data(ii).ratioShear);
                    data(ii).deltaRatioPreShear = abs(1-data(ii).ratioPreShear);
                    if ((data(ii).deltaRatioShear<0.1) & (data(ii).deltaRatioPreShear<0.1))
                        gloriaAugustaJenike{jjj,1} = data(ii).name;
                        gloriaAugustaJenike{jjj,2} = avgMuR1(ii);
                        gloriaAugustaJenike{jjj,3} = avgMuR2(ii);
                        gloriaAugustaJenike{jjj,6} = data(ii).mueSPlateauShear;
                        gloriaAugustaJenike{jjj,7} = data(ii).ratioShear;
                        gloriaAugustaJenike{jjj,8} = data(ii).deltaRatioShear;
                        gloriaAugustaJenike{jjj,10} = data(ii).mueSPlateauPreShear;
                        gloriaAugustaJenike{jjj,11} = data(ii).ratioPreShear;
                        gloriaAugustaJenike{jjj,12} = data(ii).deltaRatioPreShear;
                        jjj=jjj+1;
                    end
                end
            end
    end
end


%% TEST Variance and mean value
%
% cntLine = ones(3,1);
% for ii=1:nFiles
%     if (strcmp(data(ii).cad,'2'))
%         switch data(ii).mu
%             case 'A'
%                 signalMatrix(cntLine(1), :, 1) = data(ii).values(:,col_fX)./data(ii).area;
%                 cntLine(1) = cntLine(1) + 1;
%             case 'B'
%                 signalMatrix(cntLine(2), :, 2) = data(ii).values(:,col_fX)./data(ii).area;
%                 cntLine(2) = cntLine(2) + 1;
%             case 'C'
%                 signalMatrix(cntLine(3), :, 3) = data(ii).values(:,col_fX)./data(ii).area;
%                 cntLine(3) = cntLine(3) + 1;
%             otherwise
%                 disp('ERROR');
%         end
%     end
% end
%
% hShad = figure; hold on
% hTest = figure; hold on
%
% for ii=1:3
%     m(ii,:) = mean(signalMatrix(:,:,ii));
%     s(ii,:) = std(signalMatrix(:,:,ii));
%     normS(ii,:) = s(ii,:)./m(ii,:);
%
%     figure(hShad);
%     %errorbar(timesteps,m,s);
%     shadedErrorBar(timesteps,m(ii,:),s(ii,:));
%
%     figure(hTest);
%     plot(timesteps(2000:end),normS(ii,2000:end));
%     disp(['Max. relative error for young=',num2str(ii),' is ',num2str(max(normS(ii,2000:end)))]);
%
% end


%% settings for figures
% generate legends
figure(hFig(1)); subplot(2,1,1);
hLeg = legend(leg{1,1:iCnt(1)-1});
set(hLeg,'Interpreter','none', 'Location','NorthEast');
title('Position and Velocity','Interpreter','none');
ylabel('position in m');

subplot(2,1,2);
xlabel('time in s');
ylabel('velocity in m/s');


figure(hFig(2));
hLeg = legend(leg{2,1:iCnt(2)-1});
set(hLeg,'Interpreter','none','Location','NorthEast');
title('Normal stress in z-direction (only servo wall)','Interpreter','none');
xlabel('time in s');
ylabel('sigma_{z} in Pa');


figure(hFig(3));
switch legendFlag
    case 'std'
        title('Shear stress in x-direction','Interpreter','none');
        xlabel('time in s');
        ylabel('tau_{xz} in Pa');
        hLeg = legend(leg{3,1:iCnt(3)-1});
        
    case 'latex'
        % latex legends
        title('title','Interpreter','none','FontSize',20);
        xlabel('xlabel','FontSize',20);%xlabel('timesteps');
        ylabel('ylabel','FontSize',20);
        hLeg = legend({'verylonglegend1','verylonglegend2','verylonglegend3','verylonglegend4'});%legend({'v_{wall} = 3.5 mm/s','v_{wall} = 7.0 mm/s','v_{wall} = 10.0 mm/s'});%
end
% position and style of legend
set(hLeg,'Interpreter','none','Location','SouthEast');


if (exp_flag)
    figure(hFig(4));
    hLeg = legend(leg{4,1:iCnt(4)-1});
    set(hLeg,'Interpreter','none','Location','SouthEast');
    title('Experimental shear stress in x-direction');
    xlabel('time in s');
    ylabel('tau_{xz} in Pa');
end




%if (exp_flag)
figure(hFig(5));

switch legendFlag
    case 'std'
        hLeg = legend(leg{5,1:iCnt(5)-1});
        
        title('Coefficient of internal friction. Ratio shear stress / normal stress','Interpreter','none');
        xlabel('time [s]');
        ylabel('\mu_{ie} [-]');
        
    case 'latex'
        % latex legends
        title('title');
        xlabel('xlabel');
        ylabel('ylabel');
        hLeg = legend('longlonglonglonglonglongleg01','longlonglonglonglonglongleg02','longlonglonglonglonglongleg03','longlonglonglonglonglongleg04','longlonglonglonglonglongleg05','longlonglonglonglonglongleg06','longlonglonglonglonglongleg07',...
            'longlonglonglonglonglongleg08','longlonglonglonglonglongleg09','longlonglonglonglonglongleg10','longlonglonglonglonglongleg11','longlonglonglonglonglongleg12'...
            ,'longlonglonglonglonglongleg13','longlonglonglonglonglongleg14','longlonglonglonglonglongleg15','longlonglonglonglonglongleg16');
        
    otherwise
        hLeg = legend(leg{5,1:iCnt(5)-1});
        set(hLeg,'Interpreter','none','Location','SouthEast');
        title('Coefficient of friction. Ratio shear stress / normal stress','Interpreter','none');
        xlabel('time in s');
        ylabel('mu_{f}');
        
        
end

set(hLeg,'Interpreter','none','Location','SouthEast');
%end

if (exp_flag) % figure 5 only in case of experimental data
    figure(hFig(6));
    % -- first plot --
    subplot(2,1,1);
    
    switch legendFlag
        case 'std'
            % standard legends
            title('Coefficient of friction. Ratio shear stress / normal stress','Interpreter','none');
            xlabel('time in s');
            %ylabel('mu_{f}');
            ylabel('F_s');
            hLeg = legend(leg{6,1:iCnt(6)-1});
            
        case 'latex'
            % latex legends
            title('title');
            xlabel('xlabel');
            ylabel('ylabel');
            hLeg = legend('longlongleg1','longlongleg2','longlongleg3','longlongleg4');
            
        otherwise
            hLeg = legend('mu = 0.05','mu = 0.1','mu = 0.2','mu = 0.3');
            set(hLeg,'Location','SouthEast');
            
    end
    
    % position and style of legend
    set(hLeg,'Interpreter','none','Location','SouthEast');
    
    % -- second plot --
    subplot(2,1,2);
    
    % standard legend
    %     xlabel('time in s');
    %     ylabel('mu_{f}');
    ylabel('F_s');
    
    hLeg = legend(['experiment - ',exp_file]);
    
    %hLeg = legend('Experimental data');
    
    % position and style of legend
    set(hLeg,'Interpreter','none','Location','SouthEast');
end


if (exp_flag)
    
    
end


%% save figures
if saveFlag
    
    switch legendFlag
        case 'latex'
            figure(hFig(7));
            hLeg = legend(leg{7,1:iCnt(7)-1});
            set(hLeg,'Interpreter','none','Location','SouthEast','FontSize',14);
            title('Coefficient of friction. Ratio shear stress / normal stress','Interpreter','none','FontSize',24);
            xlabel('time [s]','FontSize',24);
            ylabel('\mu [-]','FontSize',24);
            matlab2tikz( 'images/myfile.tikz' );
    end
    
    for ii=1:length(hFig)
        %saveas(hFig(ii),fullfile(saveDir,['figure',num2str(ii)]),'fig');
        %saveas(hFig(ii),fullfile(saveDir,['figure',num2str(ii)]),'tif');
        saveas(hFig(ii),fullfile(saveDir,['figure',num2str(ii)]),'png');
        saveas(hFig(ii),fullfile(saveDir,['figure',num2str(ii)]),'epsc');
    end
end
%
% for ii=1:length(data)
% name{ii,1} = data(ii).name; % ['trota'];%data(ii).name);
% end
%
% % musmean=musmean';
% % musmedian=musmedian';
%
% % for i=1:9 mus(i,2)=mus(i,1)-0.8796; end
% % for i=1:9 mus(i,2)=abs(mus(i,1)-0.8796); end
% % [a,b]=min(mus(:,2))

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
    
    
    if (exist('densityBulkBoxMean') & ~polidispersity_flag)
        %targetNN(iijj,3)=densityBulkBoxMean(iijj);
        %[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2, newY2] =   myNeuNetFun(nSimCases,data,trainFcn,hiddenLayerSizeVector, dataNN2, avgMuR2,avgMuR1, densityBulkBoxMean);
        [NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFun(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxMin);
        avgMuR2Pos = 9;
        avgMuR1Pos = 10;
        densityBulkBoxMeanPos = 11;
    elseif (exist('densityBulkBoxMean') & polidispersity_flag)
        [NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxMin);
        avgMuR2Pos = 9;
        avgMuR1Pos = 10;
        densityBulkBoxMeanPos = 11;
    else
        %[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2, newY2] =   myNeuNetFun(nSimCases,data,trainFcn,hiddenLayerSizeVector, dataNN2, avgMuR2,avgMuR1);
        [NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1);
        avgMuR2Pos = 8;
        avgMuR1Pos = 9;
    end
    
    
    %myNeuNetFun(nSimCases,data
    net=NNSave2{errorEstSumMaxIndex2(1),1}.net;
    %yy3=net(x2);
    %yy4(1,1,:)=yy3;
    %yy4-yy2(errorEstSumMaxIndex2,:,:) this should be zero
    net2=NNSave2{errorEstSumMaxIndex2(2),2}.net;
    %yy5=net(x2);
    %yy6(1,2,:)=yy5;
    
    if (newInputFlag)
        dataNN2.rest=[0.5:0.1:0.9];
        dataNN2.sf=[0.1:0.1:1];
        dataNN2.rf=[0.1:0.1:1];
        dataNN2.dt= 1e-6; %[1e-7:1e-7:1e-6];
        dataNN2.dCylDp= 20;%[20:1:50];
        dataNN2.ctrlStress = 1068;% [1068,2069,10070];
        dataNN2.shearperc = [0.4:0.2:1.0];
        if (exist('densityBulkBoxMean'))
            dataNN2.dens = [2000:100:3500];
            densTolerance = 0.05;
        end
        
        if (exp_flag)
            newY2 = myNewInput(NNSave2, errorEstSumMaxIndex2, dataNN2);
            [nY2rows,nY2column] = size(newY2);
            
            %% experimental confrontation 2
            
            switch legendExpFlag
                case 'schulze'
                    jjj=1;
                    kkk=1;
                    ii=1;
                    meanExpFtdRhoB = mean(expFtd.rhoB);
                    maxExpFtdRhoB  = max(expFtd.rhoB);
                    minExpFtdRhoB  = min(expFtd.rhoB);
                    for ii=1:nY2column
                        if (dataNN2.ctrlStress*1*.95 < expOut.sigmaAnM <dataNN2.ctrlStress*1*1.05)
                            
                            switch newY2(7,ii) %.shearperc %data(ii).shearperc
                                case 0.4
                                    newY2(nY2rows+1,ii) = newY2(avgMuR2Pos,ii)/coeffShear40; %   %data(ii).ratioShear = avgMuR2(ii)/...
                                    newY2(nY2rows+2,ii) =  newY2(avgMuR1Pos,ii)/expOut.coeffPreShear40 ;   %  data(ii).ratioPreShear  = avgMuR1(ii)/expOut.coeffPreShear40;
                                    newY2(nY2rows+3,ii) = expInp.tauAb40; %data(ii).tauAb = expInp.tauAb40;
                                    newY2(nY2rows+4,ii) = expOut.sigmaAb40; %data(ii).sigmaAb
                                    newY2(nY2rows+5,ii) = coeffShear40; %data(ii).coeffShear
                                    newY2(nY2rows+6,ii) = expOut.tauAbPr40; %data(ii).tauAbPr
                                    newY2(nY2rows+7,ii) = expOut.coeffPreShear40; %data(ii).coeffPreShear
                                    newY2(nY2rows+8,ii) = expOut.rhoB40;
                                    
                                case 0.6
                                    %                                     data(ii).ratioShear = avgMuR2(ii)/coeffShear60;
                                    %                                     data(ii).ratioPreShear = avgMuR1(ii)/expOut.coeffPreShear60;
                                    %                                     data(ii).tauAb = expInp.tauAb60;
                                    %                                     data(ii).sigmaAb = expOut.sigmaAb60;
                                    %                                     data(ii).coeffShear = coeffShear60;
                                    %                                     data(ii).tauAbPr = expOut.tauAbPr60;
                                    %                                     data(ii).coeffPreShear = expOut.coeffPreShear60;
                                    newY2(nY2rows+1,ii) = newY2(avgMuR2Pos,ii)/coeffShear60;
                                    newY2(nY2rows+2,ii) =  newY2(avgMuR1Pos,ii)/expOut.coeffPreShear60 ;
                                    newY2(nY2rows+3,ii) = expInp.tauAb60;
                                    newY2(nY2rows+4,ii) = expOut.sigmaAb60;
                                    newY2(nY2rows+5,ii) = coeffShear60;
                                    newY2(nY2rows+6,ii) = expOut.tauAbPr60;
                                    newY2(nY2rows+7,ii) = expOut.coeffPreShear60;
                                    newY2(nY2rows+8,ii) = expOut.rhoB60;
                                    
                                case 0.8
                                    %                                     data(ii).ratioShear = avgMuR2(ii)/coeffShear80;
                                    %                                     data(ii).ratioPreShear = avgMuR1(ii)/expOut.coeffPreShear80;
                                    %                                     data(ii).tauAb = expInp.tauAb80;
                                    %                                     data(ii).sigmaAb = expOut.sigmaAb80;
                                    %                                     data(ii).coeffShear = coeffShear80;
                                    %                                     data(ii).tauAbPr = expOut.tauAbPr80;
                                    %                                     data(ii).coeffPreShear = expOut.coeffPreShear80;
                                    newY2(nY2rows+1,ii) = newY2(avgMuR2Pos,ii)/coeffShear80;
                                    newY2(nY2rows+2,ii) =  newY2(avgMuR1Pos,ii)/expOut.coeffPreShear80 ;
                                    newY2(nY2rows+3,ii) = expInp.tauAb80;
                                    newY2(nY2rows+4,ii) = expOut.sigmaAb80;
                                    newY2(nY2rows+5,ii) = coeffShear80;
                                    newY2(nY2rows+6,ii) = expOut.tauAbPr80;
                                    newY2(nY2rows+7,ii) = expOut.coeffPreShear80;
                                    newY2(nY2rows+8,ii) = expOut.rhoB80;
                                    
                                case 1.0
                                    %                                     data(ii).ratioShear = avgMuR2(ii)/coeffShear100;
                                    %                                     data(ii).ratioPreShear = avgMuR1(ii)/expOut.coeffPreShear100;
                                    %                                     data(ii).tauAb = expInp.tauAb100;
                                    %                                     data(ii).sigmaAb = expOut.sigmaAb100;
                                    %                                     data(ii).coeffShear = coeffShear100;
                                    %                                     data(ii).tauAbPr = expOut.tauAbPr100;
                                    %                                     data(ii).coeffPreShear = expOut.coeffPreShear100;
                                    newY2(nY2rows+1,ii) = newY2(avgMuR2Pos,ii)/coeffShear100;
                                    newY2(nY2rows+2,ii) =  newY2(avgMuR1Pos,ii)/expOut.coeffPreShear100 ;
                                    newY2(nY2rows+3,ii) = expOut.tauAbPr100; %expInp.tauAb100;
                                    newY2(nY2rows+4,ii) = expOut.sigmaAnM;% expOut.sigmaAb100;
                                    newY2(nY2rows+5,ii) = coeffShear100;
                                    newY2(nY2rows+6,ii) = expOut.tauAbPr100;
                                    newY2(nY2rows+7,ii) = expOut.coeffPreShear100;
                                    newY2(nY2rows+8,ii) = expOut.rhoBAnM;
                            end
                            
                            if (exist('densityBulkBoxMean'))
                                nY2rowsBis = nY2rows+8;
                            else
                                nY2rowsBis = nY2rows+7;
                            end
                            %nY2rowsBis = length(newY2(:,ii));
                            %data(ii).deltaRatioShear = abs(1-data(ii).ratioShear);
                            newY2(nY2rowsBis+1,ii) =  abs(1- newY2(nY2rows+1,ii));
                            %data(ii).deltaRatioPreShear = abs(1-data(ii).ratioPreShear);
                            newY2(nY2rowsBis+2,ii) =  abs(1- newY2(nY2rows+2,ii));
                            
                            newY2(nY2rowsBis+3,ii) =  meanExpFtdRhoB;%mean(expFtd.rhoB);
                            newY2(nY2rowsBis+4,ii) =  maxExpFtdRhoB;%max(expFtd.rhoB);
                            newY2(nY2rowsBis+5,ii) =  minExpFtdRhoB;%min(expFtd.rhoB);
                            if (exist('densityBulkBoxMean'))
                                nY2rowsTris = nY2rowsBis+5;
                            else
                                nY2rowsTris = nY2rowsBis+2;
                            end
                            %nY2rowsTris = length(newY2(:,ii));
                            
                            
                            if (exist('densityBulkBoxMean') &  (newY2(nY2rowsBis+1,ii)<0.05) & (newY2(nY2rowsBis+2,ii)<0.05) &   (newY2(densityBulkBoxMeanPos,ii)<newY2(nY2rowsBis+4,ii)*(1.0+densTolerance))  ...
                                    &  (newY2(densityBulkBoxMeanPos,ii)>newY2(nY2rowsBis+5,ii)*(1.0-densTolerance)) )
                                gloriaAugustaSchulzeNNDens(1,kkk) = ii;
                                gloriaAugustaSchulzeNNDens(2:(nY2rowsTris+1), kkk) = newY2(1:end,ii) ;%avgMuR1(ii);
                                gloriaAugustaSchulzeNNDens(nY2rowsTris+2, kkk) = 1;
                                kkk=kkk+1;
                            elseif ((newY2(nY2rowsBis+1,ii)<0.05) & (newY2(nY2rowsBis+2,ii)<0.05)) %((data(ii).deltaRatioShear<0.05) & (data(ii).deltaRatioPreShear<0.05))
                                gloriaAugustaSchulzeNNnoDens(1,jjj) = ii;
                                gloriaAugustaSchulzeNNnoDens(2:(nY2rowsTris+1), jjj) = newY2(1:end,ii) ;%avgMuR1(ii);
                                gloriaAugustaSchulzeNNnoDens(nY2rowsTris+2, jjj) = 0;
                                %                                 gloriaAugustaSchulze{jjj,3} = avgMuR2(ii);
                                %                                 gloriaAugustaSchulze{jjj,4} = data(ii).tauAb;
                                %                                 gloriaAugustaSchulze{jjj,5} = data(ii).sigmaAb;
                                %                                 gloriaAugustaSchulze{jjj,6} = data(ii).coeffShear;
                                %                                 gloriaAugustaSchulze{jjj,7} = data(ii).ratioShear;
                                %                                 gloriaAugustaSchulze{jjj,8} = data(ii).deltaRatioShear;
                                %                                 gloriaAugustaSchulze{jjj,9} = data(ii).tauAbPr;
                                %                                 gloriaAugustaSchulze{jjj,10} = data(ii).coeffPreShear;
                                %                                 gloriaAugustaSchulze{jjj,11} = data(ii).ratioPreShear;
                                %                                 gloriaAugustaSchulze{jjj,12} = data(ii).deltaRatioPreShear;
                                jjj=jjj+1;
                            end
                        end
                    end
                    
                    gloriaAugustaSchulzeNN = gloriaAugustaSchulzeNNDens;
                    
                    [gASSNNrows,gASSNNcolumns] = size(gloriaAugustaSchulzeNN);
                    if (gloriaWinFlag)
                        best = find(gloriaAugustaSchulzeNN(8,:)==0.4);
                        %jjkk=1; %z
                        win = zeros(length(best),1);
                        lBest = length(best);
                        for jjj=1:lBest
                            %                     best2 = find(gloriaAugustaSchulzeNN(2,:)==gloriaAugustaSchulzeNN(2,best(jjj)));
                            %                     best3 = find(gloriaAugustaSchulzeNN(3,:)==gloriaAugustaSchulzeNN(3,best(jjj)));
                            %                     best4 = find(gloriaAugustaSchulzeNN(4,:)==gloriaAugustaSchulzeNN(4,best(jjj)));
                            %                     [Lia,Lib] = ismember(best2,best3);
                            %                     mmnn=1;
                            %                     for i=1:length(Lib)
                            %                         if Lib(i) ~= 0
                            %                             best5(mmnn)=Lib(i);
                            %                             mmnn=mmnn+1;
                            %                         end
                            %                     end
                            %
                            %                     best6=(best2(best5));
                            %                     [Lic,Lid] = ismember(best6,best4);
                            %
                            %                     mmnn=1;
                            %                     for i=1:length(Lid)
                            %                         if Lid(i) ~= 0
                            %                             best7(jjj,mmnn)=Lid(i);
                            %                             mmnn=mmnn+1;
                            %                         end
                            %                     end
                            for jjll=1:gASSNNcolumns
                                if  (exist('densityBulkBoxMean'))
                                    if gloriaAugustaSchulzeNN(2,jjll)==gloriaAugustaSchulzeNN(2,best(jjj)) & ...
                                            gloriaAugustaSchulzeNN(3,jjll)==gloriaAugustaSchulzeNN(3,best(jjj)) ...
                                            & gloriaAugustaSchulzeNN(4,jjll)==gloriaAugustaSchulzeNN(4,best(jjj)) ...
                                            & gloriaAugustaSchulzeNN(nY2rowsTris+2, jjll)==1
                                        switch gloriaAugustaSchulzeNN(8,jjll)
                                            case 0.6
                                                win(jjj)=1;
                                            case 0.8
                                                if win(jjj)==1
                                                    win(jjj)=win(jjj)+1;
                                                else
                                                    win(jjj)=1;
                                                end
                                            case 1.0
                                                if win(jjj)==2
                                                    win(jjj)=win(jjj)+1;
                                                elseif win(jjj)==1
                                                    win(jjj)=2;
                                                else
                                                    win(jjj)=1;
                                                end
                                        end
                                        % gloria2(jjj,jjkk)=jjll;
                                        % jjkk=jjkk+1;
                                    end
                                    %                        gloriaAugustaSchulzeNN(3,best(jjj))
                                    %                        gloriaAugustaSchulzeNN(4,best(jjj))
                                else
                                    if gloriaAugustaSchulzeNN(2,jjll)==gloriaAugustaSchulzeNN(2,best(jjj)) & ...
                                            gloriaAugustaSchulzeNN(3,jjll)==gloriaAugustaSchulzeNN(3,best(jjj)) ...
                                            & gloriaAugustaSchulzeNN(4,jjll)==gloriaAugustaSchulzeNN(4,best(jjj))
                                        switch gloriaAugustaSchulzeNN(8,jjll)
                                            case 0.6
                                                win(jjj)=1;
                                            case 0.8
                                                if win(jjj)==1
                                                    win(jjj)=win(jjj)+1;
                                                else
                                                    win(jjj)=1;
                                                end
                                            case 1.0
                                                if win(jjj)==2
                                                    win(jjj)=win(jjj)+1;
                                                elseif win(jjj)==1
                                                    win(jjj)=2;
                                                else
                                                    win(jjj)=1;
                                                end
                                        end
                                        % gloria2(jjj,jjkk)=jjll;
                                        % jjkk=jjkk+1;
                                    end
                                    
                                end
                            end
                        end
                        
                        gloriaWin(1,:) = gloriaAugustaSchulzeNN(2,[best(find(win==3))]);
                        gloriaWin(2,:) = gloriaAugustaSchulzeNN(3,[best(find(win==3))]);
                        gloriaWin(3,:) = gloriaAugustaSchulzeNN(4,[best(find(win==3))]);
                    end
            end
            
            X=gloriaAugustaSchulzeNN(3,:); %sf
            Y=gloriaAugustaSchulzeNN(4,:); %rf
            Z=gloriaAugustaSchulzeNN(9,:); %density
            S=gloriaAugustaSchulzeNN(2,:); %cor
            C=gloriaAugustaSchulzeNN(10,:);%avgMuR2
            figure(20)
            scatter3(S,X,Y,Z,C)
            
            %% radar plot
            P(1,:)=S;
            P(2,:)=X;
            P(3,:)=Y;
            P(4,:)=Z;
            P(5,:)=C;
            for i=1:20
                a(i)=randi([1, length(X)]);
            end
            b=sort(a)
            a1 = radarPlot( P(:,b))
            
            %%
            [mode2.M,mode2.F,mode2.C] = mode(gloriaAugustaSchulzeNN,2);
            restMat = zeros(gASSNNrows,mode2.F(2,1));
            for i=1:gASSNNrows
                restMat(i,:)=gloriaAugustaSchulzeNN(i,(find(gloriaAugustaSchulzeNN(2,:)==mode2.M(2,1))));
            end
            
            [mode3.M,mode3.F,mode3.C] = mode(restMat,2);
            [restMatrows,restMatcolumns] = size(restMat);
            fricMat = zeros(restMatrows,mode3.F(3,1));
            for i=1:restMatrows
                fricMat(i,:)=restMat(i,(find(restMat(3,:)==mode3.M(3,1))));
            end
            
            [mode4.M,mode4.F,mode4.C] = mode(fricMat,2);
            [fricMatrows,fricMatcolumns] = size(fricMat);
            for i=1:fricMatrows
                rfMat(i,:)=fricMat(i,(find(fricMat(4,:)==mode4.M(4,1))));
            end
            
        end
        
        
    end
    
end

% 
% clearvars jjj
% 
% figure(30)
% 
% for jjj = 1:nData
%    plot(data(jjj).timesteps,data(jjj).densityBulkBox,'Color',cmap(jjj,:));
%    hold on
%     
%     
%     
% end

%
% find(gloriaAugustaSchulzeNN(2,:)==0.9);
% find(gloriaAugustaSchulzeNN(2,:)==0.9)
% aa=find(gloriaAugustaSchulzeNN(2,:)==0.9);
% bb=find(gloriaAugustaSchulzeNN(3,:)==1);
% cc=find(gloriaAugustaSchulzeNN(4,:)==.1);
% Lia = ismember(aa,bb)
% Lia = ismember(aa,bb,cc)
% [Lia,Lib] = ismember(aa,bb,cc)
% [Lia,Lib] = ismember(aa,bb)
% for i=1:length(Lib)
% if Lib(i) ~= 0
% mmnn=1;
% for i=1:length(Lib)
% if Lib(i) ~= 0
% dd(mmnn)=Lib(i)
% mmnn=mmnn+1;
% end
% end
% ee=(aa(dd))
% [Lic,Lid] = ismember(ee,cc)
% cc

%% save matlab data
% i=1;
% j=1;
% [a,b]=size(searchCases);
%
% searchName{1} = 'an';
%
% for i=1:a
%        j=i+1;
%        searchName{j}=([searchName{i},searchCases{i,1},num2str(searchCases{i,2})]);
% end
%
% save(searchName{end});
