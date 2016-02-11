%
% formatSpec = 'X is %4.2f meters or %8.3f mm\n';
% fprintf(formatSpec,A1,A2)

formatSpec = cell(4,19);


formatSpec00 = '\\begin{table}[htbp] \n \\centering \n';
formatSpec01 = '\\end{tabular} \n';
formatSpec02 = '\\end{table}';

formatSpec{1,1} = '\\begin{tabular}{ll|cccc} \n \\hline \n & type  & SSC & SSC & AoR   & SSC \\& AoR \\\\ \n \\hline \n';

symbols = {'\\acs{mus}', '\\acs{mur}', '\\acs{CoR}', '\\acs{rhop}'};
formatSpec{1,2} = [symbols{1} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 4 columns
formatSpec{1,3} = '$(-)$ & std. dev. (SD) & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 4 columns
formatSpec{1,4} = ' & range (\\acs{R}) & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 4 columns
formatSpec{1,5} = ' & SD / R & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n \\hline \n'; % 4 columns

formatSpec{1,6} = [symbols{2} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 4 columns
formatSpec{1,10} = [symbols{3} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 4 columns
formatSpec{1,14} = [symbols{4} , ' & mean & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n']; % 4 columns
formatSpec{1,15} = '$(-)$ & std. dev. (SD) & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n'; % 4 columns
formatSpec{1,16} = ' & range (\\acs{R}) & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n'; % 4 columns
formatSpec{1,17} = ' & SD / R & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n \\hline \n'; % 4 columns
formatSpec{1,18} = 'valid & number & %4.0f & %4.0f & %4.0f & %4.0f \\\\ \n'; % 4 columns
formatSpec{1,19} = 'combinations & (\\%%)  & %3.2f & %3.2f & %3.2f & %3.2f \\\\ \n \\hline \n'; % 4 columns


formatSpec{2,1} = '\\begin{tabular}{llccccc} \n \\hline \n & type  & SSC & SSC & SSC & AoR   & SSC \\& AoR \\\\ \n \\hline \n'; % 5 columns

formatSpec{2,2} = [symbols{1} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 5 columns
formatSpec{2,3} = '$(-)$ & std. dev. (SD) & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 5 columns
formatSpec{2,4} = ' & range (\\acs{R}) & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 5 columns
formatSpec{2,5} = ' & SD / R & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n \\hline \n'; % 5 columns

formatSpec{2,6} = [symbols{2} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 5 columns
formatSpec{2,10} = [symbols{3} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 5 columns
formatSpec{2,14} = [symbols{4} , ' & mean & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n']; % 5 columns
formatSpec{2,15} = '$(-)$ & std. dev. (SD) & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n'; % 5 columns
formatSpec{2,16} = ' & range (\\acs{R}) & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n'; % 5 columns
formatSpec{2,17} = ' & SD / R & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n \\hline \n'; % 5 columns
formatSpec{2,18} = 'valid & number & %4.0f & %4.0f & %4.0f & %4.0f & %4.0f \\\\ \n'; % 5 columns
formatSpec{2,19} = 'combinations & (\\%%)  & %3.2f & %3.2f & %3.2f & %3.2f & %3.2f \\\\ \n \\hline \n'; % 5 columns


formatSpec{3,1} = '\\begin{tabular}{llcccccc} \n \\hline \n & type  & SSC & SSC & SSC & SSC & AoR   & SSC \\& AoR \\\\ \n \\hline \n'; % 6 columns

formatSpec{3,2} = [symbols{1} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 6 columns
formatSpec{3,3} = '$(-)$ & std. dev. (SD) & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 6 columns
formatSpec{3,4} = ' & range (\\acs{R}) & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 6 columns
formatSpec{3,5} = ' & SD / R & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n \\hline \n'; % 6 columns

formatSpec{3,6} = [symbols{2} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 6 columns
formatSpec{3,10} = [symbols{3} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 6 columns
formatSpec{3,14} = [symbols{4} , ' & mean & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n']; % 6 columns
formatSpec{3,15} = '$(-)$ & std. dev. (SD) & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n'; % 6 columns
formatSpec{3,16} = ' & range (\\acs{R}) & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n'; % 6 columns
formatSpec{3,17} = ' & SD / R & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n \\hline \n'; % 6 columns
formatSpec{3,18} = 'valid & number & %4.0f & %4.0f & %4.0f & %4.0f & %4.0f & %4.0f \\\\ \n'; % 6 columns
formatSpec{3,19} = 'combinations & (\\%%)  & %3.2f & %3.2f & %3.2f & %3.2f & %3.2f & %3.2f \\\\ \n \\hline \n'; % 6 columns

formatSpec{4,1} = '\\begin{tabular}{llccccccc} \n \\hline \n & type  & SSC & SSC & SSC & SSC & SSC & AoR   & SSC \\& AoR \\\\ \n \\hline \n'; % 7 columns

formatSpec{4,2} = [symbols{1} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 7 columns
formatSpec{4,3} = '$(-)$ & std. dev. (SD) & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 7 columns
formatSpec{4,4} = ' & range (\\acs{R}) & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 7 columns
formatSpec{4,5} = ' & SD / R & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n \\hline \n'; % 7 columns

formatSpec{4,6} = [symbols{2} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 7 columns
formatSpec{4,10} = [symbols{3} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 7 columns
formatSpec{4,14} = [symbols{4} , ' & mean & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n']; % 7 columns
formatSpec{4,15} = '$(-)$ & std. dev. (SD) & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n'; % 7 columns
formatSpec{4,16} = ' & range (\\acs{R}) & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n'; % 7 columns
formatSpec{4,17} = ' & SD / R & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f & %4.1f \\\\ \n \\hline \n'; % 7 columns
formatSpec{4,18} = 'valid & number & %4.0f & %4.0f & %4.0f & %4.0f & %4.0f & %4.0f & %4.0f \\\\ \n'; % 7 columns
formatSpec{4,19} = 'combinations & (\\%%)  & %3.2f & %3.2f & %3.2f & %3.2f & %3.2f & %3.2f & %3.2f \\\\ \n \\hline \n'; % 7 columns


for m = 1:4
    formatSpec{m,7} = formatSpec{m,3};
    formatSpec{m,8} = formatSpec{m,4};
    formatSpec{m,9} = formatSpec{m,5};
    formatSpec{m,11} = formatSpec{m,3};
    formatSpec{m,12} = formatSpec{m,4};
    formatSpec{m,13} = formatSpec{m,5};
end


for n = 1: length(finTable)
    
    fileName{n} = [num2str( n + 24), 'DEMvalidvalues', finList{n,1}];
    fileID = fopen([fileName{n},'.tex'], 'w');
    
    [rows, columns] = size(finTable{n});
    fSN = columns - 3;
    fprintf(fileID, formatSpec00);
    fprintf(fileID, formatSpec{fSN,1});
    for j = 1 : 18
        fprintf(fileID, formatSpec{fSN, j + 1},finTable{n}(j,:));
    end
    
    fprintf(fileID, formatSpec01);
    fprintf(fileID, ['\\caption[Valid DEM values for ', finList{n,1}, ']{Valid DEM values for ', finList{n,1}, '. For each parameter we show the ',...
        'valid parameter statistics in the the tests and in their intersection. ', ...
        'Finally, we show the number of valid parameter combinations over the total (%7.0f).} \n'], totComb);    
    fprintf(fileID, ['\\label{tab:', fileName{n}, '} \n']);
    fprintf(fileID, formatSpec02);
    fclose(fileID);
    
end
% 
% \caption[Valid DEM values]{Valid DEM values. For each parameter we show the
% valid parameter statistics in the two tests and in their intersection.
% Finally, we show the number of valid parameter combinations over the total
% (6250000).}
% \label{tab:13DEMvalidvalues}
% \end{table}