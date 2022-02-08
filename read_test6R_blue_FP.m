function read_test6R_blue_FP
% Fiber photomtery data 
% Aug 2021 
if_zscore=0;
experiment='blue_vs_red'
[my_path,states,intensities,g_colors,styles2,Groups,mouse_info]=get_exp_info_test6R_FP(experiment);



for idi=1:length(mouse_info)
%for idi=1:9
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
    ratio_max_to_min{idi}=data{idi}.ratio_max_to_min;
    max_values{idi}=data{idi}.max_value;
end

%%% get mean values
ind_end=853; dark_ind_end=300;
%dark_ind_end=870;%870

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

    mean_ratio_max_to_min(idi)=mean(ratio_max_to_min{idi});
    sem_ratio_max_to_min(idi)=std(ratio_max_to_min{idi})/sqrt(length(ratio_max_to_min{idi}));
    
%     mean_int_df_last_half(idi)=mean(int_df_last_half{idi});
%     sem_int_df_last_half(idi)=std(int_df_last_half{idi})/sqrt(length(int_df_last_half{idi}));
%  
    mean_max_values(idi)=mean( max_values{idi});
    sem_max_values(idi)=std( max_values{idi})/sqrt(length( max_values{idi}));
 
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
        x=t2(t_ind)'-t_start+1;
        this_y=y(ri,t_ind)';
        g = fittype('a-b*exp(-c*x)');
        f0 = fit(x,this_y,g,'StartPoint',[[ones(size(x)), -exp(-x)]\this_y; 1]);
        these_tau(ri)=f0.c;
        xx = linspace(0,10,50);
        plot(x,this_y,styles2{gi},xx,f0(xx),'k-');hold on 
    end
    tau{gi}=these_tau;
end


%% calculate correlation coefficien
all_y=[];
clear cr2
lb1=0;
%for gi=[1:5 7:length(Groups)] % skip the low intensity red 
for gi=[1:length(Groups)] % skip the low intensity red 
    lb1=lb1+1;
    y=nanmean(mean(full_df(Groups{gi},:,:),3));
    y=y-mean(y(1:200)); % remove baseline ( before light is turned on)
    all_y=[all_y; y];
    c_label_states{lb1}=states{gi};
end

for idi1=1:size(all_y,1)
    A(:)=all_y(idi1,:);
    for idi2=idi1:size(all_y,1)
        B(:)=all_y(idi2,:);
        cr2(idi2,idi1)=corr2(A,B);
    end
end
corr_plot(cr2,c_label_states)

% for idi1=1:length(mouse_info)
%     A(:)=nanmean(full_df(idi1,:,:),3);
%     for idi2=1:length(mouse_info)
%         B(:)=nanmean(full_df(idi2,:,:),3);
%         cr2(idi1,idi2)=corr2(A,B);
%     end
% end
%         
% figure
% heatmap(cr2)

% now plot

for gi=1:length(Groups)
figure
    A2=mean(full_df(Groups{gi},:,:),3);
    for i=1:size(A2,1)
        plot(A2(i,:)); hold on
    end
end

figure;
t2=ttmp-ttmp(1);
for gi=1:length(Groups)
    subplot(3,6,gi)
    % for idi=1:6
    %     ph=plot(t(1:ind_end),mean(full_df(idi,:,:),3)); hold on
    %     ph.Color=[0.5 0.5 0.5];
    % end
    % ph2=plot(t(1:ind_end),nanmean(mean(full_df(1:6,:,:),3)));hold on
    % ph2.Color=[0 0 0];
    y=nanmean(mean(full_df(Groups{gi},:,:),3));
    SEM=nanstd(mean(full_df(Groups{gi},:,:),3))/sqrt(length(Groups{gi}));
    figure_params.background=g_colors{gi};figure_params.line='k'; 
%     if gi==3 || gi==4 || gi==5
%         figure_params.background='r';figure_params.line='k';
%     end
    plot_curve_with_SEM(t2(1:ind_end),y,SEM,figure_params)
    ylim([-0.5 12])
    xlim([0 45])
    xlabel('Time (sec)')
    ylabel('dF/F (z-score)')
    title (states{gi})
end

%figure
k=gi
% compare features: 
subplot(3,6,k+1)
for gi=1:ceil(length(Groups)/2)
    y=nanmean(mean(full_df(Groups{gi},:,:),3));
    y=y-mean(y(1:200)); % remove baseline ( before light is turned on)
    plot (t2(1:ind_end),y/max(y),styles2{gi}); hold on
end
ylim([-0.1 1.2])
xlim([0 45])
xlabel('Time (sec)')
ylabel('Normalized dF/F (z-score)')
legend(states{1:ceil(length(Groups)/2)})

% compare features: 

subplot(3,6,k+2)
for gi=ceil(length(Groups)/2)+1:length(Groups)
    y=nanmean(mean(full_df(Groups{gi},:,:),3));
    y=y-mean(y(1:200)); % remove baseline ( before light is turned on)
    plot (t2(1:ind_end),y/max(y),styles2{gi}); hold on
end
ylim([-0.1 1.2])
xlim([0 45])
xlabel('Time (sec)')
ylabel('Normalized dF/F (z-score)')
disp('overlay')
legend(states{ceil(length(Groups)/2)+1:length(Groups)})



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



% boxplot figure
figure
k=0;
subplot(1,6,k+1)
% arrange data for boxplot, Mean AUC
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
ylim([0 700])
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
ylim([0 800])
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
ylim([0 800])
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
ylim([0 14])
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
ylabel('Exponent decay constant (sec-1)')


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
ylim([1 4.5])
xlim([0.5 length(Groups)+0.5])
ylabel('Ratio peak/last (int. 4 seconds)')


%% statistical tests: 
% check normality with one sample Kolmogorov-Smirnov test. h=1 means that
% the distribution is NOT normal 
traits_to_check={'all_mean_df','mean_delta_t_to_max', 'tau','mean_ratio_max_to_last'};
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
       %c = multcompare(stats,'CType','bonferroni');
       c2{pi} = multcompare(stats,'CType','hsd');% Tukey's honest significant difference criterion correction 
        c3{pi} = multcompare(stats,'CType','dunn-sidak');
        % bonferroni correction

    %end
end
    1