function exp = importOut(filename)
%IMPORTFILE Import numeric data from a text file as a matrix.
%   COAL0315TEST02 = IMPORTFILE(FILENAME) Reads data from text file
%   FILENAME for the default selection.
%
%   COAL0315TEST02 = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data from
%   rows STARTROW through ENDROW of text file FILENAME.
%
% Example:
%   coal0315test02 = importfile('20131129_1356_coal0-315_test02.out', 8,
%   21);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2014/04/07 15:46:02, startRow, endRow

%% Initialize variables.
startRow = 8;
endRow = 21;
delimiter = ' ';
if nargin<=2
    startRow = 8;
    endRow = 21;
end

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%s%s%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
textscan(fileID, '%[^\n\r]', startRow(1)-1, 'ReturnOnError', false);
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    textscan(fileID, '%[^\n\r]', startRow(block)-1, 'ReturnOnError', false);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2,3,4,5,6,7,8]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end


%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
matrix = cell2mat(raw);


exp.sigmaAnM = matrix(1,3);
exp.tauAnM = matrix(2,3);
exp.rhoBAnM = matrix(5,3);

exp.Dh40 = matrix(12,4);
exp.Dh60 = matrix(13,4);
exp.Dh80 = matrix(14,4);
exp.Dh100 = 0;

exp.rhoB40 = matrix(12,5);
exp.rhoB60 = matrix(13,5);
exp.rhoB80 = matrix(14,5);
exp.rhoB100 = exp.rhoBAnM;

exp.tauAn40 = matrix(12,6);
exp.tauAn60 = matrix(13,6);
exp.tauAn80 = matrix(14,6);
exp.tauAn100 = exp.tauAnM;

exp.sigmaAb40 = matrix(12,7);
exp.sigmaAb60 = matrix(13,7);
exp.sigmaAb80 = matrix(14,7);
exp.sigmaAb100 = exp.sigmaAnM;

exp.tauAbPr40 = matrix(12,8);
exp.tauAbPr60 = matrix(13,8);
exp.tauAbPr80 = matrix(14,8);
exp.tauAbPr100 = exp.tauAnM;

exp.coeffPreShear40 = exp.tauAbPr40/exp.sigmaAb40;
exp.coeffPreShear60 = exp.tauAbPr60/exp.sigmaAb60;
exp.coeffPreShear80 = exp.tauAbPr80/exp.sigmaAb80;
exp.coeffPreShear100 = exp.tauAnM/exp.sigmaAnM;
exp.coeffShear100 = exp.coeffPreShear100;
exp.filename = filename;

end
