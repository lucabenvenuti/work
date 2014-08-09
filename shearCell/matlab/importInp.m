function expForce = importInp(filename)
%IMPORTFILE Import numeric data from a text file as a matrix.
%   COAL0315TEST02 = IMPORTFILE(FILENAME) Reads data from text file
%   FILENAME for the default selection.
%
%   COAL0315TEST02 = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data from
%   rows STARTROW through ENDROW of text file FILENAME.
%
% Example:
%   coal0315test02 = importfile('20131129_1356_coal0-315_test02.inp', 9,
%   13);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2014/04/07 16:35:06, startRow, endRow

%% Initialize variables.
startRow = 9;
endRow = 13;
delimiter = ' ';
if nargin<=2
    startRow = 9;
    endRow = inf;
end

%% Format string for each line of text:
%   column6: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%*s%*s%*s%*s%f%*s%*s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'EmptyValue' ,NaN,'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'EmptyValue' ,NaN,'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    dataArray{1} = [dataArray{1};dataArrayBlock{1}];
end

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
 matrix2 = [dataArray{1:end-1}];
 
 expForce.Sab40 = matrix2(1);
 expForce.Sab60 = matrix2(3);
 expForce.Sab80 = matrix2(5);
 
 expForce.areaShearCell = 0.001494444071421;
 
 expForce.tauAb40 = expForce.Sab40/expForce.areaShearCell;
 expForce.tauAb60 = expForce.Sab60/expForce.areaShearCell;
 expForce.tauAb80 = expForce.Sab80/expForce.areaShearCell;
 
 %exp.coeffShear40 = exp.tauAn40/exp.sigmaAb40;
%0.001494444071421
end
