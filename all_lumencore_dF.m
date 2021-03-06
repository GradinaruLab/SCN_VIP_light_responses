function all_lumencore_dF

exp= 'GCaMP'
%ALL_ID= {'VIPGC113L','VIPGC113Liso'};%,'VIPGCA116R','VIPGC119LL','VIPGC122R','VIPGC123L'};
switch exp
    case 'GCaMP'
        ALL_ID= {'VIPGC106LL','VIPGC113L','VIPGCA116R','VIPGC119LL','VIPGC122R','VIPGC123L'};%,'VIPGCA116R','VIPGC119LL','VIPGC122R','VIPGC123L'};
    case 'GFP'
        ALL_ID={'VIPGFP12R','VIPGFP14RL'};
end

% sampling rate
fs=1.0173e+03;

for id=1:length(ALL_ID)   
    [color_names1,MEAN_COLOR_t{id},MEAN_COLOR_dF{id},diff_sec(id)] = FP_analysis_lumencore(ALL_ID{id});
end

colors_bar=[0.4940, 0.1840, 0.5560;0, 0.4470, 0.7410;0 0.9 0.9;0.0000 0.5020 0.5020 ;0, 0.5, 0;0.8500, 0.3250, 0.0980;1, 0, 0];
CHECK_FIG=1


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
    for idi=1:length(ALL_ID)   
        base_ind=intersect(find(all_id_this_color_t(idi,:)>3),find(all_id_this_color_t(idi,:)<14));
        meanBase_this_ID(idi)=mean(all_id_this_color_df(idi,base_ind));
        resp_ind=intersect(find(all_id_this_color_t(idi,:)>15),find(all_id_this_color_t(idi,:)<28));
        resp(ci,idi)=mean(all_id_this_color_df(idi,resp_ind))-meanBase_this_ID(idi);
    end
    
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
% plot response by wavelength
figure
for ci=1:length(color_names1)   
    bh=bar(ci,mean(resp(ci,:)));
    bh.CData=colors_bar(ci,:);
    bh.FaceColor=colors_bar(ci,:);
    hold on
end
ph=plot([1:7],resp,'-*k');
ylabel('mean response, dF (z-score)')
xlabel('wavelength (nm)')
set(gca,'Xtick',[1:7])
set(gca,'Xticklabel',wavelength_str)
ylim([-1 9])

for ci=1:length(color_names1)   
    disp([ num2str(mean(resp(ci,:))) '+-' num2str(std(resp(ci,:))/sqrt(length(resp(ci,:)))) ' at ' wavelength_str{ci}]) ;
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
xlim([8,42])
ylim([-0.2,1.2])
ylabel('NORM mean dF (Z-scored)')
xlabel('Time (sec)')
legend(color_names1)

switch exp
    case 'GCaMP'
save('lumencore_GCaMP_responses_SCNVIP','resp')
end

