function [all_dF] = FP_analysis_individual_test6R_with_params(mouse_info, my_path)
% run single trial test6R
% mouse_info includes:ID,side,date,Sess,Sname,Gender,rig
% MinPeakP,interval,bins,thresh
experiment_type='VIPFP'
%experiment_type='VIPFP_Onset'

clear files_name1 files1 all_dF
% LFcut = 4; % cut-off frequency of lowpass filter
% order = 4; % N-th order for butterworth filter

%% get parameters from file
Ppath='D:\Data_Glab\fiberphotometry\';
par_file_name='ParametersFP';
[NUMpar,TXTpar,RAWpar]=xlsread([Ppath par_file_name '.xlsx']);
rel=NUMpar(1,7); % if peak analysis 'MinPeak' is relative to specific trial
%rel=1; % if peak analysis 'MinPeak' is relative to specific trial
interval=NUMpar(1,1);
bins=NUMpar(:,2)';%[2,5,10,20,30]; %time in minutes
FIGbinned=0;

FIG=0;
if nargin == 0
    
    my_path='D:\Data_Glab\fiberphotometry\TDT_test6R_red\';
    my_path='D:\DATA_Glab\fiberphotometry\TDT_test6R_opn4_antagonist\';
    my_path='D:\Data_Glab\fiberphotometry\TDT_test6R_l_vs_r\';
    
    FIG=1;
    FIGbinned=1;
    %ID='VIPGC60N'; side='R'; Gender='M'; rig='TDT';
    % mouse_info.ID='VIPGC246RL';mouse_info.side='R';mouse_info.Gender='F'; mouse_info.rig='TDT_test6R_red';
   % mouse_info.ID='VIPGC262R';mouse_info.side='R';mouse_info.Gender='M'; mouse_info.rig='TDT_test6R_red';
   % mouse_info.ID='VIPGC286R';mouse_info.side='R';mouse_info.Gender='M'; mouse_info.rig='TDT_test6R_red';
    
   % mouse_info.ID='VIPGC288RL';mouse_info.side='R';mouse_info.Gender='M'; mouse_info.rig='TDT_test6R_red';
    %mouse_info.ID='VIPGC296R';mouse_info.side='R';mouse_info.Gender='M'; mouse_info.rig='TDT_test6R_red';
    % mouse_info.ID='VIPGC298L';mouse_info.side='R';mouse_info.Gender='F'; mouse_info.rig='TDT_test6R_red';
     %  mouse_info.ID='VIPGC313RL';mouse_info.side='L';mouse_info.Gender='M'; mouse_info.rig='TDT_test6R_red';
    mouse_info.ID='VIPGC318L';mouse_info.side='R';mouse_info.Gender='M'; mouse_info.rig='TDT_test6R_red';
      mouse_info.ID='VIPGC349R';mouse_info.side='L';mouse_info.Gender='M'; mouse_info.rig='TDT_test6R_red';
  %  mouse_info.ID='VIPGC371R';mouse_info.side='R';mouse_info.Gender='M'; mouse_info.rig='TDT_test6R_red';
 
    %  mouse_info.ID='VIPGC247RRL';mouse_info.side='R';mouse_info.Gender='F'; mouse_info.rig='TDT_test6R_red';
    %    mouse_info.ID='259R'; mouse_info.side='R';
    %  mouse_info.ID='260L'; mouse_info.side='L';
    %  mouse_info.ID='261RL'; mouse_info.side='R';
    
    % date='111618';
    %date='052119';
    mouse_info.date='081021'; mouse_info.Sname='test6R10';% 040319 - from now on, will include the number as well
    mouse_info.date='020221'; mouse_info.Sname='test6R3';

     mouse_info.date='101421'; mouse_info.Sname='test6R11';
     mouse_info.date='060222'; mouse_info.Sname='test6R1_438';
    % mouse_info.date='101022'; mouse_info.Sname='test6R2_650';
     mouse_info.date='101022'; mouse_info.Sname='test6R1_438';
end

% set more parameters
if strfind(mouse_info.Sname,'test')
    Zscore=0; testYLIM=16.5;
    NUMpar(1,6)=0;
elseif strfind(mouse_info.Sname,'Lumencore')
    Zscore=0;
    NUMpar(1,6)=0;
else
    Zscore=NUMpar(1,6);
end
%USE_INT_FOR_dF=0;
%Smth=1;
Perc=NUMpar(1,5);
% Lpass=1;
% Hpass=1;
%MinPeakP=4;% peak analysis parameter
MinPeakP=NUMpar(1,3); % peak analysis parameter
MinPeakW=4;% in seconds. later that should be read from xls file
% define relevant time 08/06/2019
TRANGE=[0 450]; time_epoc=0;
%T1=light_array.light_on(1)-15;
%TRANGE=[T1 T1+300]; time_epoc=0;
%%%
params.Zscore=Zscore;
params.TRANGE=TRANGE;
params.time_epoc=time_epoc;
%Smth=0; % 102121 check 
%Perc=NUMpar(1,5);%3;;
params.Perc=Perc;
%interval=NUMpar(1,1);
params.interval=interval;
%%%

files_name1=[mouse_info.ID ' ' mouse_info.Gender ' ' mouse_info.side 'fiber ' mouse_info.date  ' '  mouse_info.Sname]
files1=[mouse_info.ID '_' mouse_info.side 'fiber_' mouse_info.date '_' mouse_info.Sname];

% for SCN VIP experiments, in which TTL show when light goes off
% all_files_name={files_name1};
% all_files={files1};

%% read the df data
fullpath=[my_path files1];
load(fullpath);
all_dF= y;

switch mouse_info.ID
    case 'VIPGC60N'; fs=382; % TDT old FP rig
    otherwise; fs=y.fs; % TDT FP rig
end


switch files1
    case 'VIPGC60N_Lfiber_030719_test6R2'
        t1=fs*1;
        t2=fs*200; % 490 stopped working
    otherwise
        t1=fs*2; %skipping the first 10 seconds, the freq and intensity set
        t2=length(all_dF.data);
end

%t1=int32(t1);
%t2=int32(t2);
%% finds light status
[light_array]=finds_light_status(files1,all_dF,mouse_info.Sname,t1,fs);

%% Remove ref with sliding window
%Fit and Align 405 signal to 490, with sliding window
max_size=size(all_dF.data,2); %lowpass data
%interval=240;% will give 4 minutes window

if interval>1
    new_dF=[];
    window_length=interval*fs;
    for i=1:floor(max_size/window_length)
        % Model 490signal = a * 400signal + b;
        % A*theta = B
        % where B = [490signal] and
        % A = [400signal 1-vector];
        % solving linear equation
        if  i*window_length<= length(all_dF.data(1,:))
            data=all_dF.data(:,(i-1)*window_length+1:i*window_length);
        else
            data=all_dF.data(:,(i-1)*window_length+1:end);
        end
        [dF] = fit_ref(data);
        new_dF=[new_dF dF];
        clear data
    end
    % fit to 405 signal of the end
    data=all_dF.data(:,length(new_dF)+1:end);
    [dF] = fit_ref(data);
    new_dF=[new_dF dF];
else
    [new_dF] = fit_ref(all_dF.data);
end
% put new dF to all_dF
all_dF.dF=new_dF;




is_onset=0;
[dF,t,all_dF]=get_df_from_raw_data2(all_dF,fs,params,t1,t2,is_onset);
% (all_dF,fs,params,t1,t2,is_onset)

%% check
%figure;plot(t,dF);hold on; plot(all_dF.t,all_dF.dF);title(files_name1)
t_original=all_dF.t;
all_dF.t=t;
all_dF.dF=dF;
all_dF.fs=fs;

%% reduce sampling rate for data and fit
%reducesampling_f=0.05;
red_data(1,:)=interp1(t_original,all_dF.data(1,:),[1:0.05:t_original(end)]);
red_data(2,:)=interp1(t_original,all_dF.data(2,:),[1:0.05:t_original(end)]);
all_dF.data=red_data;
%new_fs=length(all_dF.dF)/all_dF.t(end);
%all_dF.fit400=interp1(all_dF.t,all_dF.fit400,[1:0.05:all_dF.t(end)]);
all_dF.fit400_original=interp1(t_original,all_dF.fit400_original,[1:0.05:t_original(end)]);

if rel==1
    % remove high amplitude points. based on https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5729554/
    Y=remove_high_amplitute_points(all_dF.dF,all_dF.t,Perc);
    peak_thresh=1*median(Y(find(~isnan(Y))));
elseif rel==0
    peak_thresh=MinPeakP;
end
disp(['This sample peak thresh is: ' num2str(peak_thresh)])

% adjust shift if needed
shift=0;
switch files1
    case 'VIPGC259R_Rfiber_101420_test6Rred1'; shift=+3;
    case 'VIPGC247RRL_Rfiber_101420_test6Rred1' ; shift=+3;
    case 'VIPGC262R_Rfiber_020221_test6R3'; shift=-1;
    case 'VIPGC286R_Rfiber_071921_test6R3'; shift=2;
    case 'VIPGC296R_Rfiber_071921_test6R3'; shift= -1; 
    case 'VIPGC298L_Rfiber_072121_test6R3'; shift=-1;
    case 'VIPGC286R_Rfiber_071921_test6R4'; shift=2.1;
    case 'VIPGC288RL_Rfiber_071921_test6R4'; shift=-1;
    case 'VIPGC286R_Rfiber_072121_test6R5'; shift=2;
    case   'VIPGC288RL_Rfiber_072121_test6R5'; shift=-1;
    case 'VIPGC296R_Rfiber_072121_test6R5'; shift=-0.5;
    case 'VIPGC298L_Rfiber_072721_test6R5'; shift=-0.5;
    case 'VIPGC286R_Rfiber_072121_test6R6'; shift=2.5;
    case 'VIPGC288RL_Rfiber_072121_test6R6'; shift=-0.5;
    case 'VIPGC296R_Rfiber_072121_test6R6'; shift=-0.5;
    case  'VIPGC298L_Rfiber_072721_test6R6'; shift=-0.5;
    case 'VIPGC296R_Rfiber_081021_test6R9'; shift=2.5;
    case 'VIPGC286R_Rfiber_081021_test6R10'; shift=2.5;
    case 'VIPGC288RL_Rfiber_081021_test6R10'; shift=1;
    case  'VIPGC296R_Rfiber_081021_test6R10'; shift=2;
    case 'VIPGC313RL_Rfiber_101921_test6Rredhigh' ; shift=1;
    case 'VIPGC296R_Rfiber_102021_test6Rredlow'; shift=+3;
    case 'VIPGC313RL_Rfiber_101921_test6Rredlow'; shift=+3;
    case 'VIPGC313RL_Rfiber_101821_test6Rbluehigh'; shift=1;
    case 'VIPGC288RL_Rfiber_102121_test6RblueXmed'; shift=2;
end
light_array.light_off=light_array.light_off+shift;
light_array.light_on=light_array.light_on+shift;

% plot to check onset/offset
figure
plot(all_dF.t, all_dF.dF); hold on
plot([light_array.light_off light_array.light_off],[-0.2 max(all_dF.dF)],'b'); hold on
plot([light_array.light_on light_array.light_on],[-0.2 max(all_dF.dF)],'r'); hold on

individual_response_figure=0;
new_t=[];
new_dF=[];
for i=1:length(light_array.light_on)
    
    sec5_ind=max(find(all_dF.t<=5));
    sec2_ind=max(find(all_dF.t<=2));
    inds=intersect(find(all_dF.t>light_array.light_on(i)),find(all_dF.t<light_array.light_off(i)));
    [max_val(i) max_ind]=max(all_dF.dF(inds));
   % [min_val min_ind]=min(all_dF.dF(inds(1)+max_ind:inds(end)));% find min after the max point 
    [min_val min_ind]=min(all_dF.dF(inds));% find global min (when light is on) 
    
    % find time to peak
    delta_t_to_max(i)=all_dF.t(inds(1)+max_ind)-all_dF.t(inds(1));
    
    % calculates integral around peak (+- 3 seconds), OR 5 seconds after
    % peak
   % int_df_around_max(i)=sum(all_dF.dF(inds(1)+max_ind:inds(1)+max_ind+sec5_ind));
    int_df_around_max(i)=sum(all_dF.dF(inds(1)+max_ind-sec2_ind:inds(1)+max_ind+sec2_ind));% 4 seconds interval
    int_df_around_min(i)=sum(all_dF.dF(inds(1)+min_ind-sec2_ind:inds(1)+min_ind+sec2_ind));% 4 seconds interval
%     intersect(find(all_dF.t>light_array.light_off(i)-2*sec2_ind),find(all_dF.t<light_array.light_off(i)))
%     find(all_dF.t<light_array.light_off(i))-42:find(all_dF.t<light_array.light_off(i))
    L=length(all_dF.dF(inds(1)+max_ind-sec2_ind:inds(1)+max_ind+sec2_ind));
    end_inds=max(find(all_dF.t<light_array.light_off(i)))-L: max(find(all_dF.t<light_array.light_off(i)));
    
    ratio_max_to_last(i)=sum(all_dF.dF(inds(1)+max_ind-sec2_ind:inds(1)+max_ind+sec2_ind))/sum(all_dF.dF(end_inds));
    
    ratio_max_to_min(i)=max_val(i)/min_val; % if it breaks here- check the light on defenitions- might need a shift (line 170)
    % an alternative 2: 
    %ratio_max_to_last(i)=mean(all_dF.dF(floor(mean(inds))-sec2_ind:ceil(mean(inds))+sec2_ind))/mean(all_dF.dF(end_inds));
    % an alternative way: 
    %ratio_max_to_last(i)=int_df_around_max(i)/int_df_around_min(i);
    % calculate integral 'begin_int_time' seconds after light on (middle of the light
    % application
    
    begin_int_time=10;% sec
    inds2=intersect(find(all_dF.t>light_array.light_on(i)+begin_int_time),find(all_dF.t<light_array.light_off(i)));
    int_df_last_half(i)=sum(all_dF.dF(inds2));
    
    
    %     % calculate offset time (from light off to mean baseline
    %     stop_ind=min(find(all_dF.t>light_array.light_off(i)));
    %     % find the baseline index, satrting 3 seconds after light off- to
    %     % calculate mean baseline
    %     if i<length(light_array.light_on)
    %         baseline_ind=intersect(find(all_dF.t>sec3_ind+light_array.light_off(i)),find(all_dF.t>light_array.light_on(i+1)));
    %         full_baseline_ind=intersect(find(all_dF.t>light_array.light_off(i)),find(all_dF.t>light_array.light_on(i+1)));
    %     else
    %         baseline_ind=find(all_dF.t>sec3_ind+light_array.light_off(i));
    %         full_baseline_ind=find(all_dF.t>light_array.light_off(i));
    %     end
    %     baseline_df=all_dF.dF(baseline_ind);
    %     for indi=1:length(full_baseline_ind)
    %         if all_dF.dF(full_baseline_ind(1)+indi-1)<(nanmean(baseline_df)+(1/3)*(all_dF.dF(stop_ind)-nanmean(baseline_df)))
    %             offset_ind(indi)=full_baseline_ind(1)+indi-1;
    %         end
    %     end
    %     offset_times(i)=
    %
    if individual_response_figure
        figure
        plot(all_dF.t(inds),all_dF.dF(inds)); hold on
        plot([all_dF.t(inds(1)+max_ind) all_dF.t(inds(1)+max_ind)],[-0.2 max(all_dF.dF)],'r'); hold on
    end
    new_inds=ceil(inds(1)-length(inds)/2):(inds(end)+length(inds)/2);
    new_t=[new_t all_dF.t(new_inds)];
    new_dF=[new_dF all_dF.dF(new_inds)];
end

%[pks{1},locs{1},w{1},p{1}]=findpeaks(all_dF.dF,all_dF.t,'Annotate','extents','WidthReference','halfheight','MinPeakProminence',peak_thresh,'MinPeakWidth',MinPeakW);
[pks{1},locs{1},w{1},p{1}]=findpeaks(new_dF,new_t,'Annotate','extents','WidthReference','halfheight','MinPeakProminence',peak_thresh,'MinPeakWidth',MinPeakW);

state_str={'all' };



for pi=1:length(state_str)
    num_picks(pi)=length(pks{pi});
    peaks_area(pi)=sum(w{pi}.*p{pi});
    peaks_height(pi)=mean(p{pi});
    peaks_width(pi)=mean(w{pi});
end


%now plot
if FIGbinned
    all_test_dF=[];
    event_ind1=intersect(find(all_dF.t>light_array.light_on(1)-15),find(all_dF.t<light_array.light_on(1)+30));
    ttmp=all_dF.t(event_ind1);
    num_sec=34;
   %  num_sec=39;
   % num_sec=42;
    % ttmp=ttmp(1:42*fs)-ttmp(1);
   
   % ttmp=ttmp(1:num_sec*fs)-ttmp(1);
    figure %('name',ID)
    for ti=1:length(light_array.light_on)
        event_ind=intersect(find(all_dF.t>light_array.light_on(ti)-15),find(all_dF.t<light_array.light_on(ti)+30));
        tmp=all_dF.dF(event_ind);
        %all_test_dF=[all_test_dF tmp(1:42*fs)'];
       % all_test_dF=[all_test_dF tmp(1:num_sec*fs)'];
        all_test_dF=[all_test_dF tmp'];
        %plot(ttmp,tmp(1:42*fs),'linewidth',2)
       % plot(ttmp,tmp(1:num_sec*fs),'linewidth',2)
        plot(ttmp,tmp,'linewidth',2)
        hold on
    end
    plot(ttmp, mean(all_test_dF'),'-k','linewidth',4)
    xlabel('time (sec)')
    ylabel ('% dF/F')
    title([mouse_info.ID ' ' num2str(mouse_info.date) ' ' mouse_info.Sname])
   
    ylim([-0.5 testYLIM])
    xlim([0+ttmp(1) 45+ttmp(1)])
    
    figure %('name',ID)
    lo = mean(all_test_dF') - std(all_test_dF')/sqrt(size(all_test_dF,2));
    hi = mean(all_test_dF') + std(all_test_dF')/sqrt(size(all_test_dF,2));
    y=mean(all_test_dF');
    x=ttmp;
    %  hp = patch([x; x(end:-1:1)], [lo; hi(end:-1:1)], 'r');
    hold on;
    hl = line(x,y);
    hold on
    hp = line(x,lo);
    hold on
    hp2 = line(x,hi);
    set(hp, 'color', 'k');
    set(hp2, 'color', 'k');
    
    set(hl, 'color', 'r', 'marker', 'x');
    xlabel('time (sec)')
    ylabel ('% dF/F')
    ylim([-0.5 testYLIM])
     xlim([0+ttmp(1) 45+ttmp(1)])
     title([mouse_info.ID ' ' num2str(mouse_info.date) ' ' mouse_info.Sname])
end


session_length_sec(1)=max(all_dF.t);
session_length_sec(2)=TRANGE(2);
session_length_sec(3)=TRANGE(2);
% activity parameters
all_dF.delta_t_to_max=delta_t_to_max;
all_dF.int_df_around_max=int_df_around_max;
all_dF.int_df_last_half=int_df_last_half;
all_dF.ratio_max_to_last=ratio_max_to_last;
all_dF.ratio_max_to_min=ratio_max_to_min;
all_dF.max_value=max_val;
% peak analysis
peak_analysis.state_str=state_str;
peak_analysis.num_picks=num_picks;
peak_analysis.session_length_sec=session_length_sec;
peak_analysis.peaks_area=peaks_area;
peak_analysis.peaks_height=peaks_height;
peak_analysis.peaks_width=peaks_width;

all_dF.light_array=light_array;
all_dF.peak_analysis=peak_analysis;
all_dF.bins=bins;
MinPeakPstr=num2str(MinPeakP); pind=strfind(MinPeakPstr,'.');
if abs(MinPeakP-round(MinPeakP))>0;MinPeakPstr=[MinPeakPstr(1:pind-1) 'p' MinPeakPstr(pind+1:end)];end
% now save
all_dF.Data=[];
all_dF.fit400=[];
all_dF.TTL=[];

if rel==1
    save([fullpath '_int_processed' MinPeakPstr 'rel_' num2str(interval) '_Perc' num2str(Perc) '_ZS' num2str(Zscore)],'all_dF')
elseif rel==0
    save([fullpath '_int_processed' MinPeakPstr '_' num2str(interval) '_Perc' num2str(Perc) '_ZS' num2str(Zscore)],'all_dF')
end

if FIG
    %% dF/F figure
    XMAX=370;
    
    figure
    subplot (2,1,1)
    %findpeaks(all_dF.dF,all_dF.t,'Annotate','extents','WidthReference','halfheight','MinPeakProminence',MinPeakP,'MinPeakWidth',MinPeakW)
    findpeaks(new_dF,new_t,'Annotate','extents','MinPeakProminence',peak_thresh);
    hold on
    % plot(all_dF(k,i).t,all_dF(k,i).dF)
    hold on
    % ph=line([TTL_min,TTL_min],[-20,30]);
    % hold on
    % set(ph,'color','k')
    hold on
    switch light_array.exp
        case {'Sess','Ses','LDold'} % LD
            lh=line([1 TRANGE(2)],[20,20]);
            set(lh,'color','y','LineWidth',10)
        case {'DL','DLold'}
            lh=line([TRANGE(2) max(all_dF.t)],[20,20]);
            set(lh,'color','y','LineWidth',10)
    end
    ylim([-5,30]);
    xlim([0,XMAX]);
    %  xlim([3600,10800]);
    title([files_name1 ' ,Min Peak=' num2str(MinPeakP)])
    xlabel('Time (sec)','FontSize',12);
    ylabel('dF (Z-score)','FontSize',12);
    
    subplot (2,1,2)
    plot(all_dF.t,all_dF.data(1,:))
    hold on
    plot(all_dF.t,all_dF.data(2,:))
    hold on
    switch light_array.exp
        case {'LD','LDold'}
            lh=line([light_array.light_on light_array.light_off-300],[mean(all_dF.fit400)-0.1,mean(all_dF.fit400)-0.1]);
            set(lh,'color','y','LineWidth',12)
        case {'DL','DLold'}
            lh=line([light_array.light_on-300 max(all_dF.t)],[mean(all_dF.fit400)-0.1,mean(all_dF.fit400)-0.1]);
            set(lh,'color','y','LineWidth',12)
    end
    xlim([0,XMAX]);
    % ylim([mean(all_dF.fit400)-0.15,mean(all_dF.fit400)+0.15]);
    xlabel('Time (sec)','FontSize',12);
    ylabel('raw data','FontSize',12);
    
    
end

end


%%%%%%%%%%





%% fit function, to remove ref from signal
function [dF] = fit_ref(data)
B = data(1,:)';
A = [data(2,:)' ones(length(data),1)];
theta = A\B;
fit400 = theta(1)*data(2,:)+theta(2);
dF = 100*detrend((data(1,:)-fit400)./fit400);
end

function y = lowpass(x,cutoff,Fs,n)
% Butterworth Lowpass Filter (zero-phase distortion filter)
% This creates n-th order Butterworth lowpass filter and takes input
% signal and creates output, the filtered signal.
%
% <Usage>
%
% y = lowpass(x,cutoff,Fs,n)
%
% where x: the unfiltered, raw signal
%       cutoff: cut-off frequency
%       Fs: sampling rate
%       n: the order of Butterworth filter
%       y: the filtered signal
%
% <Example>
%
% y = lowpass(x,100,2000,4);
%
% Coded by Ryan Cho, Oct 21 2013

[b,a] = butter(n,cutoff/(Fs/2),'low');
y = filtfilt(b,a,double(x));
end

function y = highpass(x,order,cutoff,Fs)
[z,p,k] = butter(order,cutoff/Fs,'high');
y = filtfilt(z,p,double(x));
end
