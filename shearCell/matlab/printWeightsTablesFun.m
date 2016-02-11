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

formatSpec{2,1} = '\\begin{tabular}{l|ccccccccccccccc} \n \\hline \n   &    \\multicolumn{15}{l}{Weights of connection between input and hidden layer}  \\\\ \n'; % 9 columns
formatSpec{2,2} = ' Neurons & 1 &  2 &  3 &  4 &  5 &  6 &  7 &  8 & 9 & 10 & 11 & 12 & 13 & 14 & 15  \\\\ \n \\hline \n'; % 9 columns
formatSpec{2,3} = '  & %4.3f &  %4.3f &  %4.3f &  %4.3f &  %4.3f &  %4.3f &  %4.3f &  %4.3f &  %4.3f  &  %4.3f &  %4.3f &  %4.3f &  %4.3f &  %4.3f &  %4.3f \\\\ \n'; % 9 columns
formatSpec{2, 4 + rows} = '\\hline \n   &    \\multicolumn{15}{l}{Weights of connection between hidden and output layer}  \\\\ \n'; % 9 columns
formatSpec{2, 5 + rows} = formatSpec{2,3};
formatSpec{2, 6 + rows} = '\\hline \n   &    \\multicolumn{15}{l}{Biases of hidden layer}  \\\\ \n'; % 9 columns
formatSpec{2, 7 + rows} = formatSpec{2,3};
formatSpec{2, 8 + rows} = '\\hline \n   &    \\multicolumn{15}{l}{Biases of output layer}  \\\\ \n'; % 9 columns
formatSpec{2, 9 + rows} = ' &    \\multicolumn{15}{c}{%4.3f}  \\\\ \n'; % 9 columns




for m = 1:rows
    formatSpec{1, 3 + m} = formatSpec{1,3};
    formatSpec{2, 3 + m} = formatSpec{2,3};
end

fileID = fopen([titleTest,'.tex'], 'w');

if columns == 9
    fSN = 1;
elseif columns == 15
    fSN = 2;
else
    a = 0;
    return;
end
fprintf(fileID, formatSpec00);
fprintf(fileID, formatSpec{fSN,1});
fprintf(fileID, formatSpec{fSN,2});

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

end