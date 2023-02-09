function  analysis= Inscopix_calculate_params_after_cell_clustering (cluster_data)
% Light response paper Jan 2023
% after test6R single cell data is clustered (Pegah Kassraian), some
% parameters are calculated and presented 
% used for all inscopix data (white light, blue light with different
% intensities, before and after opn4 antagonist)

fs=5; % 5 Hz sampling rate 
if nargin==0
    clear all_cell_dF all_cell_t
    all=[];
    baseline_method=2;
    n_clustering=3;
    approach=2;
%     baseline_method=1;
%     n_clustering=2;
%     
%     baseline_method=2;
%     n_clustering=2;
    % this is the white light experiemnt, 118 cells
  % mypath='C:\Users\Anat\Documents\Inscopix_Projects\SCNVIP_test6R\Analysis_after_clustering';
    %mypath='D:\DATA_Glab\Inscopix\Inscopix_Projects\SCNVIP_test6R\Analysis_after_clustering';
    mypath='D:\DATA_Glab\Inscopix\Inscopix_Projects\SCNVIP_test6R_for6h_sess\';
    cd (mypath)
    
    %% those are the results for 3 clusters, B2, first session only (122 cells)
    if baseline_method==2 && n_clustering==3 && approach==1
        %         clustering=[2, 0, 1, 1, 0, 2, 1, 2, 0, 0, 1, 1, 1, 0, 0, 2, 1, 0, 2, 0, 0, 0,...
        %             0, 2, 2, 0, 0, 2, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 1, 2, 0, 2, 2, 0,...
        %             1, 1, 0, 1, 1, 2, 2, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,...
        %             1, 1, 1, 1, 1, 2, 2, 0, 2, 2, 2, 1, 0, 2, 2, 2, 2, 0, 2, 0, 1, 2,...
        %             0, 2, 2, 2, 2, 0, 0, 0, 2, 1, 0, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2,...
        %             1, 2, 2, 2, 1, 2, 1, 1];
        %
        
        clustering=[1, 0, 2, 2, 0, 1, 2, 0, 0, 0, 2, 2, 2, 2, 0, 1, 2, 2, 1, 0, 0, 0,...
            0, 0, 0, 0, 0, 0, 1, 2, 2, 0, 0, 1, 0, 2, 0, 2, 2, 0, 0, 0, 0, 0,...
            2, 2, 0, 2, 2, 1, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2,...
            2, 2, 2, 2, 2, 0, 0, 0, 1, 1, 1, 1, 2, 0, 0, 1, 0, 0, 0, 0, 2, 0,...
            0, 2, 1, 2, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 2, 2, 1, 1,...
            1, 1, 1, 1, 1, 1, 2, 2];
        % now load
        load('all_cell_df_B2');
        load('all_cell_t_B')
        %all_cell_t=10*all_cell_t;
        clustering_order=[2,3,1];
    end
    % new clustering with Alex , Gaussian, seed=0
    if baseline_method==2 && n_clustering==3 && approach==2
        clustering=[0, 0, 0, 1, 2, 0, 2, 0, 1, 2, 2, 2, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1,...
            2, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
            0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 2, 0, 0, 1,...
            1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1,...
            1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 2,...
            2, 1, 2, 2, 2, 2, 2, 2, 0, 2, 2, 1, 2, 1, 2, 1, 2, 2, 2, 2, 0, 1,...
            1, 1, 2, 1, 1, 1, 2, 2, 2, 0, 2, 2, 0, 2, 1, 2, 2, 2, 1, 0, 2, 1,...
            2];
        %cd('Figure5')
        %                 load('all_cell_df');
        %         load('all_cell_t')
        % all_cell_t=10*all_cell_t;
        % cd('SCNVIP_test6R_for6h_sess')
        
        % now load
        load('all_cell_df_B2');
        load('all_cell_t_B')
        %all_cell_t=10*all_cell_t;
        clustering_order=[2,1,3];
    end
    if baseline_method==2 && n_clustering==4 && approach==2 %(approach 2 is with Alex, 155 cells)
        clustering=[1, 1, 2, 2, 0, 1, 0, 1, 2, 1, 0, 0, 1, 1, 1, 2, 2, 1, 2, 0, 1, 2,...
            3, 1, 3, 0, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,...
            1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 2, 2, 3, 2, 1, 2, 1, 1, 3, 2, 1, 2,...
            2, 1, 2, 2, 2, 2, 3, 2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 3, 3, 2, 2, 2,...
            2, 2, 2, 2, 2, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 2, 3,...
            0, 2, 0, 1, 0, 0, 0, 0, 1, 0, 0, 3, 0, 2, 0, 2, 3, 0, 0, 0, 3, 2,...
            2, 2, 0, 2, 2, 2, 0, 0, 0, 1, 0, 0, 1, 0, 2, 0, 0, 0, 3, 1, 0, 2,...
            0];
        % now load
        load('all_cell_df_B2');
        load('all_cell_t_B')
        %all_cell_t=10*all_cell_t;
        clustering_order=[1:4];
    end
  
    if baseline_method==2 && n_clustering==2 && approach==1
%         clustering=[0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1,...
%             1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 1, 1,...
%             0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
%             0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1,...
%             1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
%             0, 0, 1, 0, 0, 0, 0, 0];
        clustering= [0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1,...
            1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 1, 1,...
            0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
            0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1,...
            1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
            0, 0, 0, 0, 0, 0, 0, 0];
        
        cd('Figure5')
        % now load
        load('all_cell_df');
        load('all_cell_t')
        all_cell_t=10*all_cell_t;
        clustering_order=[1,2,3];
    end
    
    cluster_session_ind=[];
    
else
    %
    cluster_session_ind=cluster_data.sess_ind;
    all_cell_dF=cluster_data.all_cell_dF;
    all_cell_t=cluster_data.all_cell_t;
    clustering=cluster_data.clustering;
    clustering_order=cluster_data.cluster_order;
    baseline_method=cluster_data.baseline_method;
    n_clustering=cluster_data.n_clustering;
    all=cluster_data.all;
end


if exist (['all_tau' num2str(cluster_session_ind) all '_B' num2str(baseline_method) '_n' num2str(n_clustering) '.mat'])
    load(['all_tau' num2str(cluster_session_ind) all '_B' num2str(baseline_method) '_n' num2str(n_clustering) '.mat'])
    new_tau=0;
else
    new_tau=1;
end
% 
% if exist (['all_tau' num2str(cluster_session_ind) '.mat'])
%     load(['all_tau' num2str(cluster_session_ind) '.mat'])
%     new_tau=0;
% else
%     new_tau=1;
% end


cluster_ind{clustering_order(1)}=find(clustering==0);
cluster_ind{clustering_order(2)}=find(clustering==1);
if n_clustering>2
    cluster_ind{clustering_order(3)}=find(clustering==2);
end

cluster_color(1,:)=[0.8 0.8 0.8];% light gray
cluster_color(2,:)=[0.6 0.6 0.6];% darker gray

if n_clustering>2
    cluster_ind{clustering_order(3)}=find(clustering==2);
    cluster_color(3,:)=[0.4 0.4 0.4];
end
if n_clustering>3
    cluster_ind{clustering_order(4)}=find(clustering==3);
    cluster_color(4,:)=[0.2 0.2 0.2];
end



% if isempty(cluster_session_ind)
%     all_cell_t=10*all_cell_t; % I have to check what caused this mistake
% end

% plot the different clusters individual 
MAXY=max(max(max(all_cell_dF)));
figure
for ci=1:length(cluster_ind)
    k=clustering_order(ci);
    subplot(1,length(cluster_ind),k)
    this_cluster_ind=cluster_ind{k};
    for i=1:length(this_cluster_ind)        
        T(:)=all_cell_t(this_cluster_ind(i),1,:);
        dF(:)=nanmean(all_cell_dF(this_cluster_ind(i),:,:),2);
        plot (T,dF ); hold on
        ylim([-2 0.8*MAXY])
    end
end
 title(['session ' num2str(cluster_session_ind) ', baseline method = B' num2str(baseline_method)])

% plot the different clusters mean
figure
if_norm=[0 1];
for spi=1:2
    subplot(1,2,spi)
    for ci=1:length(cluster_ind)
        clear dF y SEM
        this_cluster_ind=cluster_ind{ci};
        T(:)=all_cell_t(this_cluster_ind(1),1,:);
        cell_dF=[];
        sec_baseline=5;
        for i=1:length(this_cluster_ind)
            dF(:)=nanmean(all_cell_dF(this_cluster_ind(i),:,:),2);
            dF=dF-nanmean(dF(1:fs*sec_baseline)); % remove baseline 
            % if if_norm(spi); dF=dF/max(dF);end
            cell_dF=[cell_dF; dF];
        end
        
        y=nanmean(cell_dF,1);
        norm_factor=max(y);
        if if_norm(spi); y=y/norm_factor;end
        SEM=nanstd(cell_dF,1)/sqrt(size(cell_dF,1));
        if if_norm(spi); SEM=SEM/norm_factor;end
        
        figure_params.background=cluster_color(ci,:);figure_params.line='k';
        plot_curve_with_SEM(T,y,SEM,figure_params)
        ylim([-1 MAXY*0.3])
        if if_norm(spi); ylim([-0.25 1.5]); end
        xlim([0 45])
        xlabel('Time (sec)')
        ylabel('dF/F')
        title(['session ' num2str(cluster_session_ind) ', baseline method = B' num2str(baseline_method)])
    end
end

% calculate response parameters
individual_response_figure=0;
for i=1:size(all_cell_dF,1)
    if individual_response_figure;  figure; end
    for ri=1:size(all_cell_dF,2)
        t(:)=all_cell_t(i,ri,:);
        dF(:)=all_cell_dF(i,ri,:);
        %sec5_ind=max(find(all_dF.t<=5));
        sec2_ind=max(find(t<=2));
        % [min_val min_ind]=min(all_dF.dF(inds(1)+max_ind:inds(end)));% find min after the max point
        t=t-t(1);
        
        % find time to peak
        inds=intersect(find(t>15),find(t<30));
        inds=intersect(find(t>15),find(t<27));
        [min_val min_ind]=min(dF(inds));% find global min (when light is on)
        [max_val(i,ri) max_ind]=max(dF(inds));
        delta_t_to_max(i,ri)=t(inds(1)+max_ind)-t(inds(1));
        
        % calculates integral around peak (+- 3 seconds), OR 5 seconds after
        % peak
        % int_df_around_max(i)=sum(all_dF.dF(inds(1)+max_ind:inds(1)+max_ind+sec5_ind));
        
        %int_df_around_max(i)=sum(dF(inds(1)+max_ind-sec2_ind:inds(1)+max_ind+sec2_ind));% 4 seconds interval
        %int_df_around_min(i)=sum(dF(inds(1)+min_ind-sec2_ind:inds(1)+min_ind+sec2_ind));% 4 seconds interval
        %     intersect(find(all_dF.t>light_array.light_off(i)-2*sec2_ind),find(all_dF.t<light_array.light_off(i)))
        %     find(all_dF.t<light_array.light_off(i))-42:find(all_dF.t<light_array.light_off(i))
        %L=length(dF(inds(1)+max_ind-sec2_ind:inds(1)+max_ind+sec2_ind));
        %end_inds=max(find(t<30))-L: max(find(t<30));
        
        %  ratio_max_to_last(i,ri)=sum(dF(inds(1)+max_ind-sec2_ind:inds(1)+max_ind+sec2_ind))/sum(dF(end_inds));
        ratio_max_to_min(i,ri)=max_val(i,ri)/min_val; % if it breaks here- check the light on defenitions- might need a shift (line 170)
        inds20=intersect(find(t>19),find(t<21));
        inds30=intersect(find(t>28),find(t<30));
        ratio_20_to_30(i,ri)=mean(dF(inds20))/mean(dF(inds30)); % if it breaks here- check the light on defenitions- might need a shift (line 170)
        
        %begin_int_time=10;% sec
        %inds2=intersect(find(t>15+begin_int_time),find(t<30));
        %int_df_last_half(i,ri)=sum(dF(inds2));
        
        if individual_response_figure
            subplot(2,size(all_cell_dF,2)/2,ri)
            plot(t(inds),dF(inds)); hold on
            plot([t(inds(1)+max_ind) t(inds(1)+max_ind)],[-0.2 max(dF)],'r'); hold on
            title (['cell # ' num2str(i)])
        end
        
        inds3=intersect(find(t>15),find(t<30));
        mean_df(i,ri)=sum(dF(inds3));
        
    end
    all_mean_df(i)=mean(mean_df(i,:));
    all_max_val(i)=mean(max_val(i,:));
    all_delta_t_to_max(i)=mean(delta_t_to_max(i,:));
    first_delta_t_to_max(i)=delta_t_to_max(i,1);
    first_to_second_peak(i)=max_val(i,1)-max_val(i,2);
    second_to_third_peak(i)=max_val(i,2)-max_val(i,3);
    all_ratio_max_to_min(i)=mean(ratio_max_to_min(i,:));
    all_ratio_20_to_30(i)=mean(ratio_20_to_30(i,:));
end


% calculate decay times
if new_tau
    t2=t;
    t_start=31;% sec
    t_end=40;% sec
    figure
    for i=1:size(all_cell_dF,1)
        subplot(ceil(size(all_cell_dF,1)/10),10,i)
        for ri=1:size(all_cell_dF,2)% over repeats
            clear these_tau
            y(:)=all_cell_dF(i,ri,:);
            t_ind=intersect(find(t2>t_start), find(t2<=t_end));
            x=t2(t_ind)'-t_start;
            this_y=y(t_ind)';
            g = fittype('a-b*exp(-c*x)');
            if sum(isnan(this_y))>0; this_y(isnan(this_y))=nanmean(this_y); end
            f0 = fit(x,this_y,g,'StartPoint',[[ones(size(x)), -exp(-x)]\this_y; 1]);
            these_tau=f0.c;
            xx = linspace(0,10,50);
            plot(x,this_y,'b',xx,f0(xx),'k-');hold on
            tau(i,ri)=these_tau;
            
        end
        
    end
    title(['session ' num2str(cluster_session_ind) ', baseline method = B' num2str(baseline_method)])
    
    for i=1:size(all_cell_dF,1)
        all_tau(i)=nanmean(tau(i,:));
    end
    %save(['all_tau' num2str(cluster_session_ind) '.mat'],'all_tau')
     save(['all_tau' num2str(cluster_session_ind) all '_B' num2str(baseline_method) '_n' num2str(n_clustering) '.mat'],'all_tau')
end


figure
traits_to_plot={'Mean AUC','Max amplitude (a.u.)', 'Rise time (sec)','First peak rise time(sec)', 'Exponent decay constant (sec-1)','20/30 ratio','D first to second peak','D second to third peak'};%
for ti=1:length(traits_to_plot)
    switch traits_to_plot{ti}
        case 'Mean AUC'
            all_y=all_mean_df;
            analysis.Mean_AUC=all_y;
            %  ylim_array=[0 1500];
        case 'Rise time (sec)'
            all_y=all_delta_t_to_max;
            analysis.rise_time=all_y;
        case 'Exponent decay constant (sec-1)'
            all_y=all_tau;
            analysis.all_tau=all_y;
        case 'Max/min ratio'
            all_y=all_ratio_max_to_min;
            analysis.all_ratio_max_to_min=all_y;
        case '20/30 ratio'
            all_y=all_ratio_20_to_30;  
            analysis.all_ratio_20_to_30=all_y;
        case 'Max amplitude (a.u.)'
            all_y=all_max_val;
            analysis.all_max_val=all_y;
        case 'First peak rise time(sec)'
            all_y=first_delta_t_to_max;
            analysis.first_delta_t_to_max=all_y;
        case 'D first to second peak'
            all_y=first_to_second_peak;
            analysis.first_to_second_peak=all_y;
        case 'D second to third peak'
            all_y=second_to_third_peak;
             analysis.second_to_third_peak=all_y;
    end
    
    
    subplot(ceil(length(traits_to_plot)/4),4,ti)
     
     
    ph=plot (1.1*ones(1,length(cluster_ind{1})),all_y(cluster_ind{1}),'*'); hold on
    disp([traits_to_plot{ti} ' median cluster1 ' num2str(median(all_y(cluster_ind{1}))) ' +- '    num2str(std(all_y(cluster_ind{1}))/sqrt(length(cluster_ind{1})))])
    ph.Color=cluster_color(1,:);
    ph2=plot (2.1*ones(1,length(cluster_ind{2})),all_y(cluster_ind{2}),'*'); hold on
    disp([traits_to_plot{ti} ' median cluster2 ' num2str(median(all_y(cluster_ind{2}))) ' +- '    num2str(std(all_y(cluster_ind{2}))/sqrt(length(cluster_ind{2})))])

    ph2.Color=cluster_color(2,:);
    if length(cluster_ind)>2
        ph2=plot (3.1*ones(1,length(cluster_ind{3})),all_y(cluster_ind{3}),'*'); hold on
        ph2.Color=cluster_color(3,:);
        disp([traits_to_plot{ti} ' median cluster3 ' num2str(median(all_y(cluster_ind{3}))) ' +- '   num2str(std(all_y(cluster_ind{3}))/sqrt(length(cluster_ind{3})))])

    end
    
    % arrange a new clustering array, based on the type of cluster, for boxplot 
    a(cluster_ind{1})=0;
    a(cluster_ind{2})=1;
     if length(cluster_ind)>2
          a(cluster_ind{3})=2;
     end
     boxplot(all_y,a,'PlotStyle','compact','Colors',[0 0 0]); hold on 
    
    % statistics: if h==1, normality is observed
    %     data= randn(100,1);
    %      h2 = lillietest(data);
    % compare
    nh1(ti) = lillietest(all_y(cluster_ind{1}));
    nh2(ti) = lillietest(all_y(cluster_ind{2}));
    nh4(ti)= nh1(ti)*nh2(ti);
    if length(cluster_ind)>2 && length(cluster_ind{3})>4
        nh3(ti) = lillietest(all_y(cluster_ind{3}));
        nh4(ti)= nh1(ti)*nh2(ti)*nh3(ti);
    end
    
    % statistics
    if nh4(ti)==1 % normal distribution
        [h,p(ti)] = ttest2(all_y(cluster_ind{1}),all_y(cluster_ind{2}));
    else
        [p(ti),tbl,ks_stats{ti}]  = kruskalwallis(all_y,clustering,'off');
        cks{ti}=multcompare(ks_stats{ti},'CType','bonferroni','Display','off');
    end
    if p(ti)<0.05
        plot([1 2],[max(all_y)*1.03 max(all_y)*1.03],'r'); hold on
    end
    
    
    if length(cluster_ind)>2
        [p4(ti),tbl,ks_stats{ti}]  = kruskalwallis(all_y,clustering,'off');
        cks{ti}=multcompare(ks_stats{ti},'CType','bonferroni','Display','off');
        %% compare 2 to 3
        if nh4(ti)==1 % normal distribution
            [h,p1(ti)] = ttest2(all_y(cluster_ind{2}),all_y(cluster_ind{3}));
        else
            p1(ti)=nan;
        end
        if p1(ti)<0.05
            plot([2 3],[max(all_y)*1.01 max(all_y)*1.01],'r'); hold on
        end
        %% compare 1 to 3
        if nh4(ti)==1 % normal distribution
            [h,p2(ti)] = ttest2(all_y(cluster_ind{1}),all_y(cluster_ind{3}));
        else
            p2(ti)=nan;
        end
        if p2(ti)<0.05
            plot([1 3],[max(all_y)*1.0 max(all_y)*1.0],'r'); hold on
        end
    end
    
    ylabel(traits_to_plot{ti})
    xlim([0.5 3.5])
    switch traits_to_plot{ti}
        case '20/30 ratio'
            ylim([-10 10])
        case {'D second to third peak','D first to second peak'}
            ylim([-2.5 12])
    end
    title(['session ' num2str(cluster_session_ind) ', B' num2str(baseline_method)]) 
end

disp('p = ')
disp(p)
if length(cluster_ind)>2
    disp('p1 = ')
    disp(p1)
    disp('p2 = ')
    disp(p2)
end

for ti=1:length(traits_to_plot)
    disp(traits_to_plot{ti})
    disp(cks{ti})
end


1