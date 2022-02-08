function read_test6R_opn4_antagonist_FP
% Fiber photomtery data 
% Aug 2021 

my_path='D:\DATA_Glab\fiberphotometry\TDT_test6R_opn4_antagonist\';
% without blue light 
%states={'White light' , 'Opn4 ant. white',  'DMSO','Red light' , 'Opn4 ant. red' };
% with bluw elight 
states={'White light' , 'Opn4 ant. white',  'DMSO','Red light' , 'Opn4 ant. red' ,'blue dim light' ,'blue bright light' , 'Opn4 ant. blue dim' 'Opn4 ant. blue bright', 'Opn4 ant. white','red dim light' ,'red bright light' };
%b_states{1}='Before'; b_states{2}='After Opn4 antagonist'; b_states{3}='Before'; b_states{4}='After DMSO';
styles={'k-', 'k--','k-.','k:' 'k-.','k:','k--','k:' 'k-.','k:', 'k--','k:' 'k-.'}; 
styles2={'k-', 'k--','k-.','r:' 'r-.','b-','b--' 'b-.','b:', 'k--','r:' 'r-.'}; 
%Groups={[1:4],[5:8],[9:12],[13:16],[17:19],[20:22]};
%Groups={[1:4],[5:8],[9:12],[13:15],[16:18]}; % without blue light
Groups={[1:4],[5:8],[9:12],[13:15],[16:18],[19:22],[23:26],[27:30],[31:34],[35:37],[38:41],[42:45]};% with blue light
%ID='VIPGC60N'; side='R'; Gender='M'; rig='TDT';

% full white light
mouse_info{1}.ID='VIPGC262R';mouse_info{1}.side='R';mouse_info{1}.Gender='M'; mouse_info{1}.rig='TDT_test6R_red';;mouse_info{1}.date='020221';mouse_info{1}.Sname='test6R3';% 
mouse_info{2}.ID='VIPGC286R';mouse_info{2}.side='R';mouse_info{2}.Gender='M'; mouse_info{2}.rig='TDT_test6R_red';mouse_info{2}.date='071921';mouse_info{2}.Sname='test6R3';
%mouse_info{3}.ID='VIPGC288RL';mouse_info{3}.side='R';mouse_info{3}.Gender='M';%mouse_info{3}.rig='TDT_test6R_red';mouse_info{3}.date='071921';mouse_info{3}.Sname='test6R3'; %not good
ind=3; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='071921';mouse_info{ind}.Sname='test6R3';
ind=4; mouse_info{ind}.ID='VIPGC298L';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='072121';mouse_info{ind}.Sname='test6R3';
%mouse_info{6}.ID='VIPGC261RL';mouse_info{6}.side='R';mouse_info{6}.Gender='F'; mouse_info{6}.rig='TDT_test6R_red';mouse_info{6}.date='101420';mouse_info{6}.Sname='test6R1';

% opn4 antagonist 
ind=5; mouse_info{ind}.ID='VIPGC262R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='020221';mouse_info{ind}.Sname='test6R4';% 
ind=6; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='071921';mouse_info{ind}.Sname='test6R4';
ind=7; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='071921';mouse_info{ind}.Sname='test6R4';
%ind=8; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='071921';mouse_info{ind}.Sname='test6R4';
ind=8; mouse_info{ind}.ID='VIPGC298L';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='072121';mouse_info{ind}.Sname='test6R4';
%mouse_info{12}.ID='VIPGC261RL';mouse_info{12}.side='R';mouse_info{12}.Gender='F'; mouse_info{12}.rig='TDT_test6R_red';mouse_info{12}.date='101420';mouse_info{12}.Sname='test6Rred1';

% white light before DMSO 
% ind=9; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='072121';mouse_info{ind}.Sname='test6R5';
% ind=10; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='072121';mouse_info{ind}.Sname='test6R5';
% ind=11; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='072121';mouse_info{ind}.Sname='test6R5';
% ind=12; mouse_info{ind}.ID='VIPGC298L';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='072721';mouse_info{ind}.Sname='test6R5';

%mouse_info{6}.ID='VIPGC261RL';mouse_info{6}.side='R';mouse_info{6}.Gender='F'; mouse_info{6}.rig='TDT_test6R_red';mouse_info{6}.date='101420';mouse_info{6}.Sname='test6R1';

% DMSO only 
ind=9; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='072121';mouse_info{ind}.Sname='test6R6';
ind=10; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='072121';mouse_info{ind}.Sname='test6R6';
ind=11; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='072121';mouse_info{ind}.Sname='test6R6';
ind=12; mouse_info{ind}.ID='VIPGC298L';mouse_info{ind}.side='R';mouse_info{ind}.Gender='F'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='072721';mouse_info{ind}.Sname='test6R6';

% room Red light 
ind=13; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='081021';mouse_info{ind}.Sname='test6R9';
ind=14; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='081021';mouse_info{ind}.Sname='test6R9';
ind=15; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='081021';mouse_info{ind}.Sname='test6R9';

% Red light after opn4 antagonist 
ind=16; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='081021';mouse_info{ind}.Sname='test6R10';
ind=17; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='081021';mouse_info{ind}.Sname='test6R10';
ind=18; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='081021';mouse_info{ind}.Sname='test6R10';

% blue dim light 
ind=19; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101421';mouse_info{ind}.Sname='test6Rbluelow';
ind=20; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101421';mouse_info{ind}.Sname='test6Rbluelow';
ind=21; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101521';mouse_info{ind}.Sname='test6Rbluelow';
ind=22; mouse_info{ind}.ID='VIPGC313RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101821';mouse_info{ind}.Sname='test6Rbluelow';

% blue bright light 
ind=23; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101421';mouse_info{ind}.Sname='test6Rbluehigh';
ind=24; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101421';mouse_info{ind}.Sname='test6Rbluehigh';
ind=25; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101521';mouse_info{ind}.Sname='test6Rbluehigh';
ind=26; mouse_info{ind}.ID='VIPGC313RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101821';mouse_info{ind}.Sname='test6Rbluehigh';

% blue dim light after opn4 antagonist
ind=27; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101421';mouse_info{ind}.Sname='test6RbluelowAOPN4';
ind=28; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101421';mouse_info{ind}.Sname='test6RbluelowAOPN4';
ind=29; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101521';mouse_info{ind}.Sname='test6RbluelowAOPN4';
ind=30; mouse_info{ind}.ID='VIPGC313RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101821';mouse_info{ind}.Sname='test6RbluelowAOPN4';

%  blue bright light after opn4 antagonist
ind=31; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101421';mouse_info{ind}.Sname='test6RbluehighAOPN4';
ind=32; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101421';mouse_info{ind}.Sname='test6RbluehighAOPN4';
ind=33; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101521';mouse_info{ind}.Sname='test6RbluehighAOPN4';
ind=34; mouse_info{ind}.ID='VIPGC313RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101821';mouse_info{ind}.Sname='test6RbluehighAOPN4';

% white after opn4 antagonist
ind=35; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101421';mouse_info{ind}.Sname='test6R11';
ind=36; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101521';mouse_info{ind}.Sname='test6R11';
ind=37; mouse_info{ind}.ID='VIPGC313RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101821';mouse_info{ind}.Sname='test6R7';

% Red dim light 
ind=38; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101921';mouse_info{ind}.Sname='test6Rredlow';
ind=39; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101921';mouse_info{ind}.Sname='test6Rredlow';
ind=40; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='102021';mouse_info{ind}.Sname='test6Rredlow';
ind=41; mouse_info{ind}.ID='VIPGC313RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101921';mouse_info{ind}.Sname='test6Rredlow';

% Red bright light 
ind=42; mouse_info{ind}.ID='VIPGC286R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101921';mouse_info{ind}.Sname='test6Rredhigh';
ind=43; mouse_info{ind}.ID='VIPGC288RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101921';mouse_info{ind}.Sname='test6Rredhigh';
ind=44; mouse_info{ind}.ID='VIPGC296R';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='102021';mouse_info{ind}.Sname='test6Rredhigh';
ind=45; mouse_info{ind}.ID='VIPGC313RL';mouse_info{ind}.side='R';mouse_info{ind}.Gender='M'; mouse_info{ind}.rig='TDT_test6R_red';mouse_info{ind}.date='101921';mouse_info{ind}.Sname='test6Rredhigh';

for idi=1:length(mouse_info)
%for idi=5:9
    [data{idi}] = FP_analysis_individual_test6R_with_params(mouse_info{idi},my_path); % not z-scored 
    df{idi}=data{idi}.dF;
    t{idi}=data{idi}.t;
    fs{idi}=data{idi}.fs;
    light_array{idi}=data{idi}.light_array;
    peak_analysis{idi}=data{idi}.peak_analysis;
    delta_t_to_max{idi}=data{idi}.delta_t_to_max;
    int_df_around_max{idi}=data{idi}.int_df_around_max;
    int_df_last_half{idi}=data{idi}.int_df_last_half;
    ratio_max_to_last{idi}=data{idi}.ratio_max_to_last;
end

%%% get mean values
ind_end=853; dark_ind_end=300;
%dark_ind_end=870;%870
if_zscore=1;
clear full_df
for idi=1:length(mouse_info)
%for idi=1:20
    all_test_dF=[];
    this_df=df{idi};
    this_t=t{idi};
    figure
    plot(this_t,this_df)
    event_ind1=intersect(find(this_t>light_array{idi}.light_on(1)-15),find(this_t<light_array{idi}.light_on(1)+30));
    ttmp=this_t(event_ind1);
    %ttmp=ttmp(1:num_sec*fs{idi})-ttmp(1);
    repeats=length(light_array{idi}.light_on); 
   
    for ti=1:repeats
        L_event_inds(ti)=length(intersect(find(this_t>light_array{idi}.light_on(ti)-15),find(this_t<light_array{idi}.light_on(ti)+30)));
    end
    % correct for few shorter recordings 
    
    for ti=1:repeats
        event_ind=intersect(find(this_t>light_array{idi}.light_on(ti)-15),find(this_t<light_array{idi}.light_on(ti)+30));
        tmp=this_df(event_ind);
        % add nan to a shorter recording session 
        if L_event_inds(ti)<L_event_inds(1); Add_nan=1; else Add_nan=0; end
        if Add_nan; tmp=[tmp nan(1,L_event_inds(1)-L_event_inds(ti))]; end
        % baseline index
         B_event_ind=intersect(find(this_t>light_array{idi}.light_on(ti)-15),find(this_t<light_array{idi}.light_on(ti)));
         B_tmp=this_df(B_event_ind);
        if if_zscore
            this_median=nanmedian(B_tmp);
           % this_mad=mad(tmp(1:dark_ind_end));
             this_mad=mad(tmp);
            tmp = (tmp - this_median)./this_mad; % normalization using robust z-score
            % all_dF = (all_dF - median(all_dF))./mad(baseline); % normalization using robust z-score    
        end
        
        all_test_dF=[all_test_dF tmp(1:ind_end)'];
    end
    full_df(idi,:,:)=all_test_dF;
    % calculate integral 
    for ti=1:repeats
        % non z-scored: 
       %event_ind_on=intersect(find(this_t>light_array{idi}.light_on(ti)),find(this_t<light_array{idi}.light_off(ti)));
        %mean_df(ti)=nanmean(this_df(event_ind_on));
        % z-scored: 
     L=size(full_df,2)/3;
     % mean_df(ti)= nanmean(full_df(idi,L:2*L-1,ti));
       mean_df(ti)= sum(full_df(idi,L:2*L-1,ti));
    end
    all_mean_df(idi)=mean(mean_df);
end
close all
% 
%% get rise time and AUC around peak or after peak
for idi=1:length(mouse_info)
    mean_delta_t_to_max(idi)=mean(delta_t_to_max{idi}); 
    sem_delat_t_to_max(idi)=std(delta_t_to_max{idi})/sqrt(length(delta_t_to_max{idi})); 
    
    mean_int_df_around_max(idi)=mean(int_df_around_max{idi});
     sem_int_df_around_max(idi)=std(int_df_around_max{idi})/sqrt(length(int_df_around_max{idi})); 
  
    
     mean_int_df_last_half(idi)=mean(int_df_last_half{idi});
     sem_int_df_last_half(idi)=std(int_df_last_half{idi})/sqrt(length(int_df_last_half{idi})); 
     
     mean_ratio_max_to_last(idi)=mean(ratio_max_to_last{idi});
     sem_ratio_max_to_last(idi)=std(ratio_max_to_last{idi})/sqrt(length(ratio_max_to_last{idi}));

end


% calculate decay times 

t2=ttmp-ttmp(1);
t_start=31;% sec
t_end=40;% sec
figure
for gi=1:length(Groups)
    subplot(1,length(Groups),gi)
    y=nanmean(full_df(Groups{gi},:,:),3);
    clear these_tau
    for ri=1:size(y,1)
        t_ind=intersect(find(t2>t_start), find(t2<=t_end));
        x=t2(t_ind)'-t_start;
        this_y=y(ri,t_ind)';
        g = fittype('a-b*exp(-c*x)');
        f0 = fit(x,this_y,g,'StartPoint',[[ones(size(x)), -exp(-x)]\this_y; 1]);
        these_tau(ri)=f0.c;
        xx = linspace(0,10,50);
        plot(x,this_y,styles2{gi},xx,f0(xx),'r-');hold on 
    end
    tau{gi}=these_tau;
end


%% colculate correlation coefficien
% for idi1=1:length(mouse_info)
%     A(:)=mean(full_df(idi1,:,:),3);
%     for idi2=1:length(mouse_info)
%         B(:)=mean(full_df(idi2,:,:),3);
%         cr2(idi1,idi2)=corr2(A,B);
%     end
% end
%         
% figure
% heatmap(cr2)

% now plot
figure;
t2=ttmp-ttmp(1);
for gi=1:length(Groups)
    subplot(4,4,gi)
    % for idi=1:6
    %     ph=plot(t(1:ind_end),mean(full_df(idi,:,:),3)); hold on
    %     ph.Color=[0.5 0.5 0.5];
    % end
    % ph2=plot(t(1:ind_end),nanmean(mean(full_df(1:6,:,:),3)));hold on
    % ph2.Color=[0 0 0];
    y=nanmean(mean(full_df(Groups{gi},:,:),3));
    SEM=nanstd(mean(full_df(Groups{gi},:,:),3))/sqrt(length(Groups{gi}));
    figure_params.background=[0.95 0.95 0.95];figure_params.line='k'; 
    if gi==4 || gi==5
        figure_params.background='r';figure_params.line='k';
    end
    plot_curve_with_SEM(t2(1:ind_end),y,SEM,figure_params)
    ylim([-0.4 4.5])
    xlim([0 45])
    xlabel('Time (sec)')
    ylabel('dF/F (z-score)')
    title (states{gi})
end

k=gi;
% compare features: 
subplot(4,4,k+1)
for gi=1:length(Groups)
    y=nanmean(mean(full_df(Groups{gi},:,:),3));
    y=y-mean(y(1:200)); % remove baseline ( before light is turned on)
    plot (t2(1:ind_end),y/max(y),styles2{gi}); hold on
end
ylim([-0.1 1.2])
xlim([0 45])
xlabel('Time (sec)')
ylabel('Normalized dF/F (z-score)')
disp('overlay')
legend(states)
% compare features: 
% subplot(2,7,k+2)
% for gi=1:length(Groups)-2
%     y=nanmean(mean(full_df(Groups{gi},:,:),3));
%     y=y-mean(y(1:200)); % remove baseline ( before light is turned on)
%     if gi==2
%         plot (t(1:ind_end),y/(max(y)*2),styles{gi}); hold on
%     end
%     plot (t(1:ind_end),y/max(y),styles{gi}); hold on
% end
% ylim([-0.1 1.2])
% xlim([0 45])
% xlabel('Time (sec)')
% ylabel('Normalized dF/F (z-score)')
% disp('overlay without red light')

%Trying a different kind of presenation, in which x axis is the
%log10(photons/cm^2/sec)
figure
% compare peak vs intensity : 
k=1;
subplot(3,3,k)
for gi=1:length(Groups)
    this_group=Groups{gi};
    y2=[];
    for ki=1:length(Groups{gi})
        y2=[y2; max_values{this_group(ki)}];  
    end
    diff_y2=diff(y2,1,2);
    ph1=plot (log10(intensities(gi)), median(diff_y2(:,1)),['o' g_colors{gi}]); hold on
    ph1.MarkerSize=10;
    sem=std(diff_y2(:,1))/sqrt(length(diff_y2(:,1)));
     ph=line ([log10(intensities(gi)) log10(intensities(gi))], [median(diff_y2(:,1))+sem  median(diff_y2(:,1))-sem]); hold on %,['-' g_colors{gi}]); hold on
     ph.Color=g_colors{gi};
      ph.LineWidth=2;
end
kh=line ([13 16],[0 0]);kh.Color='k';
ylim([-4.5 2])
xlim([13 15.5])
xlabel('Log10 (photon/cm^2/sec)')
ylabel('dF/F Peak difference (first to second, median+- sem)')
set(gca, 'XDir','reverse')

k=k+1;
subplot(3,3,k)
for gi=1:length(Groups)
    this_group=Groups{gi};
    y2=[];
    for ki=1:length(Groups{gi})
        y2=[y2; max_values{this_group(ki)}];  
    end
    diff_y2=diff(y2,1,2);
    ph1=plot (log10(intensities(gi)), median(diff_y2(:,2)),['o' g_colors{gi}]); hold on
    ph1.MarkerSize=10;
    sem=std(diff_y2(:,2))/sqrt(length(diff_y2(:,2)));
     ph=line ([log10(intensities(gi)) log10(intensities(gi))], [median(diff_y2(:,2))+sem  median(diff_y2(:,2))-sem]); hold on %,['-' g_colors{gi}]); hold on
     ph.Color=g_colors{gi};
      ph.LineWidth=2;
end
kh=line ([13 16],[0 0]);kh.Color='k';
ylim([-4.5 2])
xlim([13 15.5])
xlabel('Log10 (photon/cm^2/sec)')
ylabel('dF/F Peak difference (second to third, median+- sem)')
set(gca, 'XDir','reverse')

traits_to_plot={'Mean AUC','Max amplitude (a.u.)', 'Rise time (sec)', 'Exponent decay constant (sec-1)','Max/min ratio'};% 
for ti=1:length(traits_to_plot)
    k=k+1;
    clear y sem_y
    subplot(3,3,k)
    for gi=1:length(Groups)
        clear all_y sem_y
        ylim_array=[]
        switch traits_to_plot{ti}
            case 'Mean AUC'
                all_y=all_mean_df(Groups{gi});
                ylim_array=[0 1500];
            case 'Rise time (sec)'
                all_y=mean_delta_t_to_max(Groups{gi});
            case 'Exponent decay constant (sec-1)' 
                all_y=tau{gi};
            case 'Max/min ratio'
                 all_y=mean_ratio_max_to_min(Groups{gi});
            case 'Max amplitude (a.u.)'
                all_y=mean_max_values(Groups{gi});
        end
        y(gi)=mean(all_y);
        sem_y(gi)=std(all_y)/sqrt(length(Groups{gi}));
        ph=line ([log10(intensities(gi)) log10(intensities(gi))], [y(gi)+sem_y(gi)  y(gi)-sem_y(gi)]); hold on %,['-' g_colors{gi}]); hold on
        ph.Color=g_colors{gi}; 
        ph.LineWidth=2;
        ph1=plot (log10(intensities(gi)),y(gi),['o' g_colors{gi}]); hold on 
        ph1.MarkerSize=10;
              
    end
    if ~isempty(ylim_array);     ylim(ylim_array); end
    xlim([13 15.5])
    xlabel('Log10 (photon/cm^2/sec)')
    ylabel(traits_to_plot{ti})
    set(gca, 'XDir','reverse')
end





figure
k=0;
subplot(1,6,k+1)
% arrange data for boxplot
g=[]; x=[]; 
for gi=1:length(Groups)
    x=[x all_mean_df(Groups{gi})];
    g=[g gi*ones(1,length(Groups{gi}))];
        mean_df(gi)=mean(all_mean_df(Groups{gi}));
    sem_df(gi)=std(all_mean_df(Groups{gi}))/sqrt(length(Groups{gi}));

end
boxplot(x,g, ...
    'Labels', states, ...
     'Colors',[0 0 0],'PlotStyle','compact'); 
% for gi=1:length(Groups)
%     bh1=bar(gi,mean(all_mean_df(Groups{gi}))); hold on;
%     bh1.FaceColor=[0.95 0.95 0.95];
% end
% plot([1*ones(1,length(Groups{1})),2*ones(1,length(Groups{2})),3*ones(1,length(Groups{3})),4*ones(1,length(Groups{4}))],[all_mean_df(Groups{1}),all_mean_df(Groups{2}), all_mean_df(Groups{3}),all_mean_df(Groups{4})],'*k'); hold on;
% xticks([1:4])
% xticklabels(states)
ylim([0 800])
xlim([0.5 length(Groups)+0.5])
ylabel('Mean AUC (full)')


subplot(1,6,k+2)
% arrange data for boxplot
g=[]; x=[]; 
for gi=1:length(Groups)
    x=[x mean_int_df_around_max(Groups{gi})];
    g=[g gi*ones(1,length(Groups{gi}))];
end
boxplot(x,g, ...
    'Labels', states, ...
     'Colors',[0 0 0],'PlotStyle','compact'); 
ylim([0 1200])
xlim([0.5 length(Groups)+0.5])
ylabel('Mean AUC around peak')

subplot(1,6,k+3)
% arrange data for boxplot
g=[]; x=[]; 
for gi=1:length(Groups)
    x=[x mean_int_df_last_half(Groups{gi})];
    g=[g gi*ones(1,length(Groups{gi}))];
end
boxplot(x,g, ...
    'Labels', states, ...
     'Colors',[0 0 0],'PlotStyle','compact'); 
ylim([0 1200])
xlim([0.5 length(Groups)+0.5])
ylabel('Mean AUC second half light')

% plot time to peak 
subplot(1,6,k+4)
% arrange data for boxplot
g=[]; x=[]; 
for gi=1:length(Groups)
    x=[x mean_delta_t_to_max(Groups{gi})];
    g=[g gi*ones(1,length(Groups{gi}))];
    mean_delta_t(gi)=mean(mean_delta_t_to_max(Groups{gi}));
    sem_delta_t(gi)=std(mean_delta_t_to_max(Groups{gi}))/sqrt(length(Groups{gi}));
end
boxplot(x,g, ...
    'Labels', states, ...
     'Colors',[0 0 0],'PlotStyle','compact'); 
ylim([0 10])
xlim([0.5 length(Groups)+0.5])
ylabel('Time to peak (sec)')

% plot decay times
subplot(1,6,k+5)
% arrange data for boxplot
g=[]; x=[]; 
for gi=1:length(Groups)
    x=[x tau{gi}];
    g=[g gi*ones(1,length(tau{gi}))];
end
mean_tau=mean(x);
sem_tau=std(x)/sqrt(length(x));
boxplot(x,g, ...
    'Labels', states, ...
     'Colors',[0 0 0],'PlotStyle','compact'); 
%ylim([0 10])
%xlim([0.5 6.5])
ylabel('Exponent decay constant (sec)')


% plot ratio peak to response end integrals (over 4 seconds)
subplot(1,6,k+6)
% arrange data for boxplot
g=[]; x=[]; 
for gi=1:length(Groups)
    x=[x mean_ratio_max_to_last(Groups{gi})];
    g=[g gi*ones(1,length(Groups{gi}))];
    mean_delta_t(gi)=mean(mean_ratio_max_to_last(Groups{gi}));
    sem_delta_t(gi)=std(mean_ratio_max_to_last(Groups{gi}))/sqrt(length(Groups{gi}));
end
boxplot(x,g, ...
    'Labels', states, ...
     'Colors',[0 0 0],'PlotStyle','compact'); 
ylim([0 10])
xlim([0.5 length(Groups)+0.5])
ylabel('Ratio peak/last (int. 4 seconds)')


%% statistical tests: 
% check normality with one sample Kolmogorov-Smirnov test. h=1 means that
% the distribution is NOT normal 
traits_to_check={'mean_delta_t_to_max','all_mean_df', 'tau','mean_ratio_max_to_last'};
for pi=1:length(traits_to_check)
    eval(['data_to_test =' traits_to_check{pi} ';']);
    switch traits_to_check{pi}
        case {'mean_delta_t_to_max','all_mean_df','mean_ratio_max_to_last'}
            g=[]; x=[];
            for gi=1:length(Groups)
                x=[x data_to_test(Groups{gi})];
                g=[g gi*ones(1,length(Groups{gi}))];
            end
        case 'tau'
            g=[]; x=[];
            for gi=1:length(Groups)
                x=[x data_to_test{gi}];
                g=[g gi*ones(1,length(data_to_test{gi}))];
            end
    end
    clear h
    for gi=1:length(unique(g))
        h(gi) = kstest(x(g==3));
    end
    % Kruskal-Wallis Test. An extension of the Wilcoxon rank sum test to more than two groups.
    
    %if sum(h)>2
        figure
        clear p tbl
        [p,tbl,stats]  = kruskalwallis(x,g,'off');
        c2 = multcompare(stats,'CType','hsd');% Tukey's honest significant difference criterion correction 
        c3 = multcompare(stats,'CType','dunn-sidak');

    %end
end
    1