function run_Inscopix_calculate_params_after_cell_clustering
% Light response paper Nov 2021- blue light 3 intensities and white 
% after test6R single cell data is clustered (Pegah Kassraian), some
% parameters are calculated and presented 
clear all_cell_dF all_cell_t

%mypath='C:\Users\Anat\Documents\Inscopix_Projects\SCNVIP_test6R_blue';
mypath='D:\DATA_Glab\Inscopix\Inscopix_Projects\SCNVIP_test6R_blue';
n_clustering=2; % 2 used in paper
baseline_method=2;% 2 used in paper
individual_clustering=1; 
% if individual_clustering=0, ref_cluster should be set up. I prefered 4- the white light 
ref_cluster=4;

% 1-3 blue, different intensities. 4- white
%cluster_data.sess_ind=4; 
%cluster_data.sess_ind=3; 
%cluster_data.sess_ind=2; 
%cluster_data.sess_ind=1; 

cluster_data.all_sess_ind=[1:4]; 

if n_clustering==3 && baseline_method==1
    % first clustering - Baseline based on dark (B1) , 3 clusters
    %sess1- blue light high
    clustering(1,:)=[0, 2, 1, 0, 1, 1, 1, 2, 1, 1, 0, 2, 2, 2, 1, 0, 2, 2, 2, 0, 0, 0,0, 0, 0, 1, 1, 1, 0, 2, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1];
    cluster_order(1,:)=[2 1 3];
    % Sess2:- blue light med
    clustering(2,:)=[1, 1, 0, 1, 0, 0, 1, 2, 0, 1, 1, 2, 2, 1, 1, 1, 2, 2, 2, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 2, 0, 2, 1, 0, 0, 0, 0, 0, 2, 0, 0, 1, 1, 2, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1];
    cluster_order(2,:)=[1 2 3];
    % Sess3: blue light low
    
    clustering(3,:)=[1, 1, 2, 1, 2, 2, 1, 0, 1, 1, 1, 1, 1, 2, 1, 1, 1, 0, 1, 2, 1, 1, 2, 2, 2, 1, 1, 2, 2, 1, 2, 0, 1, 2, 2, 2, 2, 2, 1, 2, 2, 1, 1, 1,1, 2, 1, 2, 2, 1, 2, 2, 2, 1, 1, 1];
    cluster_order(3,:)=[3 2 1];
    % Sess4: white light
    clustering(4,:)=[1, 0, 2, 0, 2, 2, 2, 0, 2, 1, 1, 0, 0, 0, 2, 1, 0, 0, 0, 1, 1, 1, 1, 2, 1, 2, 2, 1, 1, 0, 1, 0, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 1, 1,1, 2, 2, 2, 2, 2, 1, 2, 2, 1, 2, 2];
    cluster_order(4,:)=[3 2 1];
    
end

if n_clustering==2 && baseline_method==1
    
    % two clusters, B1
    % second clustering- Baseline
    clustering(1,:)=[0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0,...
        0, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1,...
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    cluster_order(1,:)=[1 2];
    % Sess2:- blue light med
    clustering(2,:)=[1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 1,...
        1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0,...
        1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0];
    cluster_order(2,:)=[2 1 ];
    % Sess3: blue light low
    
    clustering(3,:)=[0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0,...
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,...
        0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0];
    
    cluster_order(3,:)=[ 1 2];
    % Sess4: white light
    clustering(4,:)=[0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0,...
        0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0,...
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    
    cluster_order(4,:)=[ 1 2];
end


if n_clustering==2 && baseline_method==2
    
      % first clustering - Baseline based on last (B2) , 2 clusters
    %sess1- blue light high
    clustering(1,:)=[0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0,...
       0, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1,...
       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    
    cluster_order(1,:)=[2 1];
    % Sess2:- blue light med
    clustering(2,:)=[0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0,...
       0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1,...
       0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1];
    cluster_order(2,:)=[2 1];
    % Sess3: blue light low
    
    clustering(3,:)=[0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0,...
       0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,...
       0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0]; 
    cluster_order(3,:)=[2 1];
    % Sess4: white light
    clustering(4,:)=[1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1,...
       1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1,...
       1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
    cluster_order(4,:)=[1 2];
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
n=0; nc=0; n14=0; nc14=0; n13=0; nc13=0; n12=0; nc12=0; n_cluster_zero_consistent=0;n_cluster_one_consistent=0;
one_consistent=[]; zero_consistent=[];
figure
for ci=1:size(feature_clustering,2)
    if sum(abs(diff(feature_clustering(:,ci))))==0
        plot(1,ci,'*');hold on 
        n=n+1;
    end
    if sum(abs(diff(feature_clustering(:,ci))))>0
        plot(2,ci,'*');hold on 
        nc=nc+1;
    end
    if sum(abs(diff(feature_clustering([1 4],ci))))==0
        plot(3,ci,'*');hold on 
        n14=n14+1;
    end
    if sum(abs(diff(feature_clustering([1 4],ci))))>0
        plot(4,ci,'*');hold on 
        nc14=nc14+1;
    end
    if sum(abs(diff(feature_clustering([1 3],ci))))==0
        plot(5,ci,'*');hold on 
        n13=n13+1;
    end
    if sum(abs(diff(feature_clustering([1 3],ci))))>0
        plot(6,ci,'*');hold on 
        nc13=nc13+1;
    end
    if sum(abs(diff(feature_clustering([1 2],ci))))==0
        plot(7,ci,'*');hold on
        n12=n12+1;
    end
    if sum(abs(diff(feature_clustering([1 2],ci))))>0
        plot(8,ci,'*');hold on
        nc12=nc12+1;
    end
    if isequal(feature_clustering(:,ci),[0 0 0 0]'); n_cluster_zero_consistent=n_cluster_zero_consistent+1; zero_consistent=[zero_consistent ci];  end
    if isequal(feature_clustering(:,ci),[1 1 1 1]'); n_cluster_one_consistent=n_cluster_one_consistent+1; one_consistent=[one_consistent ci];end  
end
xlim([0.5 8.5])
xticks(1:8)
xticklabels({'all, consistant', 'all, changed','1-4, consistnat', '1-4, changed','1-3, consistnat', '1-3, changed','1-2, consistnat', '1-2, changed'})

color_array=[0.8 0.8 0.8; 0.6 0.6 0.6];% cluster 1 - light gray. cluster 2 - dark gray
figure
y = [n nc; n12 nc12; n13 nc13; n14 nc14];
b=bar(y,'stacked','FaceColor','flat');
for k=1:size(y,2)
    b(k).CData = color_array(k,:);
end
xticks(1:4)
xticklabels({'all','1-2','1-3', '1-4'})
ylabel('cells')
legend('preserved cluster','changed cluster')

cd (mypath)
% get cluster figure and analysis for each session 
for si=1:length(cluster_data.all_sess_ind)
    cluster_data.sess_ind=cluster_data.all_sess_ind(si);
    cluster_data.cluster_order=cluster_order(cluster_data.sess_ind,:);
    % now load
    load(['all_cell_df_sess' num2str(cluster_data.sess_ind) '_B' num2str(baseline_method)])% will load a database all_cell_df
    load(['all_cell_t' num2str(cluster_data.sess_ind) '_B' num2str(baseline_method)])% will load a database all_cell_t
    
    cluster_data.all_cell_dF=all_cell_dF;
    cluster_data.all_cell_t=all_cell_t;
    
    if individual_clustering
        cluster_data.clustering=clustering(cluster_data.sess_ind,:);
    else
        cluster_data.clustering=clustering(ref_cluster,:);
    end
    
    cluster_data.baseline_method=baseline_method;
    cluster_data.n_clustering=n_clustering;
    analysis{si}=Inscopix_calculate_params_after_cell_clustering(cluster_data);
    analysis{si}.all_cell_dF=all_cell_dF;
    analysis{si}.all_cell_t=all_cell_t;
     
end

%  show a few examples, one from each clustering behavior: 
% cluster zero, consistent 
% cluster one, consistent 
% not consistent between 1 and 4
cluster_color=[0 0 1;0 0 1;0 0 1;0.7 0.7 0.7];
figure
one2four_changed=[4 24 44];
exmp=[zero_consistent(end) one_consistent(16) one2four_changed(2)];
%exmp=one_consistent(1:17);
for ei=1:length(exmp)
    subplot(length(exmp),1,ei)
    for si=1:length(analysis)
        this_sess_df(:,:)=analysis{si}.all_cell_dF(exmp(ei),:,:);
        this_sess_t(:,:)=analysis{si}.all_cell_t(exmp(ei),:,:);
        
        y=nanmean(this_sess_df(:,:),1);
        T=this_sess_t(1,:)+45*(si-1);
        SEM=nanstd(this_sess_df(:,:),1)/sqrt(size(this_sess_df(:,:),1));
        
        figure_params.background=cluster_color(si,:);figure_params.line='k';
        plot_curve_with_SEM(T,y,SEM,figure_params)
        
       % plot(this_sess_t(1,:)+45*(si-1),nanmean(this_sess_df(:,:))); hold on
    end
    if ei==length(exmp); xlabel('Time (sec)'); end
    %ylim([-2 45])
    xlim([0 175])
end

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

% plot differences between clusters over sessions, using '-*' format 
figure
trait_to_plot={'all_Mean_AUC';'all_all_max_val'; 'all_rise_time'; 'all_all_tau';'all_all_ratio_20_to_30'};
for ti=1:length(trait_to_plot)
    subplot(1,length(trait_to_plot),ti)
    ref_session=4;
    eval(['M=' trait_to_plot{ti} ';']);
    for ci=1:size(M,1)
        if feature_clustering(ref_session,ci)==1
            plot(1:size(M,2),M(ci,:),'k-*'); hold on
        end
        if feature_clustering(ref_session,ci)==0
            plot(1:size(M,2),M(ci,:),'r-*'); hold on
        end
    end
    old = '_';  new = ' '; newStr = replace(trait_to_plot{ti},old,new);
    title(newStr)
end

% stats - compare same trait, between sessions
figure
clear g0 g1 y0 y1
trait_to_plot={'all_Mean_AUC'; 'all_rise_time'; 'all_all_tau'};
c1=[]; c0=[];
for ti=1:length(trait_to_plot)
    ref_session=4;
    eval(['M=' trait_to_plot{ti} ';']);
    y1=[M(feature_clustering(ref_session,:)==1,1)' M(feature_clustering(ref_session,:)==1,2)' M(feature_clustering(ref_session,:)==1,3)' M(feature_clustering(ref_session,:)==1,4)'];
    y0=[M(feature_clustering(ref_session,:)==0,1)' M(feature_clustering(ref_session,:)==0,2)' M(feature_clustering(ref_session,:)==0,3)' M(feature_clustering(ref_session,:)==0,4)'];
    g1=[ones(1,sum(feature_clustering(ref_session,:)==1)) 2*ones(1,sum(feature_clustering(ref_session,:)==1)) 3*ones(1,sum(feature_clustering(ref_session,:)==1)) 4*ones(1,sum(feature_clustering(ref_session,:)==1)) ];
     g0=[ones(1,sum(feature_clustering(ref_session,:)==0)) 2*ones(1,sum(feature_clustering(ref_session,:)==0)) 3*ones(1,sum(feature_clustering(ref_session,:)==0)) 4*ones(1,sum(feature_clustering(ref_session,:)==0)) ];
    [p1,tbl,stats1]  = kruskalwallis(y1,g1,'off');
    [p0,tbl0,stats0]  = kruskalwallis(y0,g0,'off');
    c1=[c1; multcompare(stats1,'CType','bonferroni')];
    c0=[c0; multcompare(stats0,'CType','bonferroni')];
end

% plot  - compare same trait, between sessions
figure
trait_to_plot={'all_Mean_AUC'; 'all_rise_time'; 'all_all_tau'};
for ti=1:length(trait_to_plot)
    subplot(2,length(trait_to_plot),ti)
    ref_session=4;
    s=0.15;
    eval(['M=' trait_to_plot{ti} ';']);
    b0=bar([1:size(M,2)]-s,nanmean(M(feature_clustering(ref_session,:)==0,:))); hold on
    b0.FaceColor=[0.6 0.6 0.6]; b0.BarWidth=0.28;
    sem=std(M(feature_clustering(ref_session,:)==0,:))/sqrt(length(find(feature_clustering(ref_session,:)==0)));
    nMean=nanmean(M(feature_clustering(ref_session,:)==0,:));
    line([(1:4)-s;(1:4)-s],[nMean+sem ;nMean-sem])
    disp(['cluster0 mean+-sem ' trait_to_plot{ti} num2str(nMean) '+-' num2str(sem)])
    
    b1=bar([1:size(M,2)]+s,nanmean(M(feature_clustering(ref_session,:)==1,:))); hold on
    b1.FaceColor=[0.3 0.3 0.3]; b1.BarWidth=0.28;
    sem=std(M(feature_clustering(ref_session,:)==1,:))/sqrt(length(find(feature_clustering(ref_session,:)==1)));
    nMean=nanmean(M(feature_clustering(ref_session,:)==1,:));
    line([(1:4)+s;(1:4)+s],[nMean+sem ;nMean-sem])
    disp(['cluster0 mean+-sem ' trait_to_plot{ti} num2str(nMean) '+-' num2str(sem)])
    
    xlim([0.5 4.5])
     switch trait_to_plot{ti}
        case 'all_Mean_AUC'; ylim([-100 2800])
        case 'all_all_tau';  ylim([0 2.5])
        case 'all_rise_time'; ylim([0 12])
    end

    subplot(2,length(trait_to_plot),ti+3)
    for ci=1:size(M,1)
        if feature_clustering(ref_session,ci)==1
            p0=plot([1:size(M,2)]+s,M(ci,:),'-*'); hold on
            p0.Color=[0.2 0.2 0.2];
        end
        if feature_clustering(ref_session,ci)==0
            p1=plot([1:size(M,2)]-s,M(ci,:),'-*'); hold on
            p1.Color=[0.55 0.55 0.55];
        end
    end
    xlim([0.5 4.5])
    xticks([1 2 3 4]); xticklabels({'1.4E15'; '1.3E14';'1.7E13'; 'White light'});xtickangle(90)
    old = '_';  new = ' '; newStr = replace(trait_to_plot{ti},old,new);
    title(newStr)
    switch trait_to_plot{ti}
        case 'all_Mean_AUC'; ylim([-100 2800])
        case 'all_all_tau';  ylim([0 2.5])
        case 'all_rise_time'; ylim([0 12])
    end
end



% %% calculate correlation coefficien (copied from read_test6R_FP_general)
% all_y=[];
% clear cr2
% lb1=0;
% %for gi=[1:5 7:length(Groups)] % skip the low intensity red 
% for gi=[1:length(Groups)] % skip the low intensity red 
%     lb1=lb1+1;
%     y=nanmean(mean(full_df(Groups{gi},:,:),3));
%     y=y-mean(y(1:200)); % remove baseline ( before light is turned on)
%     all_y=[all_y; y];
%     c_label_states{lb1}=states{gi};
% end
% 
% for idi1=1:size(all_y,1)
%     A(:)=all_y(idi1,:);
%     for idi2=idi1:size(all_y,1)
%         B(:)=all_y(idi2,:);
%         cr2(idi2,idi1)=corr2(A,B);
%     end
% end
% corr_plot(cr2,c_label_states)



1







   


