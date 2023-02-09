function get_LDtransition_FP_all
%% this function is used to analyse the time dependent time-series FP data, ZT10-13
% Data is taken with SynapseTDT

%% get experimental information: 
my_path='D:\DATA_Glab\fiberphotometry\LDtransition\';

%%%%%%%%%%%%%%%%%%
%% get experimental information: 
% Females. 1-6
ind=0;
minimum_trials=1;
% females w/o OVX
ind=ind+1; mouse_info{ind}.ID='93N';mouse_info{ind}.side='R';mouse_info{ind}.load_new_trials=1; mouse_info{ind}.sex='Female';%
ind=ind+1; mouse_info{ind}.ID='108L';mouse_info{ind}.side='R';mouse_info{ind}.load_new_trials=1;mouse_info{ind}.sex='Female';
ind=ind+1; mouse_info{ind}.ID='110LL';mouse_info{ind}.side='L';mouse_info{ind}.load_new_trials=1 ;mouse_info{ind}.sex='Female';%
% females with OVX+ OVX with hormones
ind=ind+1; mouse_info{ind}.ID='107R'; mouse_info{ind}.side='R';mouse_info{ind}.load_new_trials=1 ;mouse_info{ind}.sex='Female';
ind=ind+1; mouse_info{ind}.ID='115L'; mouse_info{ind}.side='R';mouse_info{ind}.load_new_trials=1; mouse_info{ind}.sex='Female';
ind=ind+1; mouse_info{ind}.ID='A116R';mouse_info{ind}.side='L';mouse_info{ind}.load_new_trials=1; mouse_info{ind}.sex='Female';
ind=ind+1; mouse_info{ind}.ID='119LL';mouse_info{ind}.side='R';mouse_info{ind}.load_new_trials=1; mouse_info{ind}.sex='Female';%
ind=ind+1; mouse_info{ind}.ID='122R';mouse_info{ind}.side='R';mouse_info{ind}.load_new_trials=1;mouse_info{ind}.sex='Female';
ind=ind+1; mouse_info{ind}.ID='123L';mouse_info{ind}.side='R';mouse_info{ind}.load_new_trials=1 ;mouse_info{ind}.sex='Female';%
ind=ind+1; mouse_info{ind}.ID='128R'; mouse_info{ind}.side='R';mouse_info{ind}.load_new_trials=1 ;mouse_info{ind}.sex='Female';

% % females w/o OVX
%ind=ind+1; mouse_info{ind}.ID='161RR'; mouse_info{ind}.side='R';mouse_info{ind}.load_new_trials=1; mouse_info{ind}.sex='Female';
ind=ind+1; mouse_info{ind}.ID='166R';mouse_info{ind}.side='R';mouse_info{ind}.load_new_trials=1;mouse_info{ind}.sex='Female';
ind=ind+1; mouse_info{ind}.ID='175L';mouse_info{ind}.side='L';mouse_info{ind}.load_new_trials=1 ;mouse_info{ind}.sex='Female';%
ind=ind+1; mouse_info{ind}.ID='176RL'; mouse_info{ind}.side='L';mouse_info{ind}.load_new_trials=1 ;mouse_info{ind}.sex='Female';
ind=ind+1; mouse_info{ind}.ID='198L'; mouse_info{ind}.side='R';mouse_info{ind}.load_new_trials=1; mouse_info{ind}.sex='Female';
ind=ind+1; mouse_info{ind}.ID='200RR'; mouse_info{ind}.side='R';mouse_info{ind}.load_new_trials=1; mouse_info{ind}.sex='Female';
% % 

n_females=ind;
% Males 7-12
% ind=ind+1; mouse_info{ind}.ID='25L'; mouse_info{ind}.side='L'; mouse_info{ind}.load_new_trials=1;mouse_info{ind}.sex='Male'; %male
% ind=ind+1; mouse_info{ind}.ID='60N'; mouse_info{ind}.side='R';mouse_info{ind}.load_new_trials=1;mouse_info{ind}.sex='Male';%male
% ind=ind+1; mouse_info{ind}.ID='62L'; mouse_info{ind}.side='R'; mouse_info{ind}.load_new_trials=1;mouse_info{ind}.sex='Male';%male
% ind=ind+1; mouse_info{ind}.ID='103R';mouse_info{ind}.side='R';mouse_info{ind}.load_new_trials=1;mouse_info{ind}.sex='Male';%male not good
% ind=ind+1; mouse_info{ind}.ID='106LL'; mouse_info{ind}.side='R';mouse_info{ind}.load_new_trials=1;mouse_info{ind}.sex='Male';%male
% %
n_males=ind-n_females;



% get data for each mouse
% for idi=1:length(mouse_info)
%     [output{idi}] = get_time_series_FP_per_mouse (mouse_info{idi});
% end
% get data for each mouse
tic
for idi=1:length(mouse_info)
    mouse_info{idi}.minimum_trials=minimum_trials;
    switch mouse_info{idi}.sex
        case 'Female'
            if ~exist ([my_path 'output_estrous_cycle_' mouse_info{idi}.ID '_MT' num2str(mouse_info{idi}.minimum_trials) '.mat' ])
                disp(['get data for ' mouse_info{idi}.ID])
                output= get_LDtransition_FP_per_mouse (mouse_info{idi});
            else
                load([my_path 'output_estrous_cycle_' mouse_info{idi}.ID '_MT' num2str(mouse_info{idi}.minimum_trials) '.mat' ])% load 'output'
            end
        case {'Male'}
            if ~exist ([my_path 'output_male_female_' mouse_info{idi}.ID '_MT' num2str(mouse_info{idi}.minimum_trials) '.mat' ])
                disp(['get data for ' mouse_info{idi}.ID])
                output = get_LDtransition_FP_per_mouse (mouse_info{idi});
            else 
                load([my_path 'output_male_female_' mouse_info{idi}.ID '_MT' num2str(mouse_info{idi}.minimum_trials) '.mat' ])%all_output{idi}=output;
            end 
    end
    output.new_estrus_states=estrus_to_receptive(output.estrus_states);
    all_output{idi}=output;
end
toc
clear output
output=all_output; 
clear all_output
%%%%%%%%%%%%%%%    
for i=1:length(mouse_info)
    mouse_info{i}.analysis_type='estrous_cycle';
end


L=[];
for idi=1:length(mouse_info)
    L=[L size(output{idi}.mean_dF_over_all_samples,2)];
end

% arrange data
close all
clear med_dF_dark_light_over_estrus_samples med_rate_dark_light_over_estrus_samples nan_array
clear mean_dF_over_all_samples mean_dF_over_estrus_samples mean_dF_by_state mean_rate_over_estrus_samples median_width_over_estrus_samples
clear median_dF_over_all_samples median_dF_over_estrus_samples median_dF_by_state median_rate_over_estrus_samples
full_size=size(output{idi}.mean_rate_over_estrus_samples,2);
for idi=1:length(mouse_info)
    mean_dF_over_all_samples(idi,:,:)=output{idi}.mean_dF_over_all_samples(:,1:min(L));
    % median_dF_over_all_samples(idi,:,:)=output{idi}.median_dF_over_all_samples(:,1:min(L));
    
    mean_dF_over_estrus_samples(idi,:,:,:)=output{idi}.mean_dF_over_estrus_samples(:,:,1:min(L));% ID, estrus, hour, time
    %median_dF_over_estrus_samples(idi,:,:,:)=output{idi}.median_dF_over_estrus_samples(:,:,1:min(L));% ID, estrus, hour, time
    
    tmp_mean_dF_by_state(idi,:,:)=output{idi}.mean_dF_by_state;% ID, estrus, hour
    tmp_mean_rate_over_estrus_samples(idi,:,:)=output{idi}.mean_rate_over_estrus_samples;% ID, estrus, hour
    %     mean_width_over_estrus_samples(idi,:,:)=output{idi}.mean_width_over_estrus_samples;% ID, estrus, hour
    
    %median_dF_by_state(idi,:,:)=output{idi}.median_dF_by_state;% ID, estrus, hour
    % median_rate_over_estrus_samples(idi,:,:)=output{idi}.median_rate_over_estrus_samples;% ID, estrus, hour
    % median_width_over_estrus_samples(idi,:,:)=output{idi}.median_width_over_estrus_samples;% ID, estrus, hour
    
    tmp_med_dF_dark_light_over_estrus_samples(idi,:,:)=output{idi}.mean_dF_dark_light;% ID, estrus/dark/light
    tmp_med_rate_dark_light_over_estrus_samples(idi,:,:)=output{idi}.mean_rate_dark_light;% ID,  estrus/dark/light
    %     med_width_dark_light_over_estrus_samples(idi,:)=output{idi}.median_width_dark_light;% ID,  estrus/dark/light
end

clear med_dF_dark_light_over_estrus_samples med_rate_dark_light_over_estrus_samples med_width_dark_light_over_estrus_samples
clear tmp_med_dF_dark_light_over_estrus_samples tmp_med_rate_dark_light_over_estrus_samples mean_dF_by_state mean_rate_over_estrus_samples
for idi=1:length(mouse_info)
    disp(mouse_info{idi}.ID)
    unique(output{idi}.estrus_states)
    % 
    tmp_med_dF_dark_light_over_estrus_samples(idi,:,:)=output{idi}.mean_dF_dark_light;% ID, estrus/dark/light
    tmp_med_rate_dark_light_over_estrus_samples(idi,:,:)=output{idi}.mean_rate_dark_light;% ID,  estrus/dark/light
   % med_width_dark_light_over_estrus_samples(idi,:,:)=output{idi}.mean_width_dark_light;% ID,  estrus/dark/light

end

% decide here which states to plot
%states_to_plot='by_days';
%states_to_plot='by_estrous_no_treatment';
states_to_plot='by_estrous_with_treatment';
estrus_states_titles={'P-2','P-1','P+0','P+1','P+2','OVX','OVX+PR','OVX+Esr'};
switch states_to_plot
    case 'by_days'
        estrus_states_titles=estrus_states_titles;
        med_dF_dark_light_over_estrus_samples=tmp_med_dF_dark_light_over_estrus_samples;
        mean_dF_by_state=tmp_mean_dF_by_state;
        mean_rate_over_estrus_samples=tmp_mean_rate_over_estrus_samples;
    case {'by_estrous_no_treatment','by_estrous_with_treatment'}
        old_estrus_states_titles=estrus_states_titles;
        MD_ind=find(strcmp(old_estrus_states_titles,'P-2')+strcmp(old_estrus_states_titles,'P-1'));
        P_ind=find(strcmp(old_estrus_states_titles,'P+0'));
        E_ind=find(strcmp(old_estrus_states_titles,'P+1'));
        OVX_ind=find(strcmp(old_estrus_states_titles,'OVX'));
        estrus_states_titles={'M','P','E','OVX'};
        for idi=1:length(mouse_info)
            % dF
            med_dF_dark_light_over_estrus_samples(idi,1,:)=nanmean(tmp_med_dF_dark_light_over_estrus_samples(idi,MD_ind,:),2);
            med_dF_dark_light_over_estrus_samples(idi,2,:)=tmp_med_dF_dark_light_over_estrus_samples(idi,P_ind,:);
            med_dF_dark_light_over_estrus_samples(idi,3,:)=tmp_med_dF_dark_light_over_estrus_samples(idi,E_ind,:); 
            med_dF_dark_light_over_estrus_samples(idi,4,:)=tmp_med_dF_dark_light_over_estrus_samples(idi,OVX_ind,:); 
           %  rates
            med_rate_dark_light_over_estrus_samples(idi,1,:)=nanmean(tmp_med_rate_dark_light_over_estrus_samples(idi,MD_ind,:),2);
            med_rate_dark_light_over_estrus_samples(idi,2,:)=tmp_med_rate_dark_light_over_estrus_samples(idi,P_ind,:);
            med_rate_dark_light_over_estrus_samples(idi,3,:)=tmp_med_rate_dark_light_over_estrus_samples(idi,E_ind,:); 
            med_rate_dark_light_over_estrus_samples(idi,4,:)=tmp_med_rate_dark_light_over_estrus_samples(idi,OVX_ind,:); 
            
            mean_dF_by_state(idi,1,:)=nanmean(tmp_mean_dF_by_state(idi,MD_ind,:),2);
            mean_dF_by_state(idi,2,:)=tmp_mean_dF_by_state(idi,P_ind,:);
            mean_dF_by_state(idi,3,:)=tmp_mean_dF_by_state(idi,E_ind,:); 
            mean_dF_by_state(idi,4,:)=tmp_mean_dF_by_state(idi,OVX_ind,:); 
            
            mean_rate_over_estrus_samples(idi,1,:)=nanmean(tmp_mean_rate_over_estrus_samples(idi,MD_ind,:),2);
            mean_rate_over_estrus_samples(idi,2,:)=tmp_mean_rate_over_estrus_samples(idi,P_ind,:);
            mean_rate_over_estrus_samples(idi,3,:)=tmp_mean_rate_over_estrus_samples(idi,E_ind,:); 
            mean_rate_over_estrus_samples(idi,4,:)=tmp_mean_rate_over_estrus_samples(idi,OVX_ind,:); 

        end% add treatment 
        if strcmp(states_to_plot,'by_estrous_with_treatment')
     
            estrus_states_titles={'M','P','E','OVX','OVX+Esr' ,'OVX+PR'};
            OVX_E_ind=find(strcmp(old_estrus_states_titles,'OVX+Esr'));
            OVX_P_ind=find(strcmp(old_estrus_states_titles,'OVX+PR'));
            for idi=1:length(mouse_info)
                med_dF_dark_light_over_estrus_samples(idi,5,:)=tmp_med_dF_dark_light_over_estrus_samples(idi,OVX_E_ind,:);
                med_dF_dark_light_over_estrus_samples(idi,6,:)=tmp_med_dF_dark_light_over_estrus_samples(idi,OVX_P_ind,:);
                %  rates
                med_rate_dark_light_over_estrus_samples(idi,5,:)=tmp_med_rate_dark_light_over_estrus_samples(idi,OVX_E_ind,:);
                med_rate_dark_light_over_estrus_samples(idi,6,:)=tmp_med_rate_dark_light_over_estrus_samples(idi,OVX_P_ind,:);
                
                mean_dF_by_state(idi,5,:)=tmp_mean_dF_by_state(idi,OVX_E_ind,:);
                mean_dF_by_state(idi,6,:)=tmp_mean_dF_by_state(idi,OVX_P_ind,:);
                
                mean_rate_over_estrus_samples(idi,5,:)=tmp_mean_rate_over_estrus_samples(idi,OVX_E_ind,:);
                mean_rate_over_estrus_samples(idi,6,:)=tmp_mean_rate_over_estrus_samples(idi,OVX_P_ind,:);
            end
        end
end

[ALL_colors,color_ind]=get_estrus_colors(estrus_states_titles);
%average over M/D which are P-2 and P-1

% average property over specific time window
% results an array of ID, estrus
clear med_dF_over_estrus_samples_window med_rate_over_estrus_samples_window med_width_over_estrus_samples_window

CF=0.8/length(mouse_info);% color factor
%full_time_estrus_states_titles={'P-2 D','P-1 L','P-1 D','P+0 L','P+0 D','P+1 L','P+1 D','P+2 L','P+2 D' 'OVX L', 'OVX D'};

% test the results 
light_phase=2
figure
subplot(1,3,1)
for idi=1:length(mouse_info)
    plot(med_dF_dark_light_over_estrus_samples(idi,:,light_phase)); hold on
end
ylabel('df')
subplot(1,3,2)
for idi=1:length(mouse_info)
    plot(med_rate_dark_light_over_estrus_samples(idi,:,light_phase)); hold on
end
ylabel('rate')
% subplot(1,3,3)
% for idi=1:length(mouse_info)
%     plot(med_width_dark_light_over_estrus_samples(idi,:)); hold on
% end
% ylabel('width')


% statistics
clear c_dF c_r
for k=1:3
    figure; [p,tbl,stats] = kruskalwallis(med_dF_dark_light_over_estrus_samples(:,:,k),[],'off');
    c_dF{k}= multcompare(stats,'CType','hsd');% Tukey's honest significant difference criterion correction
    figure; [p,tbl,stats_r] = kruskalwallis(med_rate_dark_light_over_estrus_samples(:,:,k),[],'off');
    c_r{k} = multcompare(stats_r,'CType','hsd');
    c_r{k}(:,7)=c_r{k}(:,6)<0.05;
%     figure; [p,tbl,stats_w] = kruskalwallis(med_width_dark_light_over_estrus_samples(:,:,k),[],'off');
%     c_w = multcompare(stats_w,'CType','hsd');
end
% plot the median dF and rate over light/dark
%dF
data_to_plot_names={'med_dF_dark_light_over_estrus_samples', 'med_rate_dark_light_over_estrus_samples'};
ZTs={'10' '11' '12'}; YLIMs=[7 2]; YLABELs={'Median dF (a.u.)' ,'Median event rates (events/min)'};
for pi=1:length(data_to_plot_names)
    eval(['data_to_plot=' data_to_plot_names{pi} ';']);
    figure
    for k=1:3
        subplot(1,3,k)
        bar(nanmedian(data_to_plot(:,:,k))); hold on;
        for idi=1:length(mouse_info)
            lh1=plot(data_to_plot(idi,:,k),'.'); hold on;
            set(lh1,'Color', [CF*idi CF*idi CF*idi])
        end
        xticklabels(estrus_states_titles)
        ylabel (YLABELs{pi})
        ylim([0 YLIMs(pi)])
        title (['ZT ' ZTs{k}])
    end
end

%% plot dF and rates all states 
data_to_plot_names={'mean_dF_by_state','mean_rate_over_estrus_samples'};
YLIMs=[12 1.7]; YLABELs={'Mean dF (a.u.)' ,'Mean event rates (events/min)'};
for pi=1:length(data_to_plot_names)
    eval(['data_to_plot=' data_to_plot_names{pi} ';']);
    figure
    % plot mean rates/dF
    for sti=1:length(estrus_states_titles)
        subplot(length(estrus_states_titles),1,sti)
        tmp(:)=nanmedian(data_to_plot(:,sti,:));
         tmp_sem(:)=nanstd(data_to_plot(:,sti,:))/sqrt(length(mouse_info));
        lh=bar(tmp); hold on
        set(lh,'FaceColor', ALL_colors(color_ind(sti),:))
        % plot each dot 
        for idi=1:length(mouse_info)
            tmp3(:)=data_to_plot(idi,sti,:);
            lh=plot(tmp3,'.'); hold on
            set(lh,'Color', [0 0 0])
        end
        % plot sem 
        for ihi=1:length(tmp) 
            lh2=line([ihi ihi],[tmp(ihi)-tmp_sem(ihi) tmp(ihi)+tmp_sem(ihi)]); hold on
            set(lh2,'Color', [0 0 0])
        end
        title (estrus_states_titles{sti})
        ylabel (YLABELs{pi})
        ylim([0 YLIMs(pi)])
    end
    legend (estrus_states_titles)
end
% 
% % arrange data to plot by receptive state
% receptive_ind=[1 ,2; 3 ,5; 6 6; 7 7; 8 8];
% receptive_states_titles={'NR','RE','OVX','OVX+PR','OVX+Esr'};
% [ALL_colors,rec_color_ind]=get_estrus_colors(receptive_states_titles);
% for pi=1:size(receptive_ind,1)
%     mean_dF_by_receptive(:,pi,:)=mean(mean_dF_by_state(:,receptive_ind(pi,1):receptive_ind(pi,2),:),2);
%     mean_rate_over_receptive(:,pi,:)=mean(mean_rate_over_estrus_samples(:,receptive_ind(pi,1):receptive_ind(pi,2),:),2);
% end
% 
% %% plot dF and rates by receptive 
% data_to_plot_names={'mean_dF_by_receptive','mean_rate_over_receptive'};
% YLIMs=[12 1.7]; YLABELs={'Mean dF (a.u.)' ,'Mean event rates (events/min)'};
% for pi=1:length(data_to_plot_names)
%     eval(['data_to_plot=' data_to_plot_names{pi} ';']);
%     figure
%     % plot mean rates/dF
%     for sti=1:length(receptive_states_titles)
%         subplot(length(receptive_states_titles),1,sti)
%         tmp(:)=nanmedian(data_to_plot(:,sti,:));
%         lh=bar(tmp); hold on
%         set(lh,'FaceColor', ALL_colors(rec_color_ind(sti),:))
%         for idi=1:length(mouse_info)
%             tmp(:)=data_to_plot(idi,sti,:);
%             lh=plot(tmp,'.'); hold on
%             set(lh,'Color', [0.7 0.7 0.7])
%         end
%         title (receptive_states_titles{sti})
%         ylabel (YLABELs{pi})
%         ylim([0 YLIMs(pi)])
%     end
%     legend (receptive_states_titles)
% end

% 
% % statistics
% clear c_dF2 c_r2 c_dF22
% c_dF22=[]; c_r22=[];
% for k=[1:3,7:18]
%     figure; [p,tbl,stats] = kruskalwallis(mean_dF_by_receptive(:,:,k),[],'off');
%     c_dF2= multcompare(stats,'CType','hsd');% Tukey's honest significant difference criterion correction
%     tmp2=cat(2, c_dF2,c_dF2(:,6)<0.05);
%     c_dF22=[c_dF22; cat(2,tmp2,k*ones(size(c_dF2,1),1))];
%    clear tmp2
%     figure; [p,tbl,stats_r] = kruskalwallis(mean_rate_over_receptive(:,:,k),[],'off');
%     c_r2 = multcompare(stats_r,'CType','hsd');
%     tmp2=cat(2, c_r2,c_r2(:,6)<0.05);
%     c_r22=[c_r22; cat(2,tmp2,k*ones(size(c_r2,1),1))];
% %     figure; [p,tbl,stats_w] = kruskalwallis(med_width_dark_light_over_estrus_samples(:,:,k),[],'off');
% %     c_w = multcompare(stats_w,'CType','hsd');
% end


%% plot specific window data
clear lh1
dF_to_plot=mean_dF_by_state;
rate_to_plot=mean_rate_over_estrus_samples;
titles_str=estrus_states_titles;
color_ind2=color_ind;

%width_to_plot=median_width_over_estrus_samples;
clear med_dF_over_estrus_samples_window med_rate_over_estrus_samples_window mean_dF_over_estrus_samples_window mean_rate_over_estrus_samples_window c_r2
% for paper I used window=i, i=2
for i=[1]
    window=[i:i+2];% ZT10 only
    %window=[i:i+2,i+6:i+11];%all the light phase 
    med_dF_over_estrus_samples_window(:,:)=nanmedian(dF_to_plot(:,:,window),3);% ID, estrus, hour
    med_rate_over_estrus_samples_window(:,:)=nanmedian(rate_to_plot(:,:,window),3);% ID, estrus, hour
    %med_width_over_estrus_samples_window(:,:)=nanmedian(width_to_plot(:,:,window),3);% ID, estrus, hour
    
    mean_dF_over_estrus_samples_window(:,:)=nanmean(dF_to_plot(:,:,window),3);% ID, estrus, hour
    mean_rate_over_estrus_samples_window(:,:)=nanmean(rate_to_plot(:,:,window),3);% ID, estrus, hour
    %mean_width_over_estrus_samples_window(:,:)=nanmean(width_to_plot(:,:,window),3);% ID, estrus, hour
    
    %%% pay attaention here - median or mean?
    %med_rate_over_estrus_samples_window=med_rate_over_estrus_samples_window([1,2,4:6],:);
    %med_dF_over_estrus_samples_window=med_dF_over_estrus_samples_window([1,2,4:6],:);
    figure
    subplot(2,1,1)
    %bar(nanmedian(mean_dF_over_estrus_samples_window)); hold on;
    for sti=1:length(color_ind2)
        tmp4=mean_dF_over_estrus_samples_window(:,sti);
        tmp4_sem=nanstd(tmp4)/sqrt(length(find(~isnan(tmp4))));
        bh=bar(sti, nanmedian(tmp4)); hold on;
        set(bh,'FaceColor', ALL_colors(color_ind2(sti),:))
        lh=line([sti sti],[nanmedian(tmp4)+tmp4_sem nanmedian(tmp4)-tmp4_sem ]);
        lh.Color='k';
    end
    for idi=1:size(med_dF_over_estrus_samples_window,1)
        lh1=plot(med_dF_over_estrus_samples_window(idi,:),'*'); hold on;
        set(lh1,'Color', [CF*idi CF*idi CF*idi])
    end
    xticks([1:length(color_ind2)])
    xticklabels(titles_str)
    ylim([0 12])
    ylabel ('median/mean dF')
    title(['window : ' num2str(window(1)) ' to ' num2str(window(end))])
    %rates
    subplot(2,1,2)
    %bar(nanmedian(med_rate_over_estrus_samples_window)); hold on;
    for sti=1:length(color_ind2)
        bh=bar(sti, nanmedian(med_rate_over_estrus_samples_window(:,sti))); hold on;
        set(bh,'FaceColor', ALL_colors(color_ind2(sti),:))
        tmp4=med_rate_over_estrus_samples_window(:,sti);
        tmp4_sem=nanstd(tmp4)/sqrt(length(find(~isnan(tmp4))));
        lh=line([sti sti],[nanmedian(tmp4)+tmp4_sem nanmedian(tmp4)-tmp4_sem ]);
        lh.Color='k';
        disp([titles_str{sti} ' median rate is ' num2str(nanmedian(tmp4)) '+-' num2str(tmp4_sem) ' events/min '])
    end
    for idi=1:size(med_rate_over_estrus_samples_window,1)
        lh1=plot(med_rate_over_estrus_samples_window(idi,:),'*'); hold on;
        set(lh1,'Color', [CF*idi CF*idi CF*idi])
    end
    xticks([1:length(color_ind2)])
    xticklabels(titles_str)
    ylim([0 1.7])
    ylabel ('median/mean rates')
    title(['window : ' num2str(window(1)) ' to ' num2str(window(end))])
    
    
    % statistics
    %if i==2
    % rate
    figure; [p1,tbl,stats_r] = kruskalwallis(med_rate_over_estrus_samples_window,[],'off');
    c_r2{i} = multcompare(stats_r,'CType','hsd');
    
    % dF
     figure; [p1,tbl,stats_f] = kruskalwallis(med_dF_over_estrus_samples_window,[],'off');
    c_f2{i} = multcompare(stats_f,'CType','hsd');
    %receptive_states_titles
    %estrus_states_titles
    % estr
    %ind1=2; ind2=4;
    for ind1=1:size(med_rate_over_estrus_samples_window,2)
        for ind2=ind1:size(med_rate_over_estrus_samples_window,2)
            a1=rmmissing(med_rate_over_estrus_samples_window(:,ind1));
            a2=rmmissing(med_rate_over_estrus_samples_window(:,ind2));
            n1=lillietest(a1);
            n2=lillietest(a2);
            if sum([n1,n2])==0
                [h,sig,ci] = ttest2(a1,a2);
                if h==1; disp (['States ' titles_str{ind1} ' and ' titles_str{ind2} ' are significanlty different, P= ' num2str(sig)]); end
            else
                disp('not normal distribution')
            end
        end
    end
   
    %end
end
1


