function plot_mono_syn_tracing_results
% NovDec 2021 - light response paper 
% Data was analized with Imaris 'spot' fumction on a z-stack imaging of the
% retina
% Dec imaging- retina was dried on the nitrocelulus paper - created a
% thinner retina- imaging settings changed
% Data location Nov: 
% Z:\Anat\SCN_VIP_mono_syn_tracing\VIP504RR\VIP504RR_retina\VIP504RR_retina_Imaris
% Z:\Anat\SCN_VIP_mono_syn_tracing\VIP505R\VIP505R_retina\VIP505R_Imaris
% Z:\Anat\SCN_VIP_mono_syn_tracing\VIP501R\VIP501R_Retina\VIP501R_Imaris
% Data location Dec: 

%sample_ID can be found in 'Mono.Syn.Tracing SCN-VIP to retina.xlsx' in anat.kahan@mail.huji.ac.il drive 
total_opn4=[156 173 198 244 230 176 177];
total_deltaG=[62 91 47 77 24 77 47];
num_opn4_deltaG_coexp=[2 16 7 13 1 11 3];

percent_opn4_express_deltaG=100*num_opn4_deltaG_coexp./total_opn4;
percent_deltaG_express_opn4=100*num_opn4_deltaG_coexp./total_deltaG;

figure
plot(percent_deltaG_express_opn4,percent_opn4_express_deltaG,'*')
ylabel('% deltaG/total-opn4')
xlabel('% opn4/total-deltaG')

figure
%bar([1*ones(length(percent_deltaG_express_opn4),1) 2*ones(length(percent_deltaG_express_opn4),1)],[percent_deltaG_express_opn4' percent_opn4_express_deltaG'])
a=[1*ones(1,length(percent_deltaG_express_opn4)) 2*ones(1,length(percent_deltaG_express_opn4))];
all_y=[percent_deltaG_express_opn4 percent_opn4_express_deltaG];
boxplot(all_y,a,'PlotStyle','compact','Colors',[0 0 0;0.6350 0.0780 0.1840]); hold on 

plot(1.15,percent_deltaG_express_opn4','*k',2.15, percent_opn4_express_deltaG','*r')
xticks([1 2])
xticklabels({'% Opn4/total-deltaG'; '% DeltaG/total-Opn4'});
ylabel('% Coexpression')

disp(['% median deltaG that express opn4 ' num2str(median(percent_deltaG_express_opn4)) '+-' num2str(std(percent_deltaG_express_opn4)/sqrt(length(percent_deltaG_express_opn4)))]);
disp(['% median opn4 that express deltaG ' num2str(median(percent_opn4_express_deltaG)) '+-' num2str(std(percent_opn4_express_deltaG)/sqrt(length(percent_opn4_express_deltaG)))]);


disp(['opn4 cells ' num2str(mean(total_opn4)) '+-' num2str(std(total_opn4)/sqrt(length(total_opn4)))])
disp(['mcherry cells ' num2str(mean(total_deltaG)) '+-' num2str(std(total_deltaG)/sqrt(length(total_deltaG)))])
disp(['overlaping cells ' num2str(mean(num_opn4_deltaG_coexp)) '+-' num2str(std(num_opn4_deltaG_coexp)/sqrt(length(num_opn4_deltaG_coexp)))])