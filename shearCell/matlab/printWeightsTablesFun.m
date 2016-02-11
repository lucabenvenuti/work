function a = printWeightsTablesFun( NNSaveNeuronsWinner, titleTest, bulkParameter )
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here

IWM = NNSaveNeuronsWinner.IWM';
LWM = NNSaveNeuronsWinner.LWM';
biasInput = NNSaveNeuronsWinner.biasInput';
biasOutput = NNSaveNeuronsWinner.biasOutput;

[rows, columns] = size(IWM);

formatSpec = cell(2, 9 + rows);


formatSpec00 = '\\begin{table}[htbp] \n \\centering \n';
formatSpec01 = '\\hline \n \\end{tabular} \n';
formatSpec02 = '\\end{table}';


formatSpec{1,1} = '\\begin{tabular}{l|ccccccccc} \n \\hline \n   &    \\multicolumn{9}{l}{Weights of connection between input and hidden layer}  \\\\ \n'; % 9 columns


formatSpec{1,2} = ' Neurons & 1 &  2 &  3 &  4 &  5 &  6 &  7 &  8 & 9 \\\\ \n \\hline \n'; % 9 columns
formatSpec{1,3} = '  & %4.3f &  %4.3f &  %4.3f &  %4.3f &  %4.3f &  %4.3f &  %4.3f &  %4.3f &  %4.3f \\\\ \n'; % 9 columns
formatSpec{1, 4 + rows} = '\\hline \n   &    \\multicolumn{9}{l}{Weights of connection between hidden and output layer}  \\\\ \n'; % 9 columns
formatSpec{1, 5 + rows} = formatSpec{1,3};
formatSpec{1, 6 + rows} = '\\hline \n   &    \\multicolumn{9}{l}{Biases of hidden layer}  \\\\ \n'; % 9 columns
formatSpec{1, 7 + rows} = formatSpec{1,3};
formatSpec{1, 8 + rows} = '\\hline \n   &    \\multicolumn{9}{l}{Biases of output layer}  \\\\ \n'; % 9 columns
formatSpec{1, 9 + rows} = ' &    \\multicolumn{9}{c}{%4.3f}  \\\\ \n'; % 9 columns




% formatSpec{2,1} = '\\begin{tabular}{ll|ccccc} \n \\hline \n &    & SSC & SSC & SSC & AoR   & SSC \\& AoR \\\\ \n'; % 5 columns
% formatSpec{2,2} = ' & $\\sigma_n$  [Pa]  & 1000 & 2000 & 5000 &   &  \\\\ \n \\hline \n';
% formatSpec{2,3} = [symbols{1} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 5 columns
% formatSpec{2,4} = '$(-)$ & std. dev. (SD) & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 5 columns
% formatSpec{2,5} = ' & range (\\acs{R}) & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 5 columns
% formatSpec{2,6} = ' & SD / R & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n \\hline \n'; % 5 columns
%
% formatSpec{2,7} = [symbols{2} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 5 columns
% formatSpec{2,11} = [symbols{3} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 5 columns
% formatSpec{2,15} = [symbols{4} , ' & mean & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n']; % 5 columns
% formatSpec{2,16} = '$(-)$ & std. dev. (SD) & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n'; % 5 columns
% formatSpec{2,17} = ' & range (\\acs{R}) & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n'; % 5 columns
% formatSpec{2,18} = ' & SD / R & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n \\hline \n'; % 5 columns
% formatSpec{2,19} = 'valid & number & %4.0f & %4.0f & %4.0f & %4.0f & %4.0f \\\\ \n'; % 5 columns
% formatSpec{2,20} = 'combinations & (\\%%)  & %3.2f & %3.2f & %3.2f & %3.2f & %3.2f \\\\ \n \\hline \n'; % 5 columns


for m = 1:rows
    formatSpec{1, 3 + m} = formatSpec{1,3};
end

% for n = 1: length(finTable)

% fileName{n} = titleTest;
fileID = fopen([titleTest,'.tex'], 'w');

% [~, columns] = size(finTable{n});

if columns == 9
    fSN = 1;
end
fprintf(fileID, formatSpec00);
fprintf(fileID, formatSpec{fSN,1});
fprintf(fileID, formatSpec{fSN,2});

%[~, columns2] = size(formatSpec);
for j = 1 : rows
    fprintf(fileID, formatSpec{fSN, j + 3}, IWM(j,:));
end

fprintf(fileID, formatSpec{fSN, 4 + rows});
fprintf(fileID, formatSpec{fSN, 5 + rows}, LWM);
fprintf(fileID, formatSpec{fSN, 6 + rows});
fprintf(fileID, formatSpec{fSN, 5 + rows}, biasInput);
fprintf(fileID, formatSpec{fSN, 8 + rows});
fprintf(fileID, formatSpec{fSN, 9 + rows}, biasOutput);


fprintf(fileID, formatSpec01);
fprintf(fileID, ['\\caption[Weights and biases table for ', bulkParameter, ']{Weights and biases table for ', bulkParameter, '.} \n']);
fprintf(fileID, ['\\label{tab:', titleTest, '} \n']);
fprintf(fileID, formatSpec02);
fclose(fileID);

a = 1;

% end

end