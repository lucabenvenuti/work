% 
% formatSpec = 'X is %4.2f meters or %8.3f mm\n';
% fprintf(formatSpec,A1,A2)

formatSpec = cell(19,4) 


fileID = fopen('exp.txt','w');

formatSpec{1,1} = '\\begin{tabular}{llcccc} \n \\hline \n & type  & SSC & SSC & AoR   & SSC \\& AoR \\\\ \n \\hline \n';

symbols = {'\\acs{mus}', '\\acs{mur}', '\\acs{CoR}', '\\acs{rhop}'};
formatSpec{1,2} = [symbols{1} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 4 columns
formatSpec{1,3} = '$(-)$ & std. dev. (SD) & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 4 columns
formatSpec{1,4} = ' & range (\\acs{R}) & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 4 columns
formatSpec{1,5} = ' & SD / R & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n \\hline \n'; % 4 columns

formatSpec{1,6} = [symbols{2} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 4 columns
formatSpec{1,10} = [symbols{3} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 4 columns
formatSpec{1,14} = [symbols{4} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 4 columns
formatSpec{1,18} = 'valid & number & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 4 columns
formatSpec{1,19} = 'combinations & (\\%%)  & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n \\hline \n'; % 4 columns


formatSpec{2,1} = '\\begin{tabular}{llccccc} \n \\hline \n & type  & SSC & SSC & SSC & AoR   & SSC \\& AoR \\\\ \n \\hline \n'; % 5 columns

formatSpec{2,2} = [symbols{1} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 5 columns
formatSpec{2,3} = '$(-)$ & std. dev. (SD) & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 5 columns
formatSpec{2,4} = ' & range (\\acs{R}) & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 5 columns
formatSpec{2,5} = ' & SD / R & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n \\hline \n'; % 5 columns

formatSpec{2,6} = [symbols{2} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 5 columns
formatSpec{2,10} = [symbols{3} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 5 columns
formatSpec{2,14} = [symbols{4} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 5 columns
formatSpec{2,18} = 'valid & number & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 5 columns
formatSpec{2,19} = 'combinations & (\\%%)  & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n \\hline \n'; % 5 columns


formatSpec{3,1} = '\\begin{tabular}{llcccccc} \n \\hline \n & type  & SSC & SSC & SSC & SSC & AoR   & SSC \\& AoR \\\\ \n \\hline \n'; % 6 columns

formatSpec{3,2} = [symbols{1} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 6 columns
formatSpec{3,3} = '$(-)$ & std. dev. (SD) & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 6 columns
formatSpec{3,4} = ' & range (\\acs{R}) & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 6 columns
formatSpec{3,5} = ' & SD / R & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n \\hline \n'; % 6 columns

formatSpec{3,6} = [symbols{2} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 6 columns
formatSpec{3,10} = [symbols{3} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 6 columns
formatSpec{3,14} = [symbols{4} , ' & mean & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n']; % 6 columns
formatSpec{3,18} = 'valid & number & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n'; % 6 columns
formatSpec{3,19} = 'combinations & (\\%%)  & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f & %4.3f \\\\ \n \\hline \n'; % 6 columns



formatSpec{:,7} = formatSpec{:,3};
formatSpec{:,8} = formatSpec{:,4};
formatSpec{:,9} = formatSpec{:,5};


formatSpec{:,11} = formatSpec{:,3};
formatSpec{:,12} = formatSpec{:,4};
formatSpec{:,13} = formatSpec{:,5};


formatSpec{:,15} = formatSpec{:,3};
formatSpec{:,16} = formatSpec{:,4};
formatSpec{:,17} = formatSpec{:,5};




fprintf(fileID, formatSpec{1,1});


for j = 1 : 18
    fprintf(fileID, formatSpec{1, j + 1},finTable{1}(j,:));
end
% fprintf(fileID, formatSpec{1,2},finTable{1}(1,:));
% fprintf(fileID, formatSpec{1,3},finTable{1}(2,:));
% fprintf(fileID, formatSpec{1,4},finTable{1}(3,:));
% fprintf(fileID, formatSpec{1,5},finTable{1}(4,:));



fclose(fileID);







% 
% 
% 
%     
%     $(-)$   & std. dev. (SD) & 0.097 & 0.095 & 0.029 \\
%           & range (\acs{R}) & 0.9   & 0.9   & 0.9 \\
%           & SD / R & 0.108 & 0.106 & 0.032 \\
%           \hline
%     \acs{mur} & mean  & 0.692 & 0.830 & 0.916 \\
%     $(-)$   & std. dev. (SD) & 0.215 & 0.193 & 0.042 \\
%           & range (\acs{R}) & 0.9   & 0.9   & 0.9 \\
%           & SD / R & 0.239 & 0.214 & 0.046 \\
%           \hline
%               COR   & mean  & 0.708 & 0.590 & 0.590 \\
%     $(-)$   & std. dev. (SD) & 0.104 & 0.073 & 0.065 \\
%           & range (\acs{R}) & 0.4   & 0.4   & 0.4 \\
%           & SD / R & 0.259 & 0.183 & 0.161 \\
%           \hline
%     \acs{rhop} & mean  & 2245.7 & 3192.8 & 2283.9 \\
%     $(kg/m^3)$ & std. dev. (SD) & 80.5  & 277.4 & 67.1 \\
%           & range (\acs{R}) & 1500  & 1500  & 1500 \\
%           & SD / R & 0.054 & 0.185 & 0.045 \\
%           \hline
%     valid & number & 290203 & 816552 & 3884 \\
%     combinations & (\%) & 4.64  & 13.06 & 0.06 \\