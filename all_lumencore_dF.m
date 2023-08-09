function all_lumencore_dF

exp= 'GCaMP'
%exp='GFP'
%ALL_ID= {'VIPGC113L','VIPGC113Liso'};%,'VIPGCA116R','VIPGC119LL','VIPGC122R','VIPGC123L'};
switch exp
    case 'GCaMP'
        ALL_ID= {'VIPGC106LL','VIPGC113L','VIPGCA116R','VIPGC119LL','VIPGC122R','VIPGC123L'};
        ALL_ID_sex={'M' 'M' 'F' 'F' 'F' 'F' }%'F'};
    case 'GFP'
        ALL_ID={'VIPGFP12R','VIPGFP11RL_R','VIPGFP11RL_L','VIPGFP13LL_R'}%,'
end

% sampling rate
fs=1.0173e+03;

for id=1:length(ALL_ID)   
    [color_names1,MEAN_COLOR_t{id},MEAN_COLOR_dF{id},light_params(id),analysis(id)] = FP_analysis_lumencore(ALL_ID{id});
    diff_sec(id)=light_params(id).diff;
end

colors_bar=[0.4940, 0.1840, 0.5560;0, 0.4470, 0.7410;0 0.9 0.9;0.0000 0.5020 0.5020 ;0, 0.5, 0;0.8500, 0.3250, 0.0980;1, 0, 0];
CHECK_FIG=1

clear this_max_by_color
for ci=1:length(color_names1)
    this_color_L=[];
    all_id_this_color_df=[];
    all_id_this_color_t=[];
    if CHECK_FIG; figure; end
    for idi=1:length(ALL_ID)   
      % plot(MEAN_COLOR_t{idi}{ci}+diff_sec(idi),MEAN_COLOR_dF{idi}{ci})
       hold on
       if diff_sec(idi)>0
            MEAN_COLOR_dF1{idi}{ci}= [MEAN_COLOR_dF{idi}{ci}(1:diff_sec(idi)*fs-1) MEAN_COLOR_dF{idi}{ci}];
            MEAN_COLOR_t1{idi}{ci}= [MEAN_COLOR_t{idi}{ci}(1:diff_sec(idi)*fs-1) MEAN_COLOR_t{idi}{ci}];

       elseif diff_sec(idi)<=0
            MEAN_COLOR_dF1{idi}{ci}= [MEAN_COLOR_dF{idi}{ci}(-diff_sec(idi)*fs:end)];
            MEAN_COLOR_t1{idi}{ci}= [MEAN_COLOR_t{idi}{ci}(-diff_sec(idi)*fs:end)];

       end
       this_color_L=[this_color_L length(MEAN_COLOR_dF1{idi}{ci})];
       if CHECK_FIG; plot(MEAN_COLOR_dF1{idi}{ci});  hold on;  end
       %length(MEAN_COLOR_dF{5}{3})
       
      
    end
    if CHECK_FIG;  title([color_names1{ci} ' all']);  end
    %% put all in one matrix, in order to calculate mean 
    for idi=1:length(ALL_ID)   
       all_id_this_color_df=[all_id_this_color_df; MEAN_COLOR_dF1{idi}{ci}(1:min(this_color_L))];
       all_id_this_color_t=[all_id_this_color_t; MEAN_COLOR_t{idi}{ci}(1:min(this_color_L))];
    end
    
    %% calculate dF response for each animal, for each color
    baseline_index=[2 10]; % 13 seconds before 
    resp_index=[15 23]; % 13 seconds during
    
    %baseline_index=[1 13]; % 12 seconds before 
    %resp_index=[16 28]; % 12 seconds during
  all_peak_intensity=[];
  for idi=1:length(ALL_ID)   
        base_ind=intersect(find(all_id_this_color_t(idi,:)>baseline_index(1)),find(all_id_this_color_t(idi,:)<baseline_index(2)));
        meanBase_this_ID(idi)=nanmean(all_id_this_color_df(idi,base_ind));
        resp_ind=intersect(find(all_id_this_color_t(idi,:)>resp_index(1)),find(all_id_this_color_t(idi,:)<resp_index(2)));
        % calculate the amplitude average to plot response intensity vs.
        % wavelength 
        resp(ci,idi)=nanmean(all_id_this_color_df(idi,resp_ind))-meanBase_this_ID(idi);
       all_peak_intensity=[all_peak_intensity nanmean(analysis(idi).peaks_intensity,2)]; %7 COLORS, 6 REPEATS mean over repeats 
    end
    
     %% calculate P12 and P34 for each animal, for each color
     for idi=1:length(ALL_ID)
         this_max_by_color(idi,:)=analysis(idi).max_values_by_color(ci,:);   
         this_max_by_color_norm(idi,:)=this_max_by_color(idi,:)/max(this_max_by_color(idi,:));
     end
    diff_max=diff(this_max_by_color,1,2); 
    diff_max_p12(ci,:)=diff_max(:,1);% first index is color, second is id 
    diff_max_p23(ci,:)=diff_max(:,2);
    diff_max_p34(ci,:)=diff_max(:,3);
    
    ALL_mean_color_dF{ci}=mean(all_id_this_color_df);
    ALL_mean_color_t{ci}=mean(all_id_this_color_t);
    ALL_mean_color_dF_SEM{ci}=std(all_id_this_color_df)/sqrt(size(all_id_this_color_df,1));
    tmp=(ALL_mean_color_dF{ci}-mean(meanBase_this_ID));
    ALL_mean_color_dF_norm{ci}=tmp/max(tmp);
       % bh=bar(mean_binned_t{phi}{i},mean_binned_df{phi}{i});
        %bh.CData=colors_bar1;
        %bh.FaceColor=colors_bar1;
end

wavelength_str={'395' '438' '473' '513' '560' '586' '650'};

% plot peak change 
clear data_to_plot
data_to_plot{1}=diff_max_p12;
data_to_plot{2}=diff_max_p23;
%data_to_plot{3}=diff_max_p34;
%y_labels={'P12', 'P23', 'P34'};
y_labels={'P12', 'P23'};
figure
for i=1:length(data_to_plot)
    subplot (1,length(data_to_plot),i)
    this_data_to_plot=data_to_plot{i};
    for ci=1:length(color_names1)
        sem=std(this_data_to_plot(ci,:))/sqrt(size(this_data_to_plot,1));
        ph1=plot (ci, median(this_data_to_plot(ci,:)),'ok'); hold on %% first index is color, second is id
        ph1.MarkerSize=10;
        lh=line([ci ci], [median(this_data_to_plot(ci,:))+sem median(this_data_to_plot(ci,:))-sem]);hold on
        lh.Color='k';
    end
    xlim([0.5 size(this_data_to_plot,1)+0.5])
     ylim([-4 4])
    lh2=line([0.5 size(this_data_to_plot,1)+0.5],[0 0]); lh2.Color='k';
    ylabel(y_labels{i})
    xlabel('wavelength (nm)')
    set(gca,'Xtick',[1:7])
    set(gca,'Xticklabel',wavelength_str)
end

% statistics between wavelength 
samples=[1:4];
%samples=[1 2 4 5 6 ];
samples=[1:length(ALL_ID)];
for wi=1:size(diff_max_p12,1)
    [h(wi),p(wi)]=ttest2(diff_max_p12(wi,samples),diff_max_p23(wi,samples));
    pkw(wi) = kruskalwallis([diff_max_p12(wi,samples),diff_max_p23(wi,samples)],[ones(1,length(samples)),2*ones(1,length(samples))],'off');
end

disp (p)
disp(pkw)
wavelength_str

%data_to_plot=all_peak_intensity;% p x w , based on findpeaks function 
data_to_plot=resp; % AUC
% plot response by wavelength
figure
for ci=1:length(color_names1)   
    bh=bar(ci,nanmedian(data_to_plot(ci,:)));
    bh.CData=colors_bar(ci,:);
    bh.FaceColor=colors_bar(ci,:);
    hold on
end
ph=plot([1:7],data_to_plot,'-*k');
ylabel('mean response, dF (z-score)')
xlabel('wavelength (nm)')
set(gca,'Xtick',[1:7])
set(gca,'Xticklabel',wavelength_str)
ylim([-1 1.2*max(max(data_to_plot))])

for ci=1:length(color_names1)   
    disp([ num2str(median(resp(ci,:))) '+-' num2str(std(resp(ci,:))/sqrt(length(resp(ci,:)))) ' at ' wavelength_str{ci}]) ;
end

%% plot the mean values for response 
figure
for ci=1:length(color_names1)    
    ph=plot(ALL_mean_color_t{ci},ALL_mean_color_dF{ci});
    set(ph, 'color', colors_bar(ci,:),'linewidth',6)
    hold on
    ph2=plot(ALL_mean_color_t{ci},ALL_mean_color_dF{ci}+ALL_mean_color_dF_SEM{ci});
    set(ph2, 'color', colors_bar(ci,:),'linewidth',1)
    hold on
     ph3=plot(ALL_mean_color_t{ci},ALL_mean_color_dF{ci}-ALL_mean_color_dF_SEM{ci});
    set(ph3, 'color', colors_bar(ci,:),'linewidth',1)
    hold on
end
xlim([0,45])
ylabel('mean dF (Z-scored)')
xlabel('Time (sec)')
%legend(color_names1)



%% plot the NORM mean values for response 
figure
for ci=1:length(color_names1)    
    ph=plot(ALL_mean_color_t{ci},ALL_mean_color_dF_norm{ci});
    set(ph, 'color', colors_bar(ci,:),'linewidth',6)
    hold on
end
xlim([0,42])
ylim([-0.2,1.2])
ylabel('NORM mean dF (Z-scored)')
xlabel('Time (sec)')
legend(color_names1)

cd('Z:\Anat\Papers_in_work_from_laptop\SCN_VIP_LightResponse')
save(['lumencore_' exp '_resp_SCNVIP'],'resp')
save(['lumencore_' exp '_all_peak_intensity_SCNVIP'],'all_peak_intensity')


