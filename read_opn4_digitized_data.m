function read_opn4_digitized_data
% first run: digitize2
% save as txt, and open with xlsx
my_path='Z:\Anat\Papers_in_work_from_laptop\SCN_VIP_LightResponse\opn_sensitivities\';

filename=[my_path 'S-Opsin_Franke'];
T_Sopsin = readtable(filename);

filename=[my_path 'opn4_b'];
T_opn4 = readtable(filename);

filename=[my_path 'opn4_BFNature2'];
T_opn42 = readtable(filename);
T_opn42.Sensitivity_non_norm=10.^T_opn42.Sensitivity_log;
T_opn42.Sensitivity=T_opn42.Sensitivity_non_norm/max(T_opn42.Sensitivity_non_norm);

filename=[ my_path 'GREEN'];
T_GREEN = readtable(filename);

filename=[ my_path 'GREEN_Sun'];
T_GREEN2 = readtable(filename);
tmp=T_GREEN2.Sensitivity_rel-min(T_GREEN2.Sensitivity_rel);
T_GREEN2.Sensitivity=tmp/max(tmp);

filename=[ my_path 'Rh'];
T_Rh = readtable(filename);

filename=[my_path 'Rh_Imai'];
T_Rh2 = readtable(filename);
T_Rh2.Sensitivity_non_norm=10.^T_Rh2.Sensitivity_log;
T_Rh2.Sensitivity=T_Rh2.Sensitivity_non_norm/max(T_Rh2.Sensitivity_non_norm);

load([my_path  'lumencore_GCaMP_responses_SCNVIP.mat']);

x=[395 438 473 513 560 586 650]';
y=mean(resp,2);
SEM=std(resp')/sqrt(size(resp,1));
curve1 = y + SEM';
curve2 = y - SEM';
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];



figure
%plot(resp(:,1),resp(:,2:end),'-*k'); hold on
%fill(x2, inBetween, [0.5 0.5 0.5]); hold on;
plot(x, y/max(y), '-*k', 'LineWidth', 2); hold on;

plot(T_Sopsin.Wavelength,T_Sopsin.Sensitivity_rel,'Linewidth',2,'Color',[0.5 0.5 0.5],'Linestyle',':'); hold on 
%plot(T_opn4.Wavelength,T_opn4.Sensitivity); hold on
plot(T_opn42.Wavelength,T_opn42.Sensitivity,'Linewidth',2,'Color',[0.5 0.5 0.5],'Linestyle','-'); hold on 
plot(T_GREEN.Wavelength,T_GREEN.Sensitivity,'Linewidth',2,'Color',[0.5 0.5 0.5],'Linestyle','-.'); hold on 
%plot(T_GREEN2.Wavelength,T_GREEN2.Sensitivity); hold on
%plot(T_Rh.Wavelength,T_Rh.Sensitivity); hold on
plot(T_Rh2.Wavelength,T_Rh2.Sensitivity,'Linewidth',2,'Color',[0.5 0.5 0.5],'Linestyle','--'); hold on
legend({'VIP FP', 'S-Opsin','Opn4','M-Opsin','Rh'})
ylim([-0.1 1.2])
xlim([350 660])

T.T_GREEN=T_GREEN;
T.T_opn4=T_opn42;
T.T_opn5=T_Sopsin;
T.T_Rh=T_Rh2;

%my_curve_fitting_opn(T,x,y/max(y));