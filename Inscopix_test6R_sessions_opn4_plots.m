function  Inscopix_test6R_sessions_opn4_plots
%% after gathering the data with: 
%get_Inscopix_test6R_sessions_opn4
% plot and do statistical tests
cd ('D:\DATA_Glab\Inscopix\Inscopix_Projects\SCNVIP_test6R_blue_opn4antagonist')
clear t dF all_dF
load('trial_info');
load('cell_info');
N=trial_info.N_6R_sessions;
all= '_all';
baseline_method=1;
n_clustering=3 ;%
all_cells=1;
% reload data
for i=1:N
    load(['all_cell_df_sess' num2str(i) all '_B' num2str(baseline_method)]);
    load(['all_cell_t' num2str(i) all '_B' num2str(baseline_method)]);
    load_all_cell_dF{i}=all_cell_dF;
    load_all_cell_t{i}=all_cell_t;
end
if n_clustering==3 && baseline_method==1 % 
    %sess1- blue light before,
    %kmeans: 
    clustering(1,:)=[2, 2, 0, 1, 2, 1, 2, 0, 2, 2, 2, 0, 1, 1, 2, 1, 2, 2, 0, 1, 2, 2,...
       2, 0, 2, 0, 0, 0, 2, 2, 0, 2, 2, 0, 0, 0, 2, 0, 2, 0, 2, 0, 0, 2,...
       2, 2, 0, 2, 2, 0, 0, 2, 0, 2, 2, 0, 2, 2, 2, 2, 0, 0, 2, 0, 0, 0,...
       0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 2, 1, 0, 2];
     cluster_order(1,:)=[3 1 2]; % 1 is noise, so placed in the third place 
end
% select only the non-noise, based on clustering 
if all_cells
    loaded_cell_dF=load_all_cell_dF;
else
    non_noise=union(find(clustering(1,:)==1),find((clustering(1,:)==0)));
    for i=1:N
        loaded_cell_dF{i}=load_all_cell_dF{i}(non_noise,:,:);
    end
end

% first look at averaged signal over cells. (as if it was FP)
figure_params(1).background=[0.8 0.8 0.8]; figure_params(2).background=[0.8 0.8 0.8]; 
figure_params(1).line='-'; figure_params(2).line='--';
t(:)=load_all_cell_t{1}(1,1,:);
figure
subplot(1,2,1)
for i=1:N % looking at mean over cells, just the first light stimulus
    clear sem dF
    mean_over_cells(:,:)=mean(loaded_cell_dF{i},1);
    dF=mean_over_cells(1,:); 
    sem_over_cells(:,:)=std(loaded_cell_dF{i},1)/sqrt(size(loaded_cell_dF{1},1));
    sem=sem_over_cells(1,:);
    dF=dF-mean(dF(1:10*trial_info.fs)); % normalize to the first 10 seconds 
    sem=sem-mean(dF(1:10*trial_info.fs)); % normalize to the first 10 seconds 
    plot_curve_with_SEM(t,dF/max(dF),sem/max(dF),figure_params(i))
   N_all_dF{i}=dF/max(dF);
end
plot(t,N_all_dF{2}-N_all_dF{1})
title('First light stimulus')
xlabel('Time(sec)'); ylabel('mean dF/F (normalized)')
legend({'before', 'after'})
xlim([0 45]); ylim([-0.2 1.4])


subplot(1,2,2)
for i=1:N % looking at mean over cells, over light stimulus
    mean_over_cells(:,:)=mean(loaded_cell_dF{i},1);
    dF=mean(mean_over_cells,1); 
    sem=std(mean_over_cells,1)/sqrt(size(mean_over_cells,1));
    dF=dF-mean(dF(1:10*trial_info.fs)); % normalize to the first 10 seconds 
    sem=sem-mean(dF(1:10*trial_info.fs)); % normalize to the first 10 seconds
    plot_curve_with_SEM(t,dF/max(dF),sem/max(dF),figure_params(i))
    N_all_dF{i}=dF/max(dF);
end
plot(t,N_all_dF{2}-N_all_dF{1})
title('Mean over light stimulus')
xlabel('Time(sec)'); ylabel('mean dF/F (normalized)')
legend({'before', 'after'})
xlim([0 45]); ylim([-0.2 1.4])

% statistical test
for i=1:N % looking at mean over cells, over light stimulus
    mean_over_cells(:,:)=mean(loaded_cell_dF{i},1);
    dF=mean(mean_over_cells,1); 
    sem=std(mean_over_cells,1)/sqrt(size(mean_over_cells,1));
    all_dF{i}=dF-mean(dF(1:10*trial_info.fs)); % normalize to the first 10 seconds 
end

% check significancy with a sliding window\
clear hl pk h p 
num_sec=3; % window length in sec 
d_sec=10;% dark period, in sec
window_length=trial_info.fs*num_sec; % window length in index
k=0; 
% define time windows to test significance 
delta_t=trial_info.fs*15:trial_info.fs*1:(length(t)-5*trial_info.fs);
% average over repeats, to compare different time windows
mean_over_repeats{1}(:,:)=mean(loaded_cell_dF{1},2);
mean_over_repeats{2}(:,:)=mean(loaded_cell_dF{2},2);
for ci=1:size(mean_over_repeats{1},1)
    % remove background (first ten seconds - considered as dark)
    
    mean_over_repeats{1}(ci,:)=mean_over_repeats{1}(ci,:)-mean(mean_over_repeats{1}(ci,1:d_sec*trial_info.fs));
    mean_over_repeats{2}(ci,:)=mean_over_repeats{2}(ci,:)-mean(mean_over_repeats{2}(ci,1:d_sec*trial_info.fs));
    % normalize
    N_mean_over_repeats{1}(ci,:)=mean_over_repeats{1}(ci,:)/max(mean_over_repeats{1}(ci,:));
    N_mean_over_repeats{2}(ci,:)=mean_over_repeats{2}(ci,:)/max(mean_over_repeats{2}(ci,:));
end
figure; plot(t, N_mean_over_repeats{1}'); ylim([-0.15 1.05])
figure; plot(t, N_mean_over_repeats{2}'); ylim([-0.15 1.05])
% statistics at the population level 
for ti=delta_t % start step is 1 seconds 
    k=k+1;
    time_window_mean_dF{1}=mean(N_mean_over_repeats{1}(:,ti:ti+window_length),2);
    time_window_mean_dF{2}=mean(N_mean_over_repeats{2}(:,ti:ti+window_length),2);
    % check normality 
    hl(1,k)=lillietest(time_window_mean_dF{1});
    hl(2,k)=lillietest(time_window_mean_dF{2});
    if hl(1,k)==1 && hl(2,k)==1 
        [h(k),p(k)]=ttest2(time_window_mean_dF{1},time_window_mean_dF{2});
    end
    [pk(1,k),~,stats{k}]=kruskalwallis([time_window_mean_dF{1}; time_window_mean_dF{2}],[1*ones(length(time_window_mean_dF{1}),1); 2*ones(length(time_window_mean_dF{1}),1)],'off');
    pk(2,k)=pk(1,k)<0.05;
end

delta_t(find(pk(2,:)))/trial_info.fs



% plot mean over 6 repeats, before and after opn4
clear figure_params
k2=0;
L=size(loaded_cell_dF{1},1);
specific_cells_for_figure=[1,17,20,55,84];
L=length(specific_cells_for_figure);
figure
%for ci=1:L
for ci=specific_cells_for_figure % to show a few examples
    k2=k2+1;
    subplot(ceil(L/5),5,k2)
    y2(:,:)=loaded_cell_dF{1}(ci,:,:);     mean_dF{1}(:)=mean(y2,1);     sem_dF{1}(:)=std(y2,1)/sqrt(size(y2,1));
    y2(:,:)=loaded_cell_dF{2}(ci,:,:);     mean_dF{2}(:)=mean(y2,1);     sem_dF{2}(:)=std(y2,1)/sqrt(size(y2,1));
    
    mean_dF{1}=mean_dF{1}-mean(mean_dF{1}(1:d_sec*trial_info.fs));
    y{1}=mean_dF{1}/max(mean_dF{1});   SEM=sem_dF{1}/max(mean_dF{1});
    figure_params.background=[0 0 0]; figure_params.line='-';
    plot_curve_with_SEM(t,y{1},SEM,figure_params)
    
    mean_dF{2}=mean_dF{2}-mean(mean_dF{2}(1:d_sec*trial_info.fs));
    y{2}=mean_dF{2}/max(mean_dF{2});   SEM=sem_dF{2}/max(mean_dF{2});
    figure_params.background=[0.5 0.5 0.5]; figure_params.line='--';
    plot_curve_with_SEM(t,y{2},SEM,figure_params)
    
    % statistical test
    clear pk h p
    k=0;
    for ti=delta_t % start step is 1 seconds
        k=k+1;
        time_window_y{1}=y{1}(:,ti:ti+window_length);
        time_window_y{2}=y{2}(:,ti:ti+window_length);
        % check normality
        hl(1,k)=lillietest(time_window_y{1});
        hl(2,k)=lillietest(time_window_y{2});
        if hl(1,k)==1 && hl(2,k)==1
            [h(k),p(k)]=ttest2(time_window_y{1},time_window_y{2});
        end
        [pk(1,k),~,stats{k}]=kruskalwallis([time_window_y{1} time_window_y{2}]',[1*ones(length(time_window_y{1}),1); 2*ones(length(time_window_y{2}),1)],'off');
        pk(2,k)=pk(1,k)<0.05;
    end
    ylim([-0.2 1.4])
    title([cell_info(ci).mouse_ID ' ' num2str(cell_info(ci).cell_ID) ' # sign. windows ' num2str(sum(pk(2,:)))  ])
end


    
1