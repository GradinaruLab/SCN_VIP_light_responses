function get_all_dF_FP
% sess_20 experiments. 35 minutes, 10 minutes white light, 10 minutes red
% light. Seperated by 
% uses get_dF_per_mouse
% uses get_FP_single_trial

mice={'286R','288RL','296R','313RL','318L','324RR'};%,'315L'
sex={'male' 'male' 'male' 'female' 'female'  'male' } ;%'male'
for idi=1:length(mice)
    mouse_info.ID=mice{idi};
    switch mouse_info.ID
        case {'286R','296R'}
            mouse_info.side='R';
            mouse_info.dates={'082721'; '083021'; '090221'; '091021'};%MMDDYY
            mouse_info.sessions=[3,4,5,6];
        case '288RL'
            mouse_info.side='R';
            mouse_info.dates={'083021'; '090221'; '091021'; '101221'};%MMDDYY
            mouse_info.sessions=[4,5,6,7];%
        case '313RL'
            mouse_info.side='R';
            mouse_info.dates={ '100521'; '100721'; '101221';'010522'};%MMDDYY; 1;;'100621';'101121' 2 and 4 are noisy
            mouse_info.sessions=[1,3,5,7];%4,5
        case '315L'% male- only 2 repeats- fiber was out - not included
            mouse_info.side='L';
            mouse_info.dates={ '010322';'010422'};
            mouse_info.sessions=[1,2];% 
        case '318L'% female 
            mouse_info.side='L';
            mouse_info.dates={ '010322';'010422';'010522'};
            mouse_info.sessions=[1,2,3];%
        case '324RR'% male
            mouse_info.side='R';
            mouse_info.dates={ '012822';'013022';'020122'};
            mouse_info.sessions=[1 2 3];%

    end
   
    trial_info.rig='SynTDT';
    trial_info.n_onsets=4;% 4 for 2 sessions of light. 2 for 1 session of light on
    trial_info.show=0;
    trial_info.path='D:\DATA_Glab\fiberphotometry\';
    [Output{idi}] = get_dF_per_mouse_FP(mouse_info, trial_info);
end


g=[];
 x_rel_amp=  [];
x_rel_int=[];
x_rel_rate=[];
x_rel_norm_amp=  [];
x_rel_norm_int=  [];
x_rel_norm_rate=  [];
for idi=1:length(mice)
    this_mouse_norm_rel_amp=Output{idi}.this_mouse_norm_rel_amp;
    this_mouse_norm_rel_int=Output{idi}.this_mouse_norm_rel_int;
    this_mouse_norm_rel_rate=Output{idi}.this_mouse_norm_rel_rate;
    this_mouse_rel_amp=Output{idi}.this_mouse_rel_amp;
     this_mouse_rel_int=Output{idi}.this_mouse_rel_int;
    this_mouse_rel_rate=Output{idi}.this_mouse_rel_rate;
% norm
   mean_norm_amp(idi,:)=nanmean(this_mouse_norm_rel_amp,1);
    sem_norm_amp(idi,:)=std(this_mouse_norm_rel_amp,1)/sqrt(size(this_mouse_norm_rel_amp,1));
    mean_norm_int(idi,:)=nanmean(this_mouse_norm_rel_int,1);
    sem_norm_int(idi,:)=std(this_mouse_norm_rel_int,1)/sqrt(size(this_mouse_norm_rel_int,1));
    mean_norm_rate(idi,:)=nanmean(this_mouse_norm_rel_rate,1);
    sem_norm_rate(idi,:)=std(this_mouse_norm_rel_rate,1)/sqrt(size(this_mouse_norm_rel_rate,1));
    % non norm 
    mean_amp(idi,:)=nanmean(this_mouse_rel_amp,1);
    sem_amp(idi,:)=std(this_mouse_rel_amp,1)/sqrt(size(this_mouse_rel_amp,1));
     mean_int(idi,:)=nanmean(this_mouse_rel_int,1);
    sem_int(idi,:)=std(this_mouse_rel_int,1)/sqrt(size(this_mouse_rel_int,1));
    mean_rate(idi,:)=nanmean(this_mouse_rel_rate,1);
    sem_rate(idi,:)=std(this_mouse_rel_rate,1)/sqrt(size(this_mouse_rel_rate,1));

    % getting data in a presentation that will fit 'boxplot'
    g=[g 1:5];% 1 is dark, 2 is white light, 4 is red light 
    x_rel_amp=  [x_rel_amp mean_amp(idi,:)];
    x_rel_int=  [x_rel_int mean_int(idi,:)];
    x_rel_rate=  [x_rel_rate mean_rate(idi,:)];
    x_rel_norm_amp=  [x_rel_norm_int mean_norm_amp(idi,:)];
    x_rel_norm_int=  [x_rel_norm_int mean_norm_int(idi,:)];
    x_rel_norm_rate=  [x_rel_norm_rate mean_norm_rate(idi,:)];
end

% put all the dark sessions into one group 
for gi=1:length(g)
    if g(gi)==3 || g(gi)==5; g(gi)=1; end
end

figure
subplot(2,3,1)
boxplot(x_rel_int,g); hold on
ylabel('Integrated dF (a.u.)')
subplot(2,3,2)
boxplot(x_rel_rate,g)
ylabel('Event rates (event/min)')
subplot(2,3,3)
boxplot(x_rel_amp,g)
ylabel('Event amplitude (a.u.)')

subplot(2,3,4)
boxplot(x_rel_norm_int,g); hold on
ylabel('Norm integrated dF (a.u.)')
subplot(2,3,5)
boxplot(x_rel_norm_rate,g)
ylabel('Norm event rates (event/min)')
subplot(2,3,6)
boxplot(x_rel_norm_amp,g)
ylabel('Norm event amplitude (a.u.)')

% check normality with one sample Kolmogorov-Smirnov test. h=1 means that
% the distribution is NOT normal 
clear h
for gi=1:length(unique(g))
    h(gi) = kstest(x_rel_int(g==2));
end
% Kruskal-Wallis Test. An extension of the Wilcoxon rank sum test to more than two groups.

if sum(h)>2
    figure
    clear c tbl
    [p,tbl,stats]  = kruskalwallis(x_rel_int,g,'off');
    c_int = multcompare(stats,'CType','hsd');
     c_intB = multcompare(stats,'CType','bonferroni');
     c_intC = multcompare(stats,'CType','dunn-sidak');
end
% now for event rates 
for gi=1:length(unique(g))
    h(gi) = kstest(x_rel_rate(g==2));
end
% Kruskal-Wallis Test. An extension of the Wilcoxon rank sum test to more than two groups.
if sum(h)>2
    figure
    clear c tbl
    [p,tbl,stats]  = kruskalwallis(x_rel_rate,g,'off');
    c_rate = multcompare(stats,'CType','hsd');
    c_rateB = multcompare(stats,'CType','bonferroni');% bonferroni correction 
     c_rateC = multcompare(stats,'CType','dunn-sidak');
end

for gi=1:length(unique(g))
    h(gi) = kstest(x_rel_amp(g==2));
end
% Kruskal-Wallis Test. An extension of the Wilcoxon rank sum test to more than two groups.
if sum(h)>2
    figure
    clear c tbl
    [p,tbl,stats]  = kruskalwallis(x_rel_amp,g,'off');
    c_amp = multcompare(stats,'CType','hsd');% mulitple comparison correction 

end
c_int
c_rate
c_amp
1



