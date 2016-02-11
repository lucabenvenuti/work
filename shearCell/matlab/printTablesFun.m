function a = printTablesFun( finTable, finList, totComb )
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here


formatSpec = cell(4,20);


formatSpec00 = '\\begin{table}[htbp] \n \\centering \n';
formatSpec01 = '\\end{tabular} \n';
formatSpec02 = '\\end{table}';

symbols = {'\\acs{mus}', '\\acs{mur}', '\\acs{CoR}', '\\acs{rhop}'};

formatSpec{1,1} = '\\begin{tabular}{ll|cccc} \n \\hline \n &    & SSC & SSC & AoR   & SSC \\& AoR \\\\ \n';
formatSpec{1,2} = ' & $\\sigma_n$  [Pa]  & 1000 & 2000 &    &  \\\\ \n \\hline \n';
formatSpec{1,3} = [symbols{1} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 4 columns
formatSpec{1,4} = '$(-)$ & std. dev. (SD) & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 4 columns
formatSpec{1,5} = ' & range (\\acs{R}) & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 4 columns
formatSpec{1,6} = ' & SD / R & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n \\hline \n'; % 4 columns

formatSpec{1,7} = [symbols{2} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 4 columns
formatSpec{1,11} = [symbols{3} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 4 columns
formatSpec{1,15} = [symbols{4} , ' & mean & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n']; % 4 columns
formatSpec{1,16} = '$(-)$ & std. dev. (SD) & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n'; % 4 columns
formatSpec{1,17} = ' & range (\\acs{R}) & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n'; % 4 columns
formatSpec{1,18} = ' & SD / R & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n \\hline \n'; % 4 columns
formatSpec{1,19} = 'valid & number & %4.0f & %4.0f & %4.0f & %4.0f \\\\ \n'; % 4 columns
formatSpec{1,20} = 'combinations & (\\%%)  & %3.2f & %3.2f & %3.2f & %3.2f \\\\ \n \\hline \n'; % 4 columns


formatSpec{2,1} = '\\begin{tabular}{ll|ccccc} \n \\hline \n &    & SSC & SSC & SSC & AoR   & SSC \\& AoR \\\\ \n'; % 5 columns
formatSpec{2,2} = ' & $\\sigma_n$  [Pa]  & 1000 & 2000 & 5000 &   &  \\\\ \n \\hline \n';
formatSpec{2,3} = [symbols{1} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 5 columns
formatSpec{2,4} = '$(-)$ & std. dev. (SD) & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 5 columns
formatSpec{2,5} = ' & range (\\acs{R}) & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 5 columns
formatSpec{2,6} = ' & SD / R & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n \\hline \n'; % 5 columns

formatSpec{2,7} = [symbols{2} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 5 columns
formatSpec{2,11} = [symbols{3} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 5 columns
formatSpec{2,15} = [symbols{4} , ' & mean & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n']; % 5 columns
formatSpec{2,16} = '$(-)$ & std. dev. (SD) & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n'; % 5 columns
formatSpec{2,17} = ' & range (\\acs{R}) & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n'; % 5 columns
formatSpec{2,18} = ' & SD / R & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n \\hline \n'; % 5 columns
formatSpec{2,19} = 'valid & number & %4.0f & %4.0f & %4.0f & %4.0f & %4.0f \\\\ \n'; % 5 columns
formatSpec{2,20} = 'combinations & (\\%%)  & %3.2f & %3.2f & %3.2f & %3.2f & %3.2f \\\\ \n \\hline \n'; % 5 columns


formatSpec{3,1} = '\\begin{tabular}{ll|cccccc} \n \\hline \n &    & SSC & SSC & SSC & SSC & AoR   & SSC \\& AoR \\\\ \n'; % 6 columns
formatSpec{3,2} = ' & $\\sigma_n$  [Pa]  & 1000 & 2000 & 5000 & 10000 &   &  \\\\ \n \\hline \n';
formatSpec{3,3} = [symbols{1} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 6 columns
formatSpec{3,4} = '$(-)$ & std. dev. (SD) & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 6 columns
formatSpec{3,5} = ' & range (\\acs{R}) & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 6 columns
formatSpec{3,6} = ' & SD / R & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n \\hline \n'; % 6 columns

formatSpec{3,7} = [symbols{2} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 6 columns
formatSpec{3,11} = [symbols{3} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 6 columns
formatSpec{3,15} = [symbols{4} , ' & mean & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n']; % 6 columns
formatSpec{3,16} = '$(-)$ & std. dev. (SD) & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n'; % 6 columns
formatSpec{3,17} = ' & range (\\acs{R}) & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n'; % 6 columns
formatSpec{3,18} = ' & SD / R & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n \\hline \n'; % 6 columns
formatSpec{3,19} = 'valid & number & %4.0f & %4.0f & %4.0f & %4.0f & %4.0f & %4.0f \\\\ \n'; % 6 columns
formatSpec{3,20} = 'combinations & (\\%%)  & %3.2f & %3.2f & %3.2f & %3.2f & %3.2f & %3.2f \\\\ \n \\hline \n'; % 6 columns

formatSpec{4,1} = '\\begin{tabular}{ll|ccccccc} \n \\hline \n &    & SSC & SSC & SSC & SSC & SSC & AoR   & SSC \\& AoR \\\\ \n \\hline \n'; % 7 columns
formatSpec{4,2} = ' & $\\sigma_n$  [Pa]  & 1000 & 2000 & 5000 & 10000 & 15000 &  &  \\\\ \n \\hline \n';
formatSpec{4,3} = [symbols{1} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 7 columns
formatSpec{4,4} = '$(-)$ & std. dev. (SD) & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 7 columns
formatSpec{4,5} = ' & range (\\acs{R}) & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 7 columns
formatSpec{4,6} = ' & SD / R & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n \\hline \n'; % 7 columns

formatSpec{4,7} = [symbols{2} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 7 columns
formatSpec{4,11} = [symbols{3} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 7 columns
formatSpec{4,15} = [symbols{4} , ' & mean & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n']; % 7 columns
formatSpec{4,16} = '$(-)$ & std. dev. (SD) & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n'; % 7 columns
formatSpec{4,17} = ' & range (\\acs{R}) & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n'; % 7 columns
formatSpec{4,18} = ' & SD / R & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n \\hline \n'; % 7 columns
formatSpec{4,19} = 'valid & number & %4.0f & %4.0f & %4.0f & %4.0f & %4.0f & %4.0f & %4.0f \\\\ \n'; % 7 columns
formatSpec{4,20} = 'combinations & (\\%%)  & %3.2f & %3.2f & %3.2f & %3.2f & %3.2f & %3.2f & %3.2f \\\\ \n \\hline \n'; % 7 columns


for m = 1:4
    formatSpec{m,8} = formatSpec{m,4};
    formatSpec{m,9} = formatSpec{m,5};
    formatSpec{m,10} = formatSpec{m,6};
    formatSpec{m,12} = formatSpec{m,4};
    formatSpec{m,13} = formatSpec{m,5};
    formatSpec{m,14} = formatSpec{m,6};
end

for n = 1: length(finTable)
    
    fileName{n} = [num2str( n + 24), 'DEMvalidvalues', finList{n,1}];
    fileID = fopen([fileName{n},'.tex'], 'w');
    
    [~, columns] = size(finTable{n});
    fSN = columns - 3;
    fprintf(fileID, formatSpec00);
    fprintf(fileID, formatSpec{fSN,1});
    fprintf(fileID, formatSpec{fSN,2});
    
    [~, columns2] = size(formatSpec);
    for j = 1 : (columns2 - 2)
        fprintf(fileID, formatSpec{fSN, j + 2},finTable{n}(j,:));
    end
    
    fprintf(fileID, formatSpec01);
    fprintf(fileID, ['\\caption[Valid DEM values for ', finList{n,1}, ']{Valid DEM values for ', finList{n,1}, '. For each parameter we show the \n',...
        'valid parameter statistics in the the tests and in their intersection. \n', ...
        'Finally, we show the number of valid parameter combinations over the total (%7.0f).} \n'], totComb);
    fprintf(fileID, ['\\label{tab:', fileName{n}, '} \n']);
    fprintf(fileID, formatSpec02);
    fclose(fileID);
    
    a = 1;
    
end

end