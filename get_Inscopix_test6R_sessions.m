function get_Inscopix_test6R_sessions
% go over samples with test6R experiemnt of Inscopix and get the cell
% activity 

 mouse_ID={'50L','134R','148RR','168RL','177RR','264L','310L'}%
 mouse_sex={'M' 'F' 'F' 'F' 'F' 'F' 'F' };
 all_cell_dF=[];
all_cell_t=[]; 
all_dF=[];
mypath='D:\DATA_Glab\Inscopix\Inscopix_Projects\SCNVIP_test6R\';
 for idi=1:length(mouse_ID)
     trial_info.sess_num=1;
     trial_info.estrus=[];
     analysis_params.peak_thresh=8;
     trial_info.exp='test_6R';
   % trial_info.baseline_method=1; % dark 
    trial_info.baseline_method=2; % mean activity  
     Fig=1;
     trial_info.ROI_method='Ins';
     trial_info.fs=5; % Hz
     mouse_info.ID=mouse_ID{idi};
     
     cd ([mypath 'VIPGC' mouse_ID{idi} '_test6R'])
     if exist (['VIPGC' mouse_ID{idi} 'test6R_results_B' num2str(trial_info.baseline_method) '.mat'])
         load(['VIPGC' mouse_ID{idi} 'test6R_results_B' num2str(trial_info.baseline_method) '.mat'])
     else
         [results] = get_Inscopix_single_trial_v3(mouse_info,trial_info);
    end
     all_cell_dF=cat(1,all_cell_dF,results.cell_dF);
     all_cell_t=cat(1,all_cell_t,results.cell_t);
     all_dF=cat(1,all_dF,results.all_dF);
     all_t=results.t_array;
 end
 %all_dF=all_dF([1:57,59:65,67:end],:);
 on=[75:226:226*6];
 off=[150:226:226*6]; 
[df,I]=sort(nanmean(all_dF(:,[on(1):off(1),on(2):off(2),on(3):off(3),on(4):off(4),on(5):off(5),on(6):off(6)]),2));
int=15;
[df2,I2]=sort(nanmean(all_dF(:,[on(1):on(1)+int,on(2):on(2)+int,on(3):on(3)+int,on(4):on(4)+int,on(5):on(5)+int,on(6):on(6)+int]),2));
  
cd ../

figure
subplot(10,1,1)
plot(all_t,nanmean(all_dF))
xlim([0,all_t(end)])
subplot(10,1,[2:10])
imagesc([0 all_t(end)],[1, size(all_dF,1)],all_dF(flip(I),:))
colormap(parula)
caxis([0 8])
colorbar
xlabel('Time (sec)')
ylabel('Cells')

new_dF=all_dF(flip(I),:);
just_non_responsive=new_dF(87:end,:);
just_responsive=new_dF(1:86,:);


figure

subplot(20,1,1)
plot(all_t,nanmean(just_responsive))
xlim([0,all_t(end)])
subplot(20,1,[2:17])
imagesc([0 all_t(end)],[1, size(just_responsive,1)],just_responsive)
colormap(parula)
xlabel('Time (sec)')
ylabel('Cells')

subplot(20,1,18)
plot(all_t,nanmean(just_non_responsive))
xlim([0,all_t(end)])
subplot(20,1,[19:20])
imagesc([0 all_t(end)],[1, size(just_non_responsive,1)],just_non_responsive)
colormap(parula)
xlabel('Time (sec)')
ylabel('Cells')


%%avergae over repeats, using the order I2
figure
for ci=1:size(all_cell_dF,1)
    
    A(:,:)=all_cell_dF(I2(ci),:,:);
    t(:,:)=all_cell_t(I2(ci),:,:);
    plot(nanmean(t,1),nanmean(A,1)+2*ci,'k'); hold on 
    %mean_dF_by_cell(ci,:)=nanmean(A,1);
end
 xlabel('Time (sec)')
 
% colculate correlation coefficien
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


% now save
save(['all_cell_df_B' num2str(trial_info.baseline_method)],'all_cell_dF')
save('all_cell_t_B','all_cell_t')
 