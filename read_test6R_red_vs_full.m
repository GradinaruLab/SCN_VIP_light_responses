function read_test6R_red_vs_full
% Fiberphotometry SCN-VIP data, red vs white, 

my_path='D:\DATA_Glab\fiberphotometry\TDT_test6R_red\';

% white light  
mouse_info{1}.ID='VIPGC60N';mouse_info{1}.side='R';mouse_info{1}.Gender='M'; mouse_info{1}.rig='TDT_test6R_red';;mouse_info{1}.date='111618';mouse_info{1}.Sname='test6R1';% 
mouse_info{2}.ID='VIPGC246RL';mouse_info{2}.side='L';mouse_info{2}.Gender='F'; mouse_info{2}.rig='TDT_test6R_red';mouse_info{2}.date='101420';mouse_info{2}.Sname='test6R3';
mouse_info{3}.ID='VIPGC247RRL';mouse_info{3}.side='R';mouse_info{3}.Gender='F'; mouse_info{3}.rig='TDT_test6R_red';mouse_info{3}.date='101420';mouse_info{3}.Sname='test6R2';
mouse_info{4}.ID='VIPGC259R';mouse_info{4}.side='R';mouse_info{4}.Gender='F'; mouse_info{4}.rig='TDT_test6R_red';mouse_info{4}.date='101420';mouse_info{4}.Sname='test6R1';
mouse_info{5}.ID='VIPGC260L';mouse_info{5}.side='L';mouse_info{5}.Gender='F'; mouse_info{5}.rig='TDT_test6R_red';mouse_info{5}.date='101420';mouse_info{5}.Sname='test6R1';
mouse_info{6}.ID='VIPGC261RL';mouse_info{6}.side='R';mouse_info{6}.Gender='F'; mouse_info{6}.rig='TDT_test6R_red';mouse_info{6}.date='101420';mouse_info{6}.Sname='test6R1';

% red light 
mouse_info{7}.ID='VIPGC60N';mouse_info{7}.side='R';mouse_info{7}.Gender='M'; mouse_info{7}.rig='TDT_test6R_red';mouse_info{7}.date='112718';mouse_info{7}.Sname='test6Rred1';% 
mouse_info{8}.ID='VIPGC246RL';mouse_info{8}.side='L';mouse_info{8}.Gender='F'; mouse_info{8}.rig='TDT_test6R_red';mouse_info{8}.date='101420';mouse_info{8}.Sname='test6Rred1';
mouse_info{9}.ID='VIPGC247RRL';mouse_info{9}.side='R';mouse_info{9}.Gender='F'; mouse_info{9}.rig='TDT_test6R_red';mouse_info{9}.date='101420';mouse_info{9}.Sname='test6Rred1';
mouse_info{10}.ID='VIPGC259R';mouse_info{10}.side='R';mouse_info{10}.Gender='F'; mouse_info{10}.rig='TDT_test6R_red';mouse_info{10}.date='101420';mouse_info{10}.Sname='test6Rred1';
mouse_info{11}.ID='VIPGC260L';mouse_info{11}.side='L';mouse_info{11}.Gender='F'; mouse_info{11}.rig='TDT_test6R_red';mouse_info{11}.date='101420';mouse_info{11}.Sname='test6Rred1';
mouse_info{12}.ID='VIPGC261RL';mouse_info{12}.side='R';mouse_info{12}.Gender='F'; mouse_info{12}.rig='TDT_test6R_red';mouse_info{12}.date='101420';mouse_info{12}.Sname='test6Rred1';


for idi=1:length(mouse_info)
    [data{idi}] = FP_analysis_individual_test6R(mouse_info{idi}, my_path); % not z-scored 
    df{idi}=data{idi}.dF;
    t{idi}=data{idi}.t;
    fs{idi}=data{idi}.fs;
    light_array{idi}=data{idi}.light_array;
    peak_analysis{idi}=data{idi}.peak_analysis;
end

%%% get mean values
ind_end=870; dark_ind_end=300;
%dark_ind_end=870;%870
zscore=0;
for idi=1:length(mouse_info)
    all_test_dF=[];
    this_df=df{idi};
    this_t=t{idi};
    event_ind1=intersect(find(this_t>light_array{idi}.light_on(1)-15),find(this_t<light_array{idi}.light_on(1)+30));
    ttmp=this_t(event_ind1);
    %ttmp=ttmp(1:num_sec*fs{idi})-ttmp(1);
    repeats=length(light_array{idi}.light_on); 
    if  strcmp(mouse_info{idi}.ID,'VIPGC60N') &&  strcmp(mouse_info{idi}.rig,'TDT_test6R_red'); repeats=repeats-1;end
    for ti=1:repeats
        event_ind=intersect(find(this_t>light_array{idi}.light_on(ti)-15),find(this_t<light_array{idi}.light_on(ti)+30));
        tmp=this_df(event_ind);
        if zscore
            this_median=median(tmp);
           % this_mad=mad(tmp(1:dark_ind_end));
             this_mad=mad(tmp);
            tmp = (tmp - this_median)./this_mad; % normalization using robust z-score
            % all_dF = (all_dF - median(all_dF))./mad(baseline); % normalization using robust z-score    
        end
        all_test_dF=[all_test_dF tmp(1:ind_end)'];
    end
    if  strcmp(mouse_info{idi}.ID,'VIPGC60N') &&  strcmp(mouse_info{idi}.rig,'TDT_test6R_red');  all_test_dF=[all_test_dF nan(ind_end,1)]; end
    full_df(idi,:,:)=all_test_dF;
    % calculate integral 
    for ti=1:repeats
        
        event_ind_on=intersect(find(this_t>(light_array{idi}.light_on(ti)+4)),find(this_t<(light_array{idi}.light_on(ti)+14)));
        mean_df(ti)=nanmean(this_df(event_ind_on));
        event_ind_baseline=intersect(find(this_t<(light_array{idi}.light_on(ti)-5)),find(this_t>(light_array{idi}.light_on(ti)-15)));
        mean_baseline(ti)=nanmean(this_df(event_ind_baseline));
    end
    all_mean_df(idi)=mean(mean_df);
    all_mean_baseline(idi)=mean(mean_baseline); 
end
close all
% now plot
figure;
t=ttmp-ttmp(1);
subplot(2,2,1)
% for idi=1:6
%     ph=plot(t(1:ind_end),mean(full_df(idi,:,:),3)); hold on
%     ph.Color=[0.5 0.5 0.5];
% end
% ph2=plot(t(1:ind_end),nanmean(mean(full_df(1:6,:,:),3)));hold on
% ph2.Color=[0 0 0];
y=nanmean(mean(full_df(1:6,:,:),3));
SEM=nanstd(mean(full_df(1:6,:,:),3))/sqrt(6);
figure_params.background=[0.95 0.95 0.95];figure_params.line='k';
plot_curve_with_SEM(t(1:ind_end),y,SEM,figure_params)
ylim([0 16])
xlim([0 43])
xlabel('Time (sec)')
ylabel('dF/F')
subplot(2,2,2)
% for idi=7:length(mouse_info)
%     ph=plot(t(1:ind_end),mean(full_df(idi,:,:),3)); hold on
%     ph.Color=[0.5 0.5 0.5];
% end
% ph2=plot(t(1:ind_end),nanmean(mean(full_df(7:12,:,:),3)));hold on
% ph2.Color=[0 0 0];
y2=nanmean(mean(full_df(7:12,:,:),3));
SEM2=nanstd(mean(full_df(7:12,:,:),3))/sqrt(6);
figure_params.background='r';figure_params.line='k';
plot_curve_with_SEM(t(1:ind_end),y2,SEM2,figure_params)
ylim([0 16])
xlim([0 43])
xlabel('Time (sec)')
subplot(2,2,3)
bh1=bar(1,mean(all_mean_df(1:6))); hold on; bh1.FaceColor=[0.95 0.95 0.95];
bh2=bar(2,mean(all_mean_df(7:end))); hold on;bh2.FaceColor=[1 0 0];
bh3=bar(3,mean(all_mean_baseline)); hold on; bh2.FaceColor=[0.2 0.2 0.2];
mean_mean_baseline=mean(reshape(all_mean_baseline,6,2),2);
for i=1:6
   plot([1,2,3],[all_mean_df(i),all_mean_df(i+6),mean_mean_baseline(i)],'*-k'); hold on; 
end
ylim([0 25])
xlim([0.5 3.5])

subplot(2,2,4)
% spectrum, taken with ocean optics 
[num,txt]=xlsread('D:\DATA_Glab\fiberphotometry\Ocean_optics_roomand_red_light.xlsx');
data2(1,:)=num(5:end,1);% wavelength in nm
data2(2,:)=num(5:end,3);% red light
data2(3,:)=num(5:end,4);% room light
plot(data2(1,:),data2(2:3,:),'k');
xlabel('wavelength (nm)')
xlim([ 300 800])

% compare features: 
figure 
% plot red light normalized respose
y2=nanmean(mean(full_df(7:12,:,:),3));
SEM2=nanstd(mean(full_df(7:12,:,:),3))/sqrt(6);
y2=y2-mean(y2(1:200));
SEM2=SEM2-mean(y(1:200));
figure_params.background='r';figure_params.line='k';
plot_curve_with_SEM(t(1:ind_end)-3.2,y2/max(y2),SEM2/max(y2),figure_params); hold on
% plot white light normalized respose
y=nanmean(mean(full_df(1:6,:,:),3));
SEM=nanstd(mean(full_df(1:6,:,:),3))/sqrt(6);
y=y-mean(y(1:200));
SEM=SEM-mean(y(1:200));
figure_params.background=[0.95 0.95 0.95];figure_params.line='k';
plot_curve_with_SEM(t(1:ind_end),y/max(y),SEM/max(y),figure_params); hold on
xlim([0 43])
ylim([-0.1 1.4])
xlabel('Time (sec)')
ylabel('Mean dF/F, normalized (a.u.)')

% statistical test
x=[];
group_length=6;
x=[all_mean_df(1:group_length) all_mean_df(group_length+1:end) mean_mean_baseline(1:group_length)];
g=[];
for gi=1:3
    g=[g gi*ones(1,group_length)];
end
       
clear h
for gi=1:length(unique(g))
    h(gi) = kstest(x(g==3));
end
% Kruskal-Wallis Test. An extension of the Wilcoxon rank sum test to more than two groups.

figure
clear p tbl
[p,tbl,stats]  = kruskalwallis(x,g,'off');
c{pi} = multcompare(stats);
% bonferroni correction
c{pi}(:,7)=c{pi}(:,6)/sum(g==2);



    1