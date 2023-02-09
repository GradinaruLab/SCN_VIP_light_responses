function [results] = get_Inscopix_single_trial_multiple_test6R_sessions(mouse_info,trial_info)
%get single session from Inscopix data, based on Inscopix data analysis: 
% down sample+ MC with Inscopix software + suite2P ROI detection
%or
% based on 'Time-series' data processing with Inscopix 'Processing' 
% down sample to 5Hz, MC with inscopix+ ROI identification manually with
% transperant sheet 07/2021
% function [norm_all_spks,all_spks,norm_all_dF,all_dF,cell_ind,cell_score] = get_fluor_suite2P(mouse_info,sess,exp,Fig,Fs)
% used with get_Inscopix_test6R_sessions_opn4

close all


if nargin==0
    % test 6R: %mouse_ID={'50L','134R','148RR','168RL','177RR'};
    %  mouse_info.ID='50L';
    % mouse_info.ID='148RR';
    %  mouse_info.ID='134R';
    % mouse_info.ID='168RL';
    % mouse_info.ID='310L';
    %  mouse_info.ID='264L'; %
   %mouse_info.ID='303L'; % - some issues- solved by adding nan
   % mouse_info.ID='304RL'; %
    %mouse_info.ID='308R'; %- some issues
     mouse_info.ID='345R'; % -
    % trial_info.date='090720';%MMDDYY
    trial_info.sess_num=1;
    trial_info.estrus=[];
    trial_info.fs=5; % Hz
    %trial_info.exp='behavior';
    trial_info.exp='test_6R_multiple';
    %trial_info.folder_name='SCNVIP_test6R_opn4antagonist';
    %trial_info.folder_name='SCNVIP_test6R_blue'; trial_info.N_6R_sessions=4;   
    trial_info.folder_name='SCNVIP_test6R_blue_opn4antagonist'; trial_info.N_6R_sessions=2;
    %trial_info.path='D:\DATA_Glab\fiberphotometry\';
    analysis_params.peak_thresh=8;
    Fig=1;
    trial_info.ROI_method='Ins';
    %trial_info.baseline_method=1; % dark 
    trial_info.baseline_method=1; % mean activity  

end

Fs=trial_info.fs;
mouse=mouse_info.ID ;
exp=trial_info.exp;
sess=trial_info.sess_num;
ROI_method=trial_info.ROI_method;
baseline_method= trial_info.baseline_method;

switch ROI_method
    case 'Ins'
        mypath='D:\DATA_Glab\Inscopix\' ; %VIPGC148RR\VIPGC148RR_Sess5tiff\suite2p\plane0
end

clear M cell_ind cell_F norm_cell_F
% sub-sessions to keep (some subsessions need to be removed due to
% inseficient motion correction) 


%M_num=mouse_info.M_num; Z=mouse_info.Z; fixed_section=mouse_info.fixed_section; fixed_path=mouse_info.fixed_path; 
switch exp
    case 'test_6R_multiple'
        cd ([  mypath 'Inscopix_Projects\'  trial_info.folder_name '\VIPGC' mouse '_test6R' ])
    case 'Zstack'
        cd ([mypath 'VIPGC' mouse '\all_Zstack\sess' num2str(sess) '\'])
end
%fixedimage=imread([path mouse '\' num2str(Z) 'um\section_' num2str(fixed_section) '_Tissue2GRIN940nm.tif']);
button='No';
all='_all';
if exist(['VIPGC' mouse 'test6R_results_sess' num2str(sess) all '_B' num2str(baseline_method) '_results.mat'])
%if exist(['VIPGC' mouse 'sess' num2str(sess) '_results.mat'])
     
%if exist(['results.csv'])
    message = sprintf('File exists. Do you want to upload');
    button = questdlg(message, 'Continue?', 'Yes', 'No', 'Yes');
    drawnow;  % Refresh screen to get rid of dialog box remnants.
    if strcmpi(button, 'No')
       %continue; % or break or continue, whatever you need.
    end
    if strcmpi(button, 'Yes')
       % load(['VIPGC' mouse 'sess' num2str(sess) '_results.mat'])
        load(['VIPGC' mouse 'test6R_results_sess' num2str(sess) all '_B' num2str(baseline_method) '_results.mat'])
        all_dF=results.all_dF;
        cell_dF=results.cell_dF;
        cell_t=results.cell_t;
        t_array=results.t_array;
        onset_times_ind=results.onset_times_ind;
        offset_times_ind=results.offset_times_ind;
    end
end


%all=[];
%['VIPGC' mouse 'test6R_results_sess' num2str(sess) all '_B' num2str(baseline_method) '_results.mat']
if ~exist(['VIPGC' mouse 'test6R_results_sess' num2str(sess) all '_B' num2str(baseline_method) '_results.mat']) || strcmpi(button, 'No')
    % read the results produced by Inscopix 
            T = readtable(['VIPGC' mouse '_test6R_traces.csv'],'NumHeaderLines',1);
            [NUM]=xlsread(['VIPGC' mouse '_test6R_traces.csv']);
            Accepted_array=strfind(T.Properties.VariableNames(2:end),'rejected');
            cell_ind=cellfun('isempty',Accepted_array);% finds the one that are not rejected 
            cell_ind=[]; % check 012523
            %cell_ind=find(strcmp(T{1,:},'accepted')>0)-1; % defines the cells that are accepted as cell.
            if isempty(cell_ind); cell_ind=1:size(T,2)-1; disp('PAY ATTENTION: no ACCEPTED cells; display ALL cells'); end
            all_sess_F=NUM(:,2:end)'; % the first Y index is time.
            t=NUM(:,1)'; % the first Y index is time.
            
           % data_slicer=find(diff(t)>0.05);
           switch mouse
               case '365L'
                   data_slicer=find(diff(t)==(max(diff(t)))); % based on 'Time-series' data processing
               otherwise
                   data_slicer=find(diff(t)>0.2); % based on 'Time-series' data processing
           end
            data_slicer=[1 data_slicer];
            
    switch exp
         case 'test_6R_multiple'
              N2=trial_info.N_6R_sessions;
              N=6;% number of light repeats in each session 
            if exist (['VIPGC_' mouse '_onset_multiple.mat'])
                load (['VIPGC_' mouse '_onset_multiple.mat']) 
            else
               
               % start_ind=(1:ceil(size(all_sess_F,2)/4):size(all_sess_F,2));
               Full_F=[];
                for i=1:N2
                    figure
                    INDS=[data_slicer(i)+5:data_slicer(i)+ceil(size(all_sess_F,2)/N2-125)];
                    %INDS=[data_slicer(i)+5:data_slicer(i)+ceil(size(all_sess_F,2)/N-10)-10];
                    % for 303L:
                    % INDS=[data_slicer(i)+5:data_slicer(i)+ceil(size(all_sess_F,2)/N-10)-125];
%                     if INDS(end)>length(t) % for some reason 264L had a slightly shorter t
%                         L=INDS(end)-length(t); 
%                         for i=1:L ; t=[t t(end)+mean(diff(t))]; all_sess_F=[all_sess_F all_sess_F(:,end)];end
%                     end
                    if INDS(end)>length(t); 
                        addition_L=INDS(end)-length(t);
                        t=[t nan(1,addition_L)];
                        all_sess_F=[all_sess_F nan(size(all_sess_F,1),addition_L)];
                    end
                    t2=t(INDS);
                    % reset time axis 
                    t2=t2-t2(1);
                    plot(t2,all_sess_F(:,INDS)); hold on
                    %plot(t,all_sess_F(:,:)); hold on
                    title(' choose 1 cursors which is the begining of the first light on')
                    % get x (in sec?) of first light stimuli 
                    [x(i),y(i)] = ginput(1); % choose N cursors which is the begining of the first light on for each session
                    title('Use the cursor to choose the first light event of each session')
                    disp([num2str(x(i)) ' sec: start of light'])
                    Full_F=[Full_F all_sess_F(:,INDS)'];
                    
                end
                R_Full_F=reshape(Full_F,[size(Full_F,1),size(Full_F,2)/N2,N2]);
                x=int16(x);
                save(['VIPGC_' mouse '_onset_multiple.mat'],'x','t2','R_Full_F')
            end
            for i=1:N2
                % find the index based on 't'
                x_ind=min(find(t2>=x(i)));
                offset_times_ind{i}=([x_ind+Fs*30:Fs*45:x_ind+Fs*(30+5*45)])';
                onset_times_ind{i}=([x_ind-Fs*15:Fs*45:x_ind+Fs*(-15+5*45)])';
                 
                %all_F{i}=all_sess_F(:,onset_times_ind{i}(1):offset_times_ind{i}(end));
               % t_array=[0:60/Fs:61*(size(all_F{i},2)-1)/Fs]/600;% time array in sec
               %these_ind=onset_times_ind{i}(1):offset_times_ind{i}(end);
               % for 303L: 
               %these_ind=onset_times_ind{i}(1):offset_times_ind{i}(end)-7;
               % for 308R:
               these_ind=(onset_times_ind{i}(1):offset_times_ind{i}(end));
               if these_ind(1)<1;  these_ind=these_ind-these_ind(1)+1; end
               
                all_F{i}=R_Full_F(these_ind,:,:);
                
               % all_F{i}=reshape(all_F{i},[6, 4, size(all_F{i},1)]);
               t_array{i}=t2(these_ind);
%                 % shift all times, so t_array will start at zero 
%                 Tmin=min( t_array{i});
%                  t_array{i}= t_array{i}-Tmin;
%                  offset_times_ind{i}=offset_times_ind{i}-Tmin;
%                  onset_times_ind{i}=onset_times_ind{i}-Tmin;
                % check
                clear A
                A(:,:)=all_F{i}(:,:,i);
                figure; plot(t_array{i}',A)
                if sum(diff(diff(onset_times_ind{i})))>0 ; disp 'wrong session seperation' ; end
            end

    end
    % seperate data to 6 repeats. 
    check_seperation=0;
    for  i=1:N2
        for ci=1:size(all_F{i},2)
            for hi=1:size(offset_times_ind{i},1)
                these_inds=onset_times_ind{i}(hi):offset_times_ind{i}(hi);
                
                if these_inds(end)>size(R_Full_F,1) % for 303L: 
                    L1=these_inds(end)-size(R_Full_F,1);
                    these_inds=these_inds-L1;
                end
                dF{i}(ci,hi,:)=R_Full_F(these_inds,ci,i);% cell/hour or session/time_series
                dt{i}(ci,hi,:)=t2(these_inds);
                % set the t based on the first session 
                %time_ind=[onset_times_ind{1}(hi):offset_times_ind{1}(hi)]; %-size(t_array{i},2)*(i-1);
                %cell_t{i}(ci,hi,:)=t_array{i}(time_ind-time_ind(1)+1);
                
                
                %cell_t{i}(ci,hi,:)=t_array{i}(time_ind);
                %cell_t{i}(ci,hi,:)=cell_t{i}(ci,hi,:)-min(cell_t{i}(ci,hi,:))+(hi-1)*45;
                
            end
            if check_seperation
                 clear A B 
                A(:,:)=dt{i}(ci,:,:);
                B(:,:)=dF{i}(ci,:,:);
                figure; plot(A(1,:),B);
               
            end
        end
    end
    
    % calculate baseline for this session
    params.fs=Fs;
    params.Smth=1;
    params.Lpass=1;
    params.Zscore=1;
    
   
    baseline_ind=1:10*Fs; % first 10 seconds 
    dark_sessions=[6];%%% AK 12/09/21
    % get df for each 10 minutes seperatly
    %baseline=median(all_F(dark_sessions,:),1);
    for  i=1:N2% number of light events 
        for ci=1:size(dF{i},1)
            for hi=1:length(offset_times_ind{i}) %  creats 6h array
                if baseline_method==1; baseline=median(dF{i}(ci,hi,baseline_ind),1); end
                if baseline_method==2; baseline=median(dF{i}(ci,dark_sessions,:),1); end%%% AK 12/09/21
                [new_dF{i}(ci,hi,:)]=get_df_from_raw_data_v4(dF{i}(ci,hi,:),baseline,params);
            end
        end
    end
    
    %%%%%%%%%%%%%check how that fits
    norm_all_spks=[];
    norm_cell_spks=[];
    for  i=1:N2
        cell_dF{i}=new_dF{i}(cell_ind,:,:);% take just the accepted cells
        cell_t{i}=dt{i}(cell_ind,:,:);% take just the accepted cells
    end
    if check_seperation
        clear A B 
        for  i=1:N2 
            figure; 
            for ci=1:size(cell_dF{i},1)
                for hi=1:size(cell_dF{i},2)
                    A(:)=cell_t{i}(ci,hi,:);
                    B(:)=cell_dF{i}(ci,hi,:);
                    plot(A,B);hold on;
                end
            end
        end
    end
    %%%%change format for figure
%     all_dF=[];
%     all_t=[];
%     for  i=1:N
%         all_dF{i}=reshape(cell_dF{i},[size(cell_dF{i},1),size(cell_dF{i},2)*size(cell_dF{i},3)]);
%         all_t{i}=reshape(cell_t{i},[size(cell_t{i},1),size(cell_t{i},2)*size(cell_t{i},3)]);
%     end
%     
    for  i=1:N2
        all_dF2{i}=[];
        all_t{i}=[];
        for ci=1:size(cell_dF{i},1)
            A=[];
            At=[];
            for hi=1:size(cell_dF{i},2)
                B=cell_dF{i}(ci,hi,:);C=B(:);
                A=[A C'];
                Bt=cell_t{i}(ci,hi,:);Ct=Bt(:);
                At=[At Ct'];
            end
            all_dF2{i}(ci,:)=A;
            all_t{i}(ci,:)=At;
        end
    end
    
end

if check_seperation
    for i=1:N2
        figure
        for ci=1:size(all_t{i},1)
            plot(all_t{i}(ci,:),all_dF2{i}(ci,:)'); hold on
        end
    end
end
% 
% 
% %% plot show traces in order to remove points
% for  i=1:N
%     hFig=figure;
%     ButtonH=uicontrol('Parent',hFig,'Style','togglebutton','String','DONE','Units','normalized','Position',[0.0 0.1 0.1 0.1],'Visible','on');
%     
%     while ButtonH.Value<1
%         for ci=1:size(all_dF{i},1)
% %             inds=(onset_times_ind{ci}(1)-5:offset_times_ind{ci}(end));
% %             if inds(1)<1; inds=inds(inds>0);end
%             ph{ci}=plot(all_t{i}(ci,:),all_dF{i}(ci,:)+ci*20,'*-');
%             hold on
%         end
%         title([mouse ' ,sess ' num2str(sess) ' norm F- choose a period to remove by choosing 2 points. Press DONE within 4 seconds if done. otherwise- choose more periods'])
%         [x, y] = ginput(2);
%         removed_inds=intersect(find(t_array{i}>x(1)),find(t_array{i}<x(2)));
%         removed_inds=int16(removed_inds)-onset_times_ind{i}(1)+5;
%         % removed_inds=int64(removed_inds)-onset_times_ind(1)+5;
%         for ci=1:size(all_dF{i},1)
%             all_dF{i}(ci,removed_inds)=nan;
%         end
%         pause(4);
%         for ci=1:size(all_dF{i},1); ph{ci}.Visible='off'; end
%     end
% end
%% figure to show traces map
% figure
% plot(all_dF2{i}(1,:))
for i=1:N2
    figure
    imagesc(all_dF2{i})
    title([mouse ' ,sess ' num2str(i) 'norm F map'])
    xlabel('ind')
end

%devide the new all_F 
for i=1:N2
    for ci=1:size(all_dF2{i},1)
        for hi=1:length(offset_times_ind{i})
                             % for 303L: 10/25/21
            %these_inds=onset_times_ind{i}(1):offset_times_ind{i}(end)-7;
           % cell_dF{i}(ci,hi,:)=all_dF2{i}(ci,these_inds);% cell/hour/time_series
        
           cell_dF{i}(ci,hi,:)=all_dF2{i}(ci,onset_times_ind{i}(hi)-onset_times_ind{i}(1)+1:offset_times_ind{i}(hi)-onset_times_ind{i}(1)+1);% cell/hour/time_series
           
        end
    end
end

for i=1:N2
    results.all_dF=all_dF2{i};
    results.cell_dF=cell_dF{i};
    results.cell_t=cell_t{i}-cell_t{i}(1,1,1);
    % for i=1:N
    %     results.t_array{i}=t_array{i}(onset_times_ind{i}(1):offset_times_ind{i}(end)+5)-t_array(onset_times_ind(1));
    % end
    results.t_array=t_array{i};
    results.onset_times_ind=onset_times_ind{i};
    results.offset_times_ind=offset_times_ind{i};
    
    save (['VIPGC' mouse 'test6R_results_sess' num2str(i) all '_B' num2str(baseline_method)],'results');
end


end

