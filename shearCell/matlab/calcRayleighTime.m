%% clear workspace
clear all
close all
clc

%% ### user input #########################################################

r =    0.00001; %0.5e-3; %1e-3; %2e-3;  %1.3e-3; %35.5e-6; %0.05e-3; %0.575e-3;
rho = 4500; %2500;   %828;   %2500;   %945;     %945;     %2500;
nu =   0.4; %0.45;   %0.45;   %0.44;    %0.44;    %0.45;
Y =    5e7; %40e6;    %1e8;   %1e7;     %0.4e9;   %65e9;

% #########################################################################

%% calc time

G = 1/((2*(2+nu)*(1-nu))/(Y));

dt_r = pi*r*sqrt(rho/G)/(0.1631*nu+0.8766);

disp(['The Rayleigh time step is ',num2str(dt_r),'. 20% of it are ',num2str(0.2*dt_r),'.']);