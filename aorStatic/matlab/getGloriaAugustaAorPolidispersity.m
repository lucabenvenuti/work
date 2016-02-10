function [ gloriaAugustaAor, kkk ] = getGloriaAugustaAorPolidispersity( ...
    newY2, angleExp, coeffPirker, angleTolerance )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

kkk = 1;
[newY2rows, nY2column] = size(newY2);
angleExp = angleExp * coeffPirker;

% newY2rows =   nY2rows  ;
newY2(newY2rows+1,:) = newY2(newY2rows - 1,:)/angleExp;
newY2(newY2rows+2,:) = abs(1- newY2(newY2rows + 1,:));

temp_v = newY2( (newY2rows+2), : );
temp_i = find (temp_v < angleTolerance);
ni = size(temp_i,2);
gloriaAugustaAor = zeros( kkk+size(temp_i,2)-1, newY2rows+4 );
gloriaAugustaAor( kkk:(kkk+ni-1), 1) = temp_i';
gloriaAugustaAor( kkk:(kkk+ni-1), 2:(newY2rows+3) ) = newY2( :, temp_i )';
gloriaAugustaAor( kkk:(kkk+ni-1), newY2rows+4) = 1;

kkk = kkk + ni;

if (kkk < 200)
    newY2(newY2rows+1,:) = newY2(newY2rows - 0,:)/angleExp;
    newY2(newY2rows+2,:) = abs(1- newY2(newY2rows + 1,:));
    
    temp_v = newY2( (newY2rows+2), : );
    temp_i = find (temp_v < angleTolerance);
    ni = size(temp_i,2);
    gloriaAugustaAor = zeros( kkk+size(temp_i,2)-1, newY2rows+4 );
    gloriaAugustaAor( kkk:(kkk+ni-1), 1) = temp_i';
    gloriaAugustaAor( kkk:(kkk+ni-1), 2:(newY2rows+3) ) = newY2( :, temp_i )';
    gloriaAugustaAor( kkk:(kkk+ni-1), newY2rows+4) = 1;
    
    kkk = kkk + ni;
end

end

