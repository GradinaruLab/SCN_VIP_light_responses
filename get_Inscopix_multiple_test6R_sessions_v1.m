function get_Inscopix_multiple_test6R_sessions_v1
% go over samples with test6R experiemnt of Inscopix and get the cell
% activity 
% updated version: 12092021:
% calculation- added option of 2 baseline methods
EXP='blue'
%trial_info.baseline_method=1; % dark 
trial_info.baseline_method=2; % mean activity  
    
switch EXP
    case 'blue'
        mouse_ID={'304RL','264L','303L','308R'};
        folder_name='SCNVIP_test6R_blue';
        trial_info.sess_num=1;
        trial_info.estrus=[];
        trial_info.fs=5; % Hz
        %trial_info.exp='behavior';
        trial_info.exp='test_6R_multiple';  
        analysis_params.peak_thresh=8;
        trial_info.ROI_method='Ins';
end
Fig=1;
N=4; % number of test6R sessions
trial_info.folder_name=folder_name;
% make sure that data was analyzied and seperated
for idi=1:length(mouse_ID)
    cd (['C:\Users\Anat\Documents\Inscopix_Projects\' folder_name '\VIPGC' mouse_ID{idi} '_test6R' ])
    if exist (['VIPGC' mouse_ID{idi} 'test6R_results_sess' num2str(1) '_B' num2str(trial_info.baseline_method) '.mat'])
       disp('file 1 exist (at least)')
    else
       mouse_info.ID=mouse_ID{idi}; %-308 had some issues
       [results] = get_Inscopix_single_trial_multiple_test6R_sessions(mouse_info,trial_info);
    end
end
% load data 
for i=1:N
    clear all_cell_dF all_cell_t results all_dF
    all_cell_dF=[];
    all_cell_t=[];
    all_dF=[];
    for idi=1:length(mouse_ID)
        trial_info.sess_num=1;
        trial_info.estrus=[];
        analysis_params.peak_thresh=8;
        trial_info.exp='test_6R_multiple';
        Fig=1;
        trial_info.ROI_method='Ins';
        trial_info.fs=5; % Hz
        mouse_info.ID=mouse_ID{idi};
        cd (['C:\Users\Anat\Documents\Inscopix_Projects\' folder_name '\VIPGC' mouse_ID{idi} '_test6R' ])
        %if exist (['VIPGC' mouse_ID{idi} 'test6R_results_sess' num2str(i) '.mat'])
        load(['VIPGC' mouse_ID{idi} 'test6R_results_sess' num2str(i) '.mat'])
        %else
        %    [results] = get_Inscopix_single_trial_multiple_test6R_sessions(mouse_info,trial_info);
        %end
        all_cell_dF=cat(1,all_cell_dF,results.cell_dF);
        all_cell_t=cat(1,all_cell_t,results.cell_t);
        all_dF=cat(1,all_dF,results.all_dF);
        all_t=results.t_array;
    end
    %all_dF=all_dF([1:57,59:65,67:end],:);
    on=[75:226:226*6];
    off=[150:226:226*6];
    if i==1
        [df,I]=sort(nanmean(all_dF(:,[on(1):off(1),on(2):off(2),on(3):off(3),on(4):off(4),on(5):off(5),on(6):off(6)]),2));
    end
    int=15;
    [df2,I2]=sort(nanmean(all_dF(:,[on(1):on(1)+int,on(2):on(2)+int,on(3):on(3)+int,on(4):on(4)+int,on(5):on(5)+int,on(6):on(6)+int]),2));
    
    cd ../
    if length(all_t)<size(all_dF,2);all_dF=all_dF(:,1:length(all_t)); end
    figure
    subplot(10,1,1)
    plot(all_t,nanmean(all_dF))
    xlim([0,all_t(end)])
    subplot(10,1,[2:10])
    imagesc([0 all_t(end)],[1, size(all_dF,1)],all_dF(flip(I),:))
    colormap(parula)
    xlabel('Time (sec)')
    ylabel('Cells')
     title(['Inscopix sess ' num2str(i)])
     colorbar
         % now save
    save(['all_cell_df_sess' num2str(i) '_B' num2str(trial_info.baseline_method) ],'all_cell_dF')
    save(['all_cell_t' num2str(i) '_B' num2str(trial_info.baseline_method)],'all_cell_t')
end



% plot each session, as mean 
figure
for i=1:N
    load(['all_cell_df_sess' num2str(i) '_B' num2str(trial_info.baseline_method) ])
    subplot(1,N,i)
    for ci=1:size(all_cell_dF,1)
        A(:,:)=all_cell_dF(I(ci),:,:);
        t(:,:)=all_cell_t(I(ci),:,:);
        plot(nanmean(t,1),nanmean(A,1)+15*ci); hold on
    end
    xlabel('Time')
    title(['Inscopix sess ' num2str(i)])
    ylim([0 1000])
end


1