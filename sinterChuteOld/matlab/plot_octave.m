close all;
clear;

%========================================
%EVALUATION PARAMETERS GO HERE
%========================================

%z-planes for evaluation
diams = [0.005; 0.006; 0.01; 0.016; 0.025; 0.04; 0.05];

%speed-up and coarse graining factor
speedup = 20
cg = 5

%cases defined below

%========================================

color = ["rgbcmkrg"];

for iCase = 1:1,

	if (iCase==1),
		case_ = "segregation"
	elseif(iCase==2),
		case_ = "30_deg_approximate"
	end;


	for iDiam = 1:length(diams),
			eval(strcat("load results_",case_,"_diam_",num2str(diams(iDiam)*1000),";"));

			eval(strcat("tmp = results_",case_,"_diam_",num2str(diams(iDiam)*1000),";"));

			%plot vz
			figure(1);
			hold on;
			plot(tmp(:,2),tmp(:,3),strcat(color(iDiam),"@-"));

			%plot average volume fraction
			figure(2);
			hold on;
			plot(tmp(:,2),tmp(:,4),strcat(color(iDiam),"@-"));

			%plot number of particles
			figure(3);
			hold on;
			plot(tmp(:,2),tmp(:,5),strcat(color(iDiam),"@-"));

			%plot relative number of particles
			figure(4);
			hold on;
			plot(tmp(:,2),(length(diams)+1-iDiam)*tmp(:,5)/max(tmp(:,5)),strcat(color(iDiam),"@-"));
	end;


	figure(1);
	xlabel("y in m","FontName","DejaVuSansMono","fontsize", 20);
	ylabel("v_z in m/s","FontName","DejaVuSansMono","fontsize", 20);
	legend(num2str(diams));
	title("z-velocity for different diameter fractions","FontName","DejaVuSansMono","fontsize", 20)
	eval(strcat("print -color """,case_,"_vz.eps"""));
	replot;

	figure(2);
	xlabel("y in m","FontName","DejaVuSansMono","fontsize", 20);
	ylabel("volume fraction","FontName","DejaVuSansMono","fontsize", 20);
	legend(num2str(diams));
	title("volume fraction occupied by different diameter fractions","FontName","DejaVuSansMono","fontsize", 20)
	eval(strcat("print -color """,case_,"_volfr.eps"""));
	replot;

	figure(3);
	xlabel("y in m","FontName","DejaVuSansMono","fontsize", 20);
	ylabel("particle number","FontName","DejaVuSansMono","fontsize", 20);
	legend(num2str(diams));
	title("number of particles in bin for different diameter fractions","FontName","DejaVuSansMono","fontsize", 20)
	eval(strcat("print -color """,case_,"_np_bin.eps"""));
	replot;

	figure(4);
	xlabel("y in m","FontName","DejaVuSansMono","fontsize", 20);
	ylabel("normalized particle number","FontName","DejaVuSansMono","fontsize", 20);
	legend(num2str(diams));
	title("normalized number of particles in bin for different diameter fractions","FontName","DejaVuSansMono","fontsize", 20)
	eval(strcat("print -color """,case_,"_np_bin_normalized.eps"""));
	replot;


end;


eval(strcat("load results_",case_,"_sauter_diameter;"));
eval(strcat("tmp = results_",case_,"_sauter_diameter;"));

%plot sauter diam
figure(4);
hold on;
plot(tmp(:,2),tmp(:,3),strcat(color(1),"@-"));

figure(4);
xlabel("y in m","FontName","DejaVuSansMono","fontsize", 20);
ylabel("sauter diameter in m","FontName","DejaVuSansMono","fontsize", 20);
title("sauter diameter","FontName","DejaVuSansMono","fontsize", 20)
eval(strcat("print -color """,case_,"_sauter_diam.eps"""));
replot;


clear;
close all;
