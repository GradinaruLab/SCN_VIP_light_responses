function read_Inscopix_opn4_exp
% after running get_Inscopix_test6R_sessions_opn4
% changed to: 
% get_Inscopix_single_trial_multiple_test6R_sessions
% 2 and 4 are white light experiments, 1 and 3 are red light
% 3 and 4 are after opn4 antagonist

clear results
N=4;
 my_path= 'D:\DATA_Glab\Inscopix\Inscopix_Projects\'
% load data
for i=1:N
    clear all_cell_dF all_t_df
    load([my_path '\SCNVIP_test6R_opn4antagonist\all_cell_df_sess' num2str(i) ]);
    load([my_path 'SCNVIP_test6R_opn4antagonist\all_cell_t' num2str(i)]);
    
    eval(['results.all_cell_dF_sess' num2str(i) '=all_cell_dF']);
    eval(['results.all_cell_t_sess' num2str(i) '=all_cell_t']);
    
end

% extract data from 'results' 
% 1 is red light. 2- white light. 3 and 4: red and white, after opn4
% antagonist 
for i=1:N
    eval(['dF' num2str(i) '=results.all_cell_dF_sess' num2str(i) ';']);
    eval(['t' num2str(i) '=results.all_cell_t_sess' num2str(i) ';']);
end

% average over repeats
for i=1:N
    % the eval will do this: (for each i)
%     ave_dF2(:,:)=mean(dF2,2);
%     ave_t2(:,:)=mean(t2,2);
%     N_ave_dF2=normr(ave_dF2);
    eval(['ave_dF' num2str(i) '(:,:)=mean(dF' num2str(i) ',2);']);
    eval(['ave_t' num2str(i) '(:,:)=mean(t' num2str(i) ',2);']);
    % sem 
    eval(['ave_dF' num2str(i) '_sem(:,:)=std(dF' num2str(i) ',0,2)/size(dF2,2);']);
    eval(['N_ave_dF' num2str(i) '=normr(ave_dF' num2str(i) ');']);
end


%% First - look at averaged values to compare with FP 
cells_to_remove=[4,5,20,21];
cells_to_include=[1:3,6:19];

%red light 
data_to_plot{1}=ave_dF1(cells_to_include,:);
sem_to_plot{1}=ave_dF1_sem(cells_to_include,:);
t_to_plot{1}=ave_t1(cells_to_include,:);
%white light 
data_to_plot{2}=ave_dF2(cells_to_include,:);
sem_to_plot{2}=ave_dF2_sem(cells_to_include,:);
t_to_plot{2}=ave_t2(cells_to_include,:);
%red light after opn4 antagonist
data_to_plot{3}=ave_dF3(cells_to_include,:);
sem_to_plot{3}=ave_dF3_sem(cells_to_include,:);
t_to_plot{3}=ave_t3(cells_to_include,:);
%white light after opn4 antagonist
data_to_plot{4}=ave_dF4(cells_to_include,:);
sem_to_plot{4}=ave_dF4_sem(cells_to_include,:);
t_to_plot{4}=ave_t4(cells_to_include,:);
colors={'r', 'k', 'r','k'};
fig_titles={'Red' , 'White', 'red light after opn4 antagonist', 'white light after opn4 antagonist'};

% now plot averaged over cells
figure
k=0;
for pi=1:3:12
    k=k+1;
    subplot(4,3,pi)
    plot(data_to_plot{k}',colors{k}); hold on;
    ylim([-5 45])
end
k=0;
for pi=2:3:12
    k=k+1;
    subplot(4,3,pi)
    y=mean(data_to_plot{k},1);
    SEM=sem_to_plot{k};
    figure_params.background=[0.95 0.95 0.95];figure_params.line=colors{k};
     plot_curve_with_SEM(t_to_plot{k}(1,:),y,SEM,figure_params); hold on
    ylim([-5 20])
end
k=0;
for pi=3:3:12
    k=k+1;
    subplot(4,3,pi)
    y=mean(data_to_plot{k},1);
    SEM=nanstd(data_to_plot{k},1)/sqrt(size(data_to_plot{k},1));
    y=y-mean(y(1:40));
    SEM=SEM-mean(y(1:40));
    figure_params.background=[0.95 0.95 0.95];figure_params.line=colors{k};
    %plot_curve_with_SEM(t_to_plot{k}(1,:),y/max(y),SEM/max(y),figure_params); hold on
    plot_curve_with_SEM(t_to_plot{k}(1,:),y,SEM,figure_params); hold on
     ylim([-5 45])
    title(fig_titles{k})
end


% plot just white light, w and w/o opn4 antagonist 
% using median 
cells_to_include_red=[3,6:13,15,18,20,21];
for i=1:N
    data_to_plot{i}=eval(['ave_dF' num2str(i) '(cells_to_include_red,:);']);
end
colors{1}='r';
colors{2}='k';
colors{3}='m';
colors{4}='g';
shifts=[2 0 2.5 1];
figure
m=0;
for k=1:N
    m=m+1;
    y=median(data_to_plot{k},1);
    y=y-mean(y(1:40));
    plot(t_to_plot{k}(1,:)-t_to_plot{k}(1,1)+shifts(m),y/max(y),colors{k}); hold on 
    title('Before (white-black, red-red) and after (white-green, red-magenta) opn4 antangonist, white light')
    ylim([-0.05 1.05])
end

%% now look at individual cells, 
% white light (sessions 2 and 4), before and after opn4 antagonist 
% load data
shifts=[0 1];
t=t_to_plot{1}(1,:)-t_to_plot{1}(1,1);
on_ind=intersect(find(t>22),find(t<30));
figure
for ci=cells_to_include
    subplot (ceil(size(ave_dF1,1)/5), 5, ci) 
    % plot after opn4
    figure_params.background=[0.95 0.95 0.95];figure_params.line='g';
    yy=ave_dF4(ci,:); yy2=yy-mean(yy(1:40)); yy3=yy2/max(yy2);
    SEM=ave_dF4_sem(ci,:);SEM=SEM-mean(yy(1:40)); SEM=SEM/max(yy2);
    plot_curve_with_SEM(t+1.1,yy3,SEM,figure_params); hold on

    % before opn4
    figure_params.background=[0.95 0.95 0.95];figure_params.line='k';
    y=ave_dF2(ci,:); y2=y-mean(y(1:40)); y3=y2/max(y2);
    SEM=ave_dF2_sem(ci,:);SEM=SEM-mean(y(1:40)); SEM=SEM/max(y2);
    plot_curve_with_SEM(t,y3,SEM,figure_params); hold on
    

    cr(ci)=corr2(y3(on_ind),yy3(on_ind));
    title ([num2str(ci) ' corr2= ' num2str(cr(ci)) ])  
end

%% now look at individual cells, 
% red vs white light (sessions 1 and 2)
% load data
t=t_to_plot{1}(1,:)-t_to_plot{1}(1,1);
on_ind=intersect(find(t>15),find(t<30));
figure
for ci=cells_to_include_red
    subplot (ceil(size(ave_dF1,1)/5), 5, ci) 
    % plot after opn4
    figure_params.background=[0.5 0.0 0.0];figure_params.line='r';
    yy=ave_dF1(ci,:); yy2=yy-mean(yy(1:40)); yy3=yy2/max(yy2);
    SEM=ave_dF1_sem(ci,:);SEM=SEM-mean(yy(1:40)); SEM=SEM/max(yy2);
    plot_curve_with_SEM(t+1.1,yy3,SEM,figure_params); hold on

    % before opn4
    figure_params.background=[0.95 0.95 0.95];figure_params.line='k';
    y=ave_dF2(ci,:); y2=y-mean(y(1:40)); y3=y2/max(y2);
    SEM=ave_dF2_sem(ci,:);SEM=SEM-mean(y(1:40)); SEM=SEM/max(y2);
    plot_curve_with_SEM(t,y3,SEM,figure_params); hold on
    

    cr(ci)=corr2(y3(on_ind),yy3(on_ind));
    title ([num2str(ci) ' corr2= ' num2str(cr(ci)) ])  
end
1


