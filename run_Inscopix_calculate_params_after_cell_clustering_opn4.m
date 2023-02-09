function run_Inscopix_calculate_params_after_cell_clustering_opn4
% Light response paper Jan 2023- blue light 
% after test6R single cell data is clustered (Pegah Kassraian/Alex Wang), some
% parameters are calculated and presented 
clear all_cell_dF all_cell_t

mypath='D:\DATA_Glab\Inscopix\Inscopix_Projects\SCNVIP_test6R_blue_opn4antagonist';
n_clustering=3; %  used in paper
baseline_method=1;% 
%baseline_method=2;% 2 used in paper
individual_clustering=0; 
if individual_clustering==0 %ref_cluster should be set up.
    ref_cluster=1;
end
fs=5;
all='_all' % includes all cells and allow the clusering to get rid of noise 

% 1 - blue, before opn4. 2 - blue, after opn4
cluster_data.all_sess_ind=[1:2];
if n_clustering==2 && baseline_method==2
    %sess1- blue light before,
    clustering(1,:)=[0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 0,...
       1, 1, 0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0,...
       0, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0,...
       1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 0];
    cluster_order(1,:)=[2 1];
    % Sess2:- blue light after - this is just a copy of sess1 indexes
    clustering(2,:)=[0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 0,...
       1, 1, 0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0,...
       0, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0,...
       1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 0];
    cluster_order(2,:)=[1 2];
end
if n_clustering==2 && baseline_method==1 % temporary - until Alex give me results 01/25/23
    %sess1- blue light before,
    %kmeans: 
    clustering(1,:)=[1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1,...
        1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0,...
        0, 0, 1, 1, 0, 1];
     cluster_order(1,:)=[2 1];
    % gaussian mixture: 
%         clustering(1,:)=[1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1,...
%        1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0,...
%        0, 0, 0, 1, 0, 1];
%     cluster_order(1,:)=[2 1];
    % Sess2:- blue light, after
      %kmeans: 
    clustering(2,:)=[1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0,...
        0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1,...
        0, 1, 0, 1, 1, 0];
    % using the same clustering as sess1, so compare before and after :
    clustering(2,:)=[1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1,...
        1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0,...
        0, 0, 1, 1, 0, 1];
    cluster_order(2,:)=[2 1];
     % gaussian mixture: 
%     clustering(2,:)=[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0,...
%        0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0,...
%        0, 1, 0, 0, 1, 0];
%    cluster_order(2,:)=[1 2];
end
if n_clustering==3 && baseline_method==1 % 
    %sess1- blue light before,
    %kmeans: 
    clustering(1,:)=[2, 2, 0, 1, 2, 1, 2, 0, 2, 2, 2, 0, 1, 1, 2, 1, 2, 2, 0, 1, 2, 2,...
       2, 0, 2, 0, 0, 0, 2, 2, 0, 2, 2, 0, 0, 0, 2, 0, 2, 0, 2, 0, 0, 2,...
       2, 2, 0, 2, 2, 0, 0, 2, 0, 2, 2, 0, 2, 2, 2, 2, 0, 0, 2, 0, 0, 0,...
       0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 2, 1, 0, 2];
     cluster_order(1,:)=[3 1 2];
    % gaussian mixture: 
%         clustering(1,:)=[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 2, 0, 0, 0, 2, 0, 0,...
%        0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0,...
%        0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
%        0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
%      cluster_order(1,:)=[3 1 2];
    % Sess2:- blue light, after
      %kmeans: 
    clustering(2,:)=[1, 1, 1, 2, 2, 0, 1, 1, 0, 0, 2, 1, 2, 2, 0, 2, 2, 0, 1, 2, 0, 1,...
       0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0,...
       0, 0, 1, 0, 2, 1, 1, 0, 1, 2, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1,...
       1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 2];
     cluster_order(2,:)=[2 3 1];
     % gaussian mixture: 
%    clustering(2,:)=[0, 0, 0, 2, 2, 2, 0, 1, 0, 0, 2, 0, 2, 2, 2, 2, 2, 0, 2, 2, 0, 0,...
%        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0,...
%        0, 0, 0, 0, 2, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
%        0, 1, 0, 1, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 2, 2, 0, 2];
%      cluster_order(2,:)=[3 1 2];
end
if n_clustering==3 && baseline_method==2 %
    %sess1- blue light before,
    %kmeans: 
    clustering(1,:)=[0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 0,...
       1, 1, 0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 2, 1, 0,...
       0, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0,...
       1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 0];
     cluster_order(1,:)=[2 3 1];
    % gaussian mixture: 
%          clustering(1,:)=[0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1,...
%        1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1, 1, 1, 1, 2, 1, 0,...
%        1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0,...
%        1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0];
%      cluster_order(1,:)=[3 1 2];
    % Sess2:- blue light, after
      %kmeans: 
    clustering(2,:)=[2, 2, 2, 2, 1, 2, 1, 1, 2, 2, 2, 1, 0, 0, 0, 0, 0, 2, 0, 0, 2, 2,...
       2, 2, 2, 1, 1, 1, 2, 1, 2, 2, 0, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1,...
       2, 1, 1, 2, 2, 2, 1, 1, 1, 2, 2, 2, 2, 2, 1, 2, 1, 1, 1, 1, 1, 1,...
       1, 1, 2, 1, 0, 2, 0, 0, 2, 2, 2, 1, 1, 1, 0, 2, 1, 2];
     cluster_order(2,:)=[2 3 1];
     % gaussian mixture: 
%         clustering(1,:)=[2, 0, 0, 2, 2, 2, 2, 2, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,...
%        0, 0, 2, 2, 2, 2, 2, 2, 2, 0, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 1, 2,...
%        2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,...
%        2, 1, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 2, 2, 1, 2];
%      cluster_order(2,:)=[3 1 2];
end
% set the clusters based on the feature 
for si=1:size(clustering,1)
    this_clustering=clustering(si,:);
    this_cluster_order=cluster_order(si,:);  
    a(find(this_clustering==0))=find(this_cluster_order==1) -1;
    a(find(this_clustering==1))= find(this_cluster_order==2)-1;
    a(find(this_clustering==2))= find(this_cluster_order==3)-1;
    feature_clustering(si,:)=a;
end

% check the level of clustering change: 
%%%%%%%%%%%
n=0; nc=0;  n12=0; nc12=0;  n_cluster_zero_consistent=0;n_cluster_one_consistent=0;
one_consistent=[]; zero_consistent=[];
figure
for ci=1:size(feature_clustering,2)
    if sum(abs(diff(feature_clustering([1 2],ci))))==0
        plot(1,ci,'*');hold on
        n12=n12+1;
    end
    if sum(abs(diff(feature_clustering([1 2],ci))))>0
        plot(2,ci,'*');hold on
        nc12=nc12+1;
    end
    if isequal(feature_clustering(:,ci),[0 0 ]'); n_cluster_zero_consistent=n_cluster_zero_consistent+1; zero_consistent=[zero_consistent ci];  end
    if isequal(feature_clustering(:,ci),[1 1 ]'); n_cluster_one_consistent=n_cluster_one_consistent+1; one_consistent=[one_consistent ci];end  
end
xlim([0.5 2.5])
xticks(1:2)
xticklabels({'1-2, consistnat', '1-2, changed'})
color_array=[0.3 0.3 0.3; 0.7 0.7 0.7];
figure
y = [n12 nc12];
b=bar(y,'stacked','FaceColor','flat');
xticks(1:2)
xticklabels({'Preserved cluster','Changed cluster'})
ylabel('# cells')


cd (mypath)
% get cluster figure and analysis for each session : before and after opn4
for si=1:length(cluster_data.all_sess_ind)
    cluster_data.sess_ind=cluster_data.all_sess_ind(si);
    cluster_data.cluster_order=cluster_order(cluster_data.sess_ind,:);
    % now load
    load(['all_cell_df_sess' num2str(cluster_data.sess_ind) all '_B' num2str(baseline_method)  ])% will load a database all_cell_df
    load(['all_cell_t' num2str(cluster_data.sess_ind) all '_B' num2str(baseline_method) ])% will load a database all_cell_t
    
    cluster_data.all_cell_dF=all_cell_dF;
    cluster_data.all_cell_t=all_cell_t;
    
    if individual_clustering
        cluster_data.clustering=clustering(cluster_data.sess_ind,:);
    else
        cluster_data.clustering=clustering(ref_cluster,:);
    end
    
    cluster_data.baseline_method=baseline_method;
    cluster_data.all=all;
    cluster_data.n_clustering=n_clustering;
    analysis{si}=Inscopix_calculate_params_after_cell_clustering(cluster_data);
    analysis{si}.all_cell_dF=all_cell_dF;
    analysis{si}.all_cell_t=all_cell_t;
     
end


%% comapre cell plot before and after opn4
t(:)= analysis{1}.all_cell_t(1,1,:);
% checking what happened to cluster 1 
% before 
cluster_sess1=analysis{1}.all_cell_dF(find(feature_clustering(1,:)==0),:,:);% find cluster 0 indexes
tmp(:)=mean(mean(cluster_sess1,2),1);
tmp_sem(:)=std(mean(cluster_sess1,2),1)/sqrt(size(cluster_sess1,1));
mean_cluster_sess1{1}=tmp-mean(tmp(1:10*fs));
sem_cluster_sess1{1}=tmp_sem-mean(tmp(1:10*fs));

cluster_sess1=analysis{1}.all_cell_dF(find(feature_clustering(1,:)==1),:,:);%  find cluster 1 indexes
tmp(:)=mean(mean(cluster_sess1,2),1);
tmp_sem(:)=std(mean(cluster_sess1,2),1)/sqrt(size(cluster_sess1,1));
mean_cluster_sess1{2}=tmp-mean(tmp(1:10*fs));
sem_cluster_sess1{2}=tmp_sem-mean(tmp(1:10*fs));
if ~isempty(find(feature_clustering(1,:)==2))
    cluster_sess1=analysis{1}.all_cell_dF(find(feature_clustering(1,:)==2),:,:);%  find cluster 2 indexes
    tmp(:)=mean(mean(cluster_sess1,2),1);
    tmp_sem(:)=std(mean(cluster_sess1,2),1)/sqrt(size(cluster_sess1,1));
    mean_cluster_sess1{3}=tmp-mean(tmp(1:10*fs));
    sem_cluster_sess1{3}=tmp_sem-mean(tmp(1:10*fs));
end
% after - after session, with session 1 clustering 
cluster_sess2=analysis{2}.all_cell_dF(find(feature_clustering(1,:)==0),:,:);%find cluster 0 indexes
tmp(:)=mean(mean(cluster_sess2,2),1);
tmp_sem(:)=std(mean(cluster_sess2,2),1)/sqrt(size(cluster_sess2,1));
mean_cluster_sess2{1}=tmp-mean(tmp(1:10*fs));
sem_cluster_sess2{1}=tmp_sem-mean(tmp(1:10*fs));

cluster_sess2=analysis{2}.all_cell_dF(find(feature_clustering(1,:)==1),:,:);
tmp(:)=mean(mean(cluster_sess2,2),1);
tmp_sem(:)=std(mean(cluster_sess2,2),1)/sqrt(size(cluster_sess2,1));
mean_cluster_sess2{2}=tmp-mean(tmp(1:10*fs));
sem_cluster_sess2{2}=tmp_sem-mean(tmp(1:10*fs));
if ~isempty(find(feature_clustering(1,:)==2))
    cluster_sess2=analysis{2}.all_cell_dF(find(feature_clustering(1,:)==2),:,:);
    tmp(:)=mean(mean(cluster_sess2,2),1);
    tmp_sem(:)=std(mean(cluster_sess2,2),1)/sqrt(size(cluster_sess2,1));
    mean_cluster_sess2{3}=tmp-mean(tmp(1:10*fs));
    sem_cluster_sess2{3}=tmp_sem-mean(tmp(1:10*fs));
end

cluster_color(1,:)=[0.7 0.7 0.7];% light 
cluster_color(2,:)=[0.3 0.3 0.3];% dark
cluster_color(3,:)=[0.9 0.9 0.9];% very light
figure % dF/F
subplot(1,3,1) % cluster 1
figure_params.background=cluster_color(1,:);figure_params.line='k';
plot_curve_with_SEM(t,mean_cluster_sess1{1},sem_cluster_sess1{1},figure_params)% before
figure_params.background=cluster_color(1,:);figure_params.line='k--';
plot_curve_with_SEM(t,mean_cluster_sess2{1},sem_cluster_sess2{1},figure_params)% after 
title(['Cluster #1 ' all(2:end) ' B' num2str(baseline_method)])
subplot(1,3,2) % cluster 2 & the noise
figure_params.background=cluster_color(2,:);figure_params.line='k';
plot_curve_with_SEM(t,mean_cluster_sess1{2},sem_cluster_sess1{2},figure_params)% before
figure_params.background=cluster_color(2,:);figure_params.line='k--';
plot_curve_with_SEM(t,mean_cluster_sess2{2},sem_cluster_sess2{2},figure_params)% after 
title(['Cluster #2 ' all(2:end) ' B' num2str(baseline_method)])
if ~isempty(find(feature_clustering(1,:)==2))
    subplot(1,3,3) % cluster 3
    figure_params.background=cluster_color(3,:);figure_params.line='k';
    plot_curve_with_SEM(t,mean_cluster_sess1{3},sem_cluster_sess1{3},figure_params)% before
    figure_params.background=cluster_color(3,:);figure_params.line='k--';
    plot_curve_with_SEM(t,mean_cluster_sess2{3},sem_cluster_sess2{3},figure_params)% after
    title(['Cluster #3 ' all(2:end) ' B' num2str(baseline_method)])
end


cluster_num=3;
figure % normalized dF/F
%BEFORE
subplot(2,2,1) % cluster 1
figure_params.background=cluster_color(2,:);figure_params.line='k';
plot_curve_with_SEM(t,mean_cluster_sess1{1}/max(mean_cluster_sess1{1}),sem_cluster_sess1{1}/max(mean_cluster_sess1{1}),figure_params)% before
%title(['Cluster #1 before ' all(2:end) ' B' num2str(baseline_method)]); xlim([0 45]); ylim([-0.25 1.5])
%subplot(2,2,3) % cluster 2
figure_params.background=cluster_color(1,:);figure_params.line='k';
plot_curve_with_SEM(t,mean_cluster_sess1{cluster_num}/max(mean_cluster_sess1{cluster_num}),sem_cluster_sess1{cluster_num}/max(mean_cluster_sess1{cluster_num}),figure_params)% before
title(['Cluster #1-2 before ' all(2:end) ' B' num2str(baseline_method)]); xlim([0 45]); ylim([-0.25 1.5])

%AFTER
subplot(2,2,2) % cluster 1
figure_params.background=cluster_color(2,:);figure_params.line='k--';
plot_curve_with_SEM(t,mean_cluster_sess2{1}/max(mean_cluster_sess2{1}),sem_cluster_sess2{1}/max(mean_cluster_sess2{1}),figure_params)% after 
%title(['Cluster #1 after ' all(2:end) ' B' num2str(baseline_method)]); xlim([0 45]); ylim([-0.25 1.5])
%subplot(2,2,4) % cluster 2
figure_params.background=cluster_color(1,:);figure_params.line='k--';
plot_curve_with_SEM(t,mean_cluster_sess2{cluster_num}/max(mean_cluster_sess2{cluster_num}),sem_cluster_sess2{cluster_num}/max(mean_cluster_sess2{cluster_num}),figure_params)% after 
title(['Cluster #1-2 after ' all(2:end) ' B' num2str(baseline_method)]); xlim([0 45]); ylim([-0.25 1.5])



% compare specific features- to claim what changed within each cell over
% sessions
% extract the data from analysis
for si=1:length(cluster_data.all_sess_ind)
    all_Mean_AUC(:,si)=analysis{si}.Mean_AUC;
     all_rise_time(:,si)=analysis{si}.rise_time;
     all_all_tau(:,si)=analysis{si}.all_tau;
      all_all_max_val(:,si)=analysis{si}.all_max_val;
      all_all_ratio_20_to_30(:,si)=analysis{si}.all_ratio_20_to_30;
end

% compare features, without clutsers


% plot differences between clusters over sessions, using '-*' format 
figure
trait_to_plot={'all_Mean_AUC';'all_all_max_val'; 'all_rise_time'; 'all_all_tau';'all_all_ratio_20_to_30'};
for ti=1:length(trait_to_plot)
    subplot(1,length(trait_to_plot),ti)
    ref_session=1;
    eval(['M=' trait_to_plot{ti} ';']);
    for ci=1:size(M,1)
        if feature_clustering(ref_session,ci)==0
            plot(1:size(M,2),M(ci,:),'r-*'); hold on
        end
        if feature_clustering(ref_session,ci)==1 % the noise cluster 
            plot(1:size(M,2),M(ci,:),'k-*'); hold on
        end
        if feature_clustering(ref_session,ci)==2
            plot(1:size(M,2),M(ci,:),'b-*'); hold on
        end
    end
    old = '_';  new = ' '; newStr = replace(trait_to_plot{ti},old,new);
    title(newStr)
end

% stats - compare same trait, between sessions

clear g0 g1 g_all y0 y1 y_all
trait_to_plot={'all_Mean_AUC';'all_all_max_val'; 'all_rise_time'; 'all_all_tau';'all_all_ratio_20_to_30'};
c1=[]; c0=[]; c_all=[];
for ti=1:length(trait_to_plot)
    ref_session=1;
    eval(['M=' trait_to_plot{ti} ';']);
    % compare before and after, each cluster
    y1=[M(feature_clustering(ref_session,:)==2,1)' M(feature_clustering(ref_session,:)==2,2)' ];
    %y1=[M(feature_clustering(ref_session,:)==1,1)' M(feature_clustering(ref_session,:)==1,2)' ];% the noise
    y0=[M(feature_clustering(ref_session,:)==0,1)' M(feature_clustering(ref_session,:)==0,2)' ];
    y_all=[y1,y0];
    g1=[ones(1,sum(feature_clustering(ref_session,:)==2)) 2*ones(1,sum(feature_clustering(ref_session,:)==2))  ];
   % g1=[ones(1,sum(feature_clustering(ref_session,:)==1)) 2*ones(1,sum(feature_clustering(ref_session,:)==1))  ];% the noise
     g0=[ones(1,sum(feature_clustering(ref_session,:)==0)) 2*ones(1,sum(feature_clustering(ref_session,:)==0))  ];
     g_all=[g1,g0];
    [p1,tbl,stats1]  = kruskalwallis(y1,g1,'off');
    [p0,tbl0,stats0]  = kruskalwallis(y0,g0,'off');
    [p_all,tbl_all,stats_all]  = kruskalwallis(y_all,g_all,'off');
    c1=[c1; multcompare(stats1,'CType','hsd')];% one cluster 
    c0=[c0; multcompare(stats0,'CType','hsd')];% the other cluster 
    % index fits traits, based on trait_to_plot: 'all_Mean_AUC'; 'all_rise_time'; 'all_all_tau'
    c_all=[c_all; multcompare(stats_all,'CType','hsd')];% cluster seperation 
end

% plot  - compare same trait, between sessions

figure
trait_to_plot={'all_Mean_AUC'; 'all_rise_time'; 'all_all_tau'};
for ti=1:length(trait_to_plot)
    subplot(2,length(trait_to_plot),ti)
    ref_session=1;
    s=0.15;
    eval(['M=' trait_to_plot{ti} ';']);
    cluster_ind=2;
    b0=bar([1:size(M,2)]-s,nanmean(M(feature_clustering(ref_session,:)==cluster_ind,:))); hold on
    b0.FaceColor=cluster_color(1,:); b0.BarWidth=0.28;
    sem=std(M(feature_clustering(ref_session,:)==cluster_ind,:))/sqrt(length(find(feature_clustering(ref_session,:)==cluster_ind)));
    nMean=nanmean(M(feature_clustering(ref_session,:)==cluster_ind,:));
    line([(1:2)-s;(1:2)-s],[nMean+sem ;nMean-sem])
    disp(['cluster0 mean+-sem ' trait_to_plot{ti} ' ' num2str(nMean) '+-' num2str(sem)])
    
    cluster_ind=0;
    b1=bar([1:size(M,2)]+s,nanmean(M(feature_clustering(ref_session,:)==cluster_ind,:))); hold on
    b1.FaceColor=cluster_color(2,:); b1.BarWidth=0.28;
    sem=std(M(feature_clustering(ref_session,:)==cluster_ind,:))/sqrt(length(find(feature_clustering(ref_session,:)==cluster_ind)));
    nMean=nanmean(M(feature_clustering(ref_session,:)==cluster_ind,:));
    line([(1:2)+s;(1:2)+s],[nMean+sem ;nMean-sem])
    disp(['cluster0 mean+-sem ' trait_to_plot{ti} ' ' num2str(nMean) '+-' num2str(sem)])
    
    xlim([0.5 2.5])
     switch trait_to_plot{ti}
        case 'all_Mean_AUC'; ylim([0 2800])
        case 'all_all_tau';  ylim([0 2.5])
        case 'all_rise_time'; ylim([0 12])
    end

    subplot(2,length(trait_to_plot),ti+3)
  
    for ci=1:size(M,1)
          cluster_ind=2;
        if feature_clustering(ref_session,ci)==cluster_ind
            p0=plot([1:size(M,2)]+s,M(ci,:),'-*'); hold on
            p0.Color=cluster_color(1,:);
        end
         cluster_ind=0;
        if feature_clustering(ref_session,ci)==cluster_ind
            p1=plot([1:size(M,2)]-s,M(ci,:),'-*'); hold on
            p1.Color=cluster_color(2,:);
        end
    end
    xlim([0.5 2.5])
    xticks([1 2 ]); xticklabels({'Before'; 'After'});xtickangle(90)
    old = '_';  new = ' '; newStr = replace(trait_to_plot{ti},old,new);
    title(newStr)
    switch trait_to_plot{ti}
        case 'all_Mean_AUC'; ylim([-100 2800])
        case 'all_all_tau';  ylim([0 2.5])
        case 'all_rise_time'; ylim([0 12])
    end
end



1