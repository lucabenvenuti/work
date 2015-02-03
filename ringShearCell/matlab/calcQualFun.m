function [returnVal] = calcQualFun(measFile)

# import measuremt data
run(measFile)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
diffAll = 0;
file1=['FP1.txt'];
file2=['FP2.txt'];
file3=['FP3.txt'];
data1 = loaddata(file1,1,1);
data2 = findNextMaximum('.',file2);
data3 = loaddata(file3,1,1);
diff1 = abs(data1-stress1);
diff2 = (data2-stress2);
diff3 = abs(data3-stress3);
diffAll = diff1+diff2+diff3;

returnVal = diffAll;

%store returnVal in filename for communication with Dakota

f=fopen('Fun.txt','w');
if f==-1
  disp('unable to open file!');
else
  fprintf(f,"%e",returnVal);
end
fclose(f);
