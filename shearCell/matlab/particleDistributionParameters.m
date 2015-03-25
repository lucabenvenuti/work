clear all
close all
clc

weightedMeanDiam = mean(weight.'*diameter,2);
stddevDiam=sqrt(var(diameter, weight));

radius = diameter/2;

weightedMeanRad = mean(weight.'*radius,2);
stddevRad=sqrt(var(radius, weight));