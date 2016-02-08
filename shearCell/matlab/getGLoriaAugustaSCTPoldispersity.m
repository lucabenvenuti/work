function [ gloriaAugustaSchulzeNNDens, kkk ] = getGLoriaAugustaSCTPoldispersity(coeffShear40, coeffShear60, ...
    coeffShear80, coeffShear100, expFtd, expOut, coeffPirker, newY3, fricTolerance, densTolerance)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


meanExpFtdRhoB = mean(expFtd.rhoB);
maxExpFtdRhoB  = max(expFtd.rhoB);
minExpFtdRhoB  = min(expFtd.rhoB);

coeffShear40 = coeffShear40*coeffPirker;
expOut.coeffPreShear40 = expOut.coeffPreShear40*coeffPirker;

coeffShear60 = coeffShear60*coeffPirker;
expOut.coeffPreShear60 = expOut.coeffPreShear60*coeffPirker;

coeffShear80 = coeffShear80*coeffPirker;
expOut.coeffPreShear80 = expOut.coeffPreShear80*coeffPirker;

coeffShear100 = coeffShear100*coeffPirker;
expOut.coeffPreShear100 = expOut.coeffPreShear100*coeffPirker;

[nY3rows, nY3column] = size(newY3);
if (nY3rows > 7) 
    warning('too many rows, check variable positions') 
end
avgMuR2Pos = 5;
avgMuR1Pos = 6;
densityBulkBoxMeanPos = 7;
densityPostPos = densityBulkBoxMeanPos;
densityPrePos = densityBulkBoxMeanPos;

newY3(nY3rows+1,:) = newY3(avgMuR2Pos,:)/coeffShear100;
newY3(nY3rows+2,:) = newY3(avgMuR1Pos,:)/expOut.coeffPreShear100 ;
newY3(nY3rows+3,:) = expOut.tauAbPr100; %expInp.tauAb100;
newY3(nY3rows+4,:) = expOut.sigmaAnM;% expOut.sigmaAb100;
newY3(nY3rows+5,:) = coeffShear100;
newY3(nY3rows+6,:) = expOut.tauAbPr100;
newY3(nY3rows+7,:) = expOut.coeffPreShear100;
newY3(nY3rows+8,:) = expOut.rhoBAnM;

nY3rowsBis = nY3rows+8;

newY3(nY3rowsBis+1,:) =  abs(1- newY3(nY3rows+1,:));
newY3(nY3rowsBis+2,:) =  abs(1- newY3(nY3rows+2,:));

newY3(nY3rowsBis+3,:) =  meanExpFtdRhoB;%mean(expFtd.rhoB);
newY3(nY3rowsBis+4,:) =  maxExpFtdRhoB;%max(expFtd.rhoB);
newY3(nY3rowsBis+5,:) =  minExpFtdRhoB;%min(expFtd.rhoB);

kkk=1;
temp_vi = newY3( (nY3rowsBis+1), : );
temp_i = find (temp_vi < fricTolerance);
temp_vj = newY3( (nY3rowsBis+2), : );
temp_j = find (temp_vj < fricTolerance);
temp_vk = newY3( densityPostPos, : );
temp_k = find (temp_vk < maxExpFtdRhoB*(1.0 + densTolerance));
temp_l = find (temp_vk > minExpFtdRhoB*(1.0 - densTolerance));

temp_vm = newY3( densityPrePos, : );
temp_m = find (temp_vm < maxExpFtdRhoB*(1.0 + densTolerance));
temp_n = find (temp_vm > minExpFtdRhoB*(1.0 - densTolerance));

[Cij,aij,bij] = intersect(temp_i,temp_j);
[Ckl,akl,bkl] = intersect(temp_k,temp_m);
if (size(akl,1)<1)
    [Ckl,akl,bkl] = intersect(temp_l,temp_n);
end
[Cijkl,aijkl,bijkl] = intersect(Cij,Ckl);

ni = size(Cijkl,2) ;

nY3rowsTris = nY3rowsBis+5;

gloriaAugustaSchulzeNNDens = zeros( ni,  nY3rowsTris+2);
gloriaAugustaSchulzeNNDens( kkk:(kkk+ni-1), 1) = Cijkl';
gloriaAugustaSchulzeNNDens(kkk:ni, 2:(nY3rowsTris+1) ) = newY3( :, Cijkl )';
gloriaAugustaSchulzeNNDens( kkk:ni, nY3rowsTris+2) = 1;

kkk = kkk + ni;

end

