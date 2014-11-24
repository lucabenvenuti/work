% Example input: 
% matrix = [1.5 1.764; 3.523 0.2]; 
% rowLabels = {'row 1', 'row 2'}; 
% columnLabels = {'col 1', 'col 2'}; 
% matrix2latex(matrix, 'out.tex', 'rowLabels', rowLabels, 'columnLabels', columnLabels, 'alignment', 'c', 'format', '%-6.2f', 'size', 'tiny'); 

matrix = corrMat2.corrMat;
rowLabels = {'sf', 'rf','rest', 'dt','dCylDp', 'ctrlStress','shearperc', 'dens','\mu_{sh}', '\mu_{psh}','\rho_b'}; 
columnLabels = {'sf', 'rf','rest', 'dt','dCylDp', 'ctrlStress','shearperc', 'dens','\mu_{sh}', '\mu_{psh}','\rho_b'}; 
matrix2latex(matrix, '06inputRelationshipTable.tex', 'rowLabels', rowLabels, 'columnLabels', columnLabels, 'alignment', 'c');%, 'format', '%-6.2f', 'size', 'tiny'); 