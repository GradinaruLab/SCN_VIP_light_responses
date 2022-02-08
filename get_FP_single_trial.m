function [dF,t,analysis]=get_FP_single_trial(mouse_info, trial_info);
% get time_series data and calculate event and dF 
% read by 'get_FP_per_mouse_FP'
 

clear y data
if nargin==0
 %  mouse_info.ID='296R'; mouse_info.side='R';% male
  mouse_info.ID='288RL'; mouse_info.side='R';% male
   %mouse_info.ID='286R'; mouse_info.side='R';% male
    trial_info.rig='SynTDT';
    trial_info.date='082721';trial_info.sess_num=3; %MMDDYY
    
    trial_info.n_onsets=4;% 4 for 2 sessions of light. 2 for 1 session of light on 
  %  trial_info.estrus=[];
   % trial_info.to_remove=[];
    trial_info.show=1;
    trial_info.path='D:\DATA_Glab\fiberphotometry\';
    %analysis_params.peak_thresh=7;
end

rig=trial_info.rig;
  %  D:\DATA_Glab\fiberphotometry\TDT_sess20
load([trial_info.path '\TDT_sess20\VIPGC' mouse_info.ID '_' mouse_info.side 'fiber_' trial_info.date '_sess20_' num2str(trial_info.sess_num) '.mat'])
%load('VIPGC198R_Rfiber_063020_TimeSeriesSess8.mat')
data=y;
% switch rig;     case 'TDT';  fs = data{1}.fs; % TDT FP rig; 
%                 case 'SynTDT'; fs = data{1}.fs; %Syn TDT FP rig 
% end
fs = data.fs;
% parameters for basic data analysis dF/F
params.Smth=1;%1;
params.Lpass=1; %1;
params.Zscore=1; %1;
params.fs=fs;

dF=data.dF;
t=data.t;
% first 5 minutes are dark 
% dark
% problematic
%dark_inds=int16([10*fs:5*60*fs,15*60*fs:20*60*fs,30*60*fs:35*60*fs]); %

dark_inds=int16([10*fs:5*60*fs]); 

% calculate baseline for this session 
baseline=dF(dark_inds);

dF=get_df_from_raw_data_v4(dF,baseline,params);

cd([trial_info.path '\TDT_sess20'])

if exist (['VIPGC_' mouse_info.ID '_sess20_' num2str(trial_info.sess_num) '_onsets.mat'])
    load(['VIPGC_' mouse_info.ID '_sess20_' num2str(trial_info.sess_num) '_onsets.mat'])
else
    title(' choose 2 cursors which are the begining and the end of light on')
    % get x (in sec?) of light stimuli
    [x,y] = ginput(trial_info.n_onsets); % choose N cursors which is the begining of the first light on for each session
    title('Use the cursor to choose the first and last light event')
    disp([num2str(x(1)) ' sec: start of light'])
   % Full_F=[Full_F all_sess_F(:,INDS)'];
    save(['VIPGC_' mouse_info.ID '_sess20_' num2str(trial_info.sess_num) '_onsets.mat'],'x')
end

baseline_ind=find(t<x(1)); % x in seconds
baseline_ind=baseline_ind(10*params.fs:end);% remove 10 first seconds 
if trial_info.n_onsets==2
    light_ind=intersect(find(t>x(1)),find(t<x(2))); % x in seconds
    after_ind=find(t>x(2));
elseif length(x)==1
    light_ind=find(t>x(1)); % x in seconds
elseif trial_info.n_onsets==4
    light_ind=intersect(find(t>x(1)),find(t<x(2))); % x in seconds
    after_ind=intersect(find(t>x(2)),find(t<x(3)));
    light_ind2=intersect(find(t>x(3)),find(t<x(4))); % x in seconds
    after_ind2=find(t>x(4));
else
    disp('x is zero?')
end

seperated_dF{1}=dF(baseline_ind);
seperated_t{1}=t(baseline_ind);
seperated_dF{2}=dF(light_ind);
seperated_t{2}=t(light_ind);
if trial_info.n_onsets==2
    seperated_dF{3}=dF(after_ind);
    seperated_t{3}=t(after_ind);
end
if trial_info.n_onsets==4
    seperated_dF{3}=dF(after_ind);
    seperated_t{3}=t(after_ind);
    seperated_dF{4}=dF(light_ind2);
    seperated_t{4}=t(light_ind2);
    seperated_dF{5}=dF(after_ind2);
    seperated_t{5}=t(after_ind2);
end
% 
for hi=1:length(seperated_dF)
    seperated_dF{hi}=seperated_dF{hi}-nanmean(seperated_dF{1});
end

% set peak_threshold
analysis_params.peak_thresh=nanmean(seperated_dF{1})+1*std(seperated_dF{1});
%analysis_params.peak_thresh=8;
figure
% calculates event params
for hi=1:length(seperated_dF)
    if mean(isnan(dF))==0
        subplot(1, length(seperated_dF), hi)
        [allpks{hi},alllocs{hi},allw{hi},allp{hi}]=findpeaks(seperated_dF{hi},seperated_t{hi},'Annotate','extents','MinPeakProminence', analysis_params.peak_thresh);
        %
        findpeaks(seperated_dF{hi},seperated_t{hi},'Annotate','extents','MinPeakProminence', analysis_params.peak_thresh);hold on
        ylim([-50 400] )
    else
        allpks{hi}=[]; alllocs{hi}=[];allw{hi}=[]; allp{hi}=[];
    end
end


colors={[0 0 0],[0.5 0.5 0.5],[0 0 0],[1 0 0],[0 0 0]};
figure
for hi=1:length(seperated_t)
    plot(seperated_t{hi},seperated_dF{hi},'Color',colors{hi}); hold on
end
ylim([-50 250]); ylabel('dF/F (Z-stack)')
xlim([0 2100]); xlabel('Time (sec)')
title(['VIPGC' mouse_info.ID ' ' trial_info.date ' sess ' num2str(trial_info.sess_num) ])
 
for hi=1:length(seperated_dF)
    if ~isempty(allpks{hi})
        width(hi)=nanmedian(allw{hi});
        height(hi)=nanmedian(allp{hi});
        rate(hi)=length(allpks{hi})/((max(seperated_t{hi})-min(seperated_t{hi}))/60);% event per minute
    else
        height(hi)=nan;
        width(hi)=nan;
        rate(hi)=0;
    end
    %int_df(hi)=sum(seperated_dF{hi})/((max(seperated_t{hi})-min(seperated_t{hi}))/60);% per minute
       int_df(hi)=sum(seperated_dF{hi});%
end

%rel_rate=rate-(mean(rate([1,3,5])));

rel_rate=rate-min(rate);
rel_int=int_df-min(int_df);
rel_amp=height-min(height); 

if trial_info.show==1
      % plot rate/df
    figure 
    subplot(1,4,1)
    plot([1:length(seperated_dF)], rel_rate,'-*'); hold on 
    ylabel('rel rate'); ylim([0 3]);xlim([0.5  length(seperated_dF)+0.5])
    subplot(1,4,2)
    plot([1:length(seperated_dF)], rel_int,'-o'); hold on 
    ylabel('int dF'); ylim([-500000 10000000]);xlim([0.5  length(seperated_dF)+0.5])
    subplot(1,4,3)
    plot([1:length(seperated_dF)], width,'-*'); hold on 
    ylabel('width'); ylim([0 20]);xlim([0.5  length(seperated_dF)+0.5])
    subplot(1,4,4)
    plot([1:length(seperated_dF)], height,'-o'); hold on 
    ylabel('height'); ylim([0 200]);xlim([0.5  length(seperated_dF)+0.5])

    title(['VIPGC' mouse_info.ID ' ' trial_info.date ' sess ' num2str(trial_info.sess_num) ])
 
end

analysis.med_width=width;
analysis.med_amplitude=height;
analysis.rel_amp=rel_amp;
analysis.rel_rate=rel_rate;
analysis.rel_int=rel_int;
disp(analysis)
1
