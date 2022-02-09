function [all_dF] = FP_analysis_individual_test6R(mouse_info, my_path)
% run single trial test6R 
% mouse_info includes:ID,side,date,Sess,Sname,Gender,rig
% MinPeakP,interval,bins,thresh
experiment_type='VIPFP'
%experiment_type='VIPFP_Onset'
clear files_name1 files1 all_dF

%% get parameters from file
Ppath='D:\Data_Glab\fiberphotometry\';
par_file_name='ParametersFP';
[NUMpar,TXTpar,RAWpar]=xlsread([Ppath par_file_name '.xlsx']);
rel=NUMpar(1,7); % if peak analysis 'MinPeak' is relative to specific trial
interval=NUMpar(1,1);
bins=NUMpar(:,2)';%[2,5,10,20,30]; %time in minutes
thresh=NUMpar(1,4);%3;
FIGbinned=0;

FIG=1;
if nargin == 0
    
    my_path='D:\Data_Glab\fiberphotometry\TDT_test6R_red\';
    %my_path='D:\DATA_Glab\fiberphotometry\TDT_test6R_opn4_antagonist\';
    
    FIG=1;
    %ID='VIPGC60N'; side='R'; Gender='M'; rig='TDT';
    % mouse_info.ID='VIPGC246RL';mouse_info.side='R';mouse_info.Gender='F'; mouse_info.rig='TDT_test6R_red';
    mouse_info.ID='VIPGC262R';mouse_info.side='R';mouse_info.Gender='M'; mouse_info.rig='TDT_test6R_red';
    % mouse_info.ID='VIPGC286R';mouse_info.side='R';mouse_info.Gender='M'; mouse_info.rig='TDT_test6R_red';
    %mouse_info.ID='VIPGC288RL';mouse_info.side='R';mouse_info.Gender='M'; mouse_info.rig='TDT_test6R_red';
    %mouse_info.ID='VIPGC296R';mouse_info.side='R';mouse_info.Gender='M'; mouse_info.rig='TDT_test6R_red';
    % mouse_info.ID='VIPGC298L';mouse_info.side='R';mouse_info.Gender='F'; mouse_info.rig='TDT_test6R_red';
    
    %  mouse_info.ID='VIPGC247RRL';mouse_info.side='R';mouse_info.Gender='F'; mouse_info.rig='TDT_test6R_red';
    % mouse_info.ID='259R'; mouse_info.side='R';
    %  mouse_info.ID='260L'; mouse_info.side='L';
    %  mouse_info.ID='261RL'; mouse_info.side='R';
    
    % date='111618';
    %date='052119';
    mouse_info.date='081021';
    mouse_info.Sname='test6R10';% 040319 - from now on, will include the number as well

end

% set more parameters
if strfind(mouse_info.Sname,'test')
    Zscore=0; testYLIM=15;
    NUMpar(1,6)=0;
elseif strfind(mouse_info.Sname,'Lumencore')
    Zscore=0;
    NUMpar(1,6)=0;
else
    Zscore=NUMpar(1,6);
end
USE_INT_FOR_dF=0;
Smth=1;
Perc=NUMpar(1,5);
Lpass=1;
Hpass=1;
%MinPeakP=4;% peak analysis parameter
MinPeakP=NUMpar(1,3); % peak analysis parameter
MinPeakW=4;% in seconds. later that should be read from xls file

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

% define relevant time 08/06/2019
TRANGE=[0 450]; time_epoc=0;
%T1=light_array.light_on(1)-15;
%TRANGE=[T1 T1+300]; time_epoc=0;


is_onset.is=0;
[dF,t,all_dF]=get_df_from_raw_data2(all_dF,fs,NUMpar,t1,t2,TRANGE,time_epoc,is_onset);

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
new_fs=length(all_dF.dF)/all_dF.t(end);
%all_dF.fit400=interp1(all_dF.t,all_dF.fit400,[1:0.05:all_dF.t(end)]);
all_dF.fit400_original=interp1(t_original,all_dF.fit400_original,[1:0.05:t_original(end)]);

if rel==1
    % remove high amplitude points. based on https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5729554/
    Y=remove_high_amplitute_points(all_dF.dF,all_dF.t,Perc);
    peak_thresh=MinPeakP*median(Y(find(~isnan(Y))));
elseif rel==0
    peak_thresh=MinPeakP;
end
disp(['This sample peak thresh is: ' num2str(peak_thresh)])


[pks{1},locs{1},w{1},p{1}]=findpeaks(all_dF.dF,all_dF.t,'Annotate','extents','WidthReference','halfheight','MinPeakProminence',peak_thresh,'MinPeakWidth',MinPeakW);
state_str={'all' };


for pi=1:length(state_str)
    num_picks(pi)=length(pks{pi});
    peaks_area(pi)=sum(w{pi}.*p{pi});
    peaks_height(pi)=mean(p{pi});
end


%now plot
if FIGbinned
    all_test_dF=[];
    event_ind1=intersect(find(all_dF.t>light_array.light_on(1)-15),find(all_dF.t<light_array.light_on(1)+30));
    ttmp=all_dF.t(event_ind1);
    num_sec=34;
    % num_sec=39;
    num_sec=42;
    % ttmp=ttmp(1:42*fs)-ttmp(1);
    ttmp=ttmp(1:num_sec*fs)-ttmp(1);
    figure %('name',ID)
    for ti=1:length(light_array.light_on)
        event_ind=intersect(find(all_dF.t>light_array.light_on(ti)-15),find(all_dF.t<light_array.light_on(ti)+30));
        tmp=all_dF.dF(event_ind);
        %all_test_dF=[all_test_dF tmp(1:42*fs)'];
        all_test_dF=[all_test_dF tmp(1:num_sec*fs)'];
        %plot(ttmp,tmp(1:42*fs),'linewidth',2)
        plot(ttmp,tmp(1:num_sec*fs),'linewidth',2)
        hold on
    end
    plot(ttmp, mean(all_test_dF'),'-k','linewidth',4)
    xlabel('time (sec)')
    ylabel ('% dF/F')
    ylim([0 testYLIM])
    xlim([0 num_sec])
    
    figure ('name',ID)
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
    ylim([0 testYLIM])
    xlim([0 num_sec])
end


session_length_sec(1)=max(all_dF.t);
session_length_sec(2)=TRANGE(2);
session_length_sec(3)=TRANGE(2);


peak_analysis.state_str=state_str;
peak_analysis.num_picks=num_picks;
peak_analysis.session_length_sec=session_length_sec;
peak_analysis.peaks_area=peaks_area;
peak_analysis.peaks_height=peaks_height;
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
    findpeaks(all_dF.dF,all_dF.t,'Annotate','extents','MinPeakProminence',peak_thresh);
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
    ylim([-5,15]);
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
    
    
    if FIGbinned
        %% pick analysis figure
        colors_bar=[0.8 0.8 0.8;0.1 0.1 0.1;1 1 0];
        %% 10/4/18- I couldn't apply the colors through the text in Matlab- I opened the figure and changed it using matlab interface
        figure
        ph=subplot(1,2,1);
        bh=bar(num_picks./session_length_sec);
        ph.XTickLabel=state_str;
        bh.CData=colors_bar;
        %bh.FaceColor=colors_bar;
        title('peaks/sec')
        ph=subplot(1,2,2);
        bh=bar(peaks_area);
        ph.XTickLabel=state_str;
        bh.CData=colors_bar;
        title('Peaks area: prominance * width')
        text(2,2,[files_name1 ' ,Min Peak=' num2str(MinPeakP)])
        
        %% PSTH
        switch light_array.exp
            case {'Ses','Sess','LD','LDold','DL','DLold'} %Light to Dark or Dark to light
                figure
                k=0;
                for i=1:length(all_dF.all_binned_t_dark)
                    if length(all_dF.all_binned_t_dark{i})>2
                        k=k+1;
                        subplot(length(all_dF.all_binned_t_dark),1,k)
                        ph=bar(all_dF.all_binned_t_dark{i}(2:end),all_dF.dF_binnedpeaks_dark{i});
                        set(ph,'Facecolor',[0.2 0.2 0.2])
                        hold on
                        ph=bar(all_dF.all_binned_t_light{i}(2:end),all_dF.dF_binnedpeaks_light{i});
                        set(ph,'Facecolor',[1 1 0])
                        hold on
                        if i==1; title(files_name1); end
                        xlim([0,XMAX]);
                    end
                end
                
                
            case {'SessOnset'}
                figure
                for i=1:length(all_dF.dF_binned_peaks)
                    subplot(length(bins),1,i)
                    ph=bar(all_dF.all_binned_t{i}(2:end),all_dF.dF_binned_peaks{i});
                    set(ph,'Facecolor',[1 1 0])
                    hold on
                    if i==1; title(files_name1); end
                    xlim([600,XMAX+200]);
                end
                
                
        end
    end
  
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
