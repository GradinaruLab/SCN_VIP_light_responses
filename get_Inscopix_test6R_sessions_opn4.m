function get_Inscopix_test6R_sessions_opn4
% go over samples with test6R experiemnt of Inscopix and get the cell
% activity 
% Data of multiple test6R sessions is analyzied with 'time-series' in
% Inscopix Data Processing (IDP)
% following this - use Inscopix_test6R_sessions_opn4_plots

round=2
all='_all'% all cell, ignore rejected or not

switch round
    case 1 % white light. opn4. imaging was out of focus after injection, and was not corrected
        mouse_ID={'310L','264L','303L'};
        N=4;
        trial_info.folder_name='SCNVIP_test6R_opn4antagonist';
    case 2 % blue light. opn4. corrected for z-plane change
        mouse_ID={'345R','351RL','365L','368RL'};
        N=2;
        trial_info.folder_name='SCNVIP_test6R_blue_opn4antagonist';
end

trial_info.round=round;
trial_info.baseline_method=1; % 2- mean activity. 1- before activity 
trial_info.N_6R_sessions=N; % number of test6R session that were analysied together as one time series in IDP 
        
% make sure that data was analyzied and seperated
for idi=1:length(mouse_ID)
    my_path= 'D:\DATA_Glab\Inscopix\Inscopix_Projects\'
   % my_path='C:\Users\Anat\Documents\Inscopix_Projects\'
    cd ([my_path trial_info.folder_name '\VIPGC' mouse_ID{idi} '_test6R' ])
    if exist (['VIPGC' mouse_ID{idi} 'test6R_results_sess' num2str(1) all '_B' num2str(trial_info.baseline_method) '.mat'])
        disp('file 1 exist (at least)')
    else
        trial_info.sess_num=1;
        trial_info.estrus=[];
        trial_info.fs=5; % Hz
        trial_info.exp='test_6R_multiple';        
        analysis_params.peak_thresh=8;
        trial_info.ROI_method='Ins';        
        mouse_info.ID=mouse_ID{idi};
        trial_info.N_6R_sessions=N; 
        [results] = get_Inscopix_single_trial_multiple_test6R_sessions(mouse_info,trial_info);
    end
end
% load data 
for i=1:N
    clear all_cell_dF all_cell_t results all_dF
    all_cell_dF=[];
    all_cell_t=[];
    all_dF=[];
    k=0;
    for idi=1:length(mouse_ID)
        trial_info.sess_num=1;
        trial_info.estrus=[];
        analysis_params.peak_thresh=8;
        trial_info.exp='test_6R_multiple';
        Fig=1;
        trial_info.ROI_method='Ins';
        trial_info.fs=5; % Hz
        mouse_info.ID=mouse_ID{idi};
        cd ([my_path trial_info.folder_name '\VIPGC' mouse_ID{idi} '_test6R' ])
        %if exist (['VIPGC' mouse_ID{idi} 'test6R_results_sess' num2str(i) '.mat'])
        load(['VIPGC' mouse_ID{idi} 'test6R_results_sess' num2str(i) all '_B' num2str(trial_info.baseline_method) '.mat'])
        %else
        %    [results] = get_Inscopix_single_trial_multiple_test6R_sessions(mouse_info,trial_info);
        %end
        all_cell_dF=cat(1,all_cell_dF,results.cell_dF);
        all_cell_t=cat(1,all_cell_t,results.cell_t);
        all_dF=cat(1,all_dF,results.all_dF);
        all_t=results.t_array;
        for ci=1:size(results.cell_dF,1)
            k=k+1;
            cell_info(k).mouse_ID= mouse_ID{idi};
            cell_info(k).cell_ID=ci-1; 
        end
    end
    %all_dF=all_dF([1:57,59:65,67:end],:);
    on=[75:226:226*6];
    off=[150:226:226*6];
    [df,I]=sort(nanmean(all_dF(:,[on(1):off(1),on(2):off(2),on(3):off(3),on(4):off(4),on(5):off(5),on(6):off(6)]),2));
    int=15;
    [df2,I2]=sort(nanmean(all_dF(:,[on(1):on(1)+int,on(2):on(2)+int,on(3):on(3)+int,on(4):on(4)+int,on(5):on(5)+int,on(6):on(6)+int]),2));
    
    cd ../
    if length(all_t)<size(all_dF,2);all_dF=all_dF(:,1:length(all_t)); end
    
    figure
    subplot(10,1,1)
    plot(all_t,nanmean(all_dF))
    xlim([0,all_t(end)])
    subplot(10,1,[2:10])
    imagesc([0 10*all_t(end)],[1, size(all_dF,1)],all_dF(flip(I),:))
    colormap(parula)
    xlabel('Time (sec)')
    ylabel('Cells')
    title(['Inscopix sess ' num2str(i)])
    %%avergae over repeats, using the order I2
    figure
    for ci=1:size(all_cell_dF,1)
        
        A(:,:)=all_cell_dF(I2(ci),:,:);
        t(:,:)=all_cell_t(I2(ci),:,:);
        plot(nanmean(t,1),nanmean(A,1)+2*ci,'k'); hold on
        %mean_dF_by_cell(ci,:)=nanmean(A,1);
    end
    
    xlabel('Time')
    title(['Inscopix sess ' num2str(i)])
    % colculate correlation coefficien
    corrc=0;
    if corrc
        clear A
        for ci=1:size(all_cell_dF,1)
            A(:,:)=all_cell_dF(I2(ci),:,:);
            %t(:,:)=all_cell_t(ci,:,:);
            mean_dF_by_cell(ci,:)=nanmean(A,1);
        end
        for si1=1:size(mean_dF_by_cell,1)
            for si2=1:size(mean_dF_by_cell,1)
                cr2(si1,si2)=corr2(mean_dF_by_cell(si1,:),mean_dF_by_cell(si2,:));
            end
        end
        
        figure
        heatmap(cr2)
        colorbar
        caxis ([-20 50])
        title(['Inscopix sess ' num2str(i)])
    end
    % now save
    save(['all_cell_df_sess' num2str(i) all '_B' num2str(trial_info.baseline_method) ],'all_cell_dF')
    save(['all_cell_t' num2str(i) all '_B' num2str(trial_info.baseline_method) ],'all_cell_t')
end

save('trial_info','trial_info')
save('cell_info','cell_info')

