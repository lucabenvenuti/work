function [expTime] = importFTD( exp_file2 )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

                    delimiter = ';';
                    startRow = 20;

                    formatSpec = '%f%f%f%f%[^\n\r]';

                    % Open the text file.
                    fileID = fopen(exp_file2,'r');

                    % Read columns of data according to format string.
                    % This call is based on the structure of the file used to generate this
                    % code. If an error occurs for a different file, try regenerating the code
                    % from the Import Tool.
                    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);

                    % Close the text file.
                    fclose(fileID);

                    % Post processing for unimportable data.
                    % No unimportable data rules were applied during the import, so no post
                    % processing code is included. To generate code which works for
                    % unimportable data, select unimportable cells in a file and regenerate the
                    % script.

                    % Allocate imported array to column variable names
                    expTime.time = dataArray{:, 1};
                    expTime.tau = dataArray{:, 2};
                    expTime.dH = dataArray{:, 3};
                    expTime.rhoB = dataArray{:, 4};
                    
                                        % Clear temporary variables
                    clearvars filename delimiter startRow formatSpec fileID dataArray ans;


end

