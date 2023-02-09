function [color_names1,MEAN_COLOR_t,MEAN_COLOR_dF,diff,analysis] = FP_analysis_lumencore(ID)
experiment_type='VIPFP'
%experiment_type='VIPFP_Onset'
%experiment_type='iCreV'
clear  files1 y all_dF color_order color_names1
LFcut = 2; % cut-off frequency of lowpass filter
order = 4; % N-th order for butterworth filter
POWER=0;
FIG=0;

%%
if nargin == 0
    ID='VIPGCA116R'
    FIG=0;
end
[NUMpar,TXTpar,RAWpar]=xlsread('D:\DATA_Glab\fiberphotometry\Iumencore2.xlsx');

switch ID
    case 'VIPGC106LL'
        side='R'; Gender='M'; rig='SynTDT';
        color_order=NUMpar(5,:)
        Sname='Lumencore6R3';
        date='080619'; Sess_length=345; n_repeats=6;
    case 'VIPGC113L'
        side='R'; Gender='M'; rig='SynTDT';
         color_order=NUMpar(7,:)
         Sname='Lumencore6R4';
         date='081219'; Sess_length=360-15; n_repeats=6;
    case 'VIPGC113Liso'
        side='R'; Gender='M'; rig='SynTDT';
         color_order=NUMpar(6,:)
         Sname='Lumencore6R3';
         date='081219'; Sess_length=180-15; n_repeats=3;
         ID='VIPGC113L';
    case 'VIPGCA116R'
        side='L'; Gender='F'; rig='SynTDT';
         color_order=NUMpar(8,:)
         Sname='Lumencore6R2';
         date='081319';Sess_length=345; n_repeats=6;
    case 'VIPGC119LL'
        side='R'; Gender='F'; rig='SynTDT';
        color_order=NUMpar(9,:)
         Sname='Lumencore6R2';
         date='081319';Sess_length=345; n_repeats=6;
    case 'VIPGC122R'
       side='R'; Gender='F'; rig='SynTDT';
       color_order=NUMpar(10,:)
        Sname='Lumencore6R2';
        date='081319';Sess_length=345; n_repeats=6;
    case 'VIPGC123L'
       side='R'; Gender='F'; rig='SynTDT';
       color_order=NUMpar(11,:)
        Sname='Lumencore6R2';Sess_length=345; n_repeats=6;
        date='081319';
    case 'VIPGFP12R'
        side='M'; Gender='F'; rig='SynTDT';
        color_order=NUMpar(12,:)
        Sname='Lumencore6R1';
        date='081319';Sess_length=345; n_repeats=6;
    case 'VIPGFP14RL'
        side='M'; Gender='F'; rig='SynTDT';
        color_order=NUMpar(13,:)
        Sname='Lumencore6R1';Sess_length=345; n_repeats=6;
        date='081319';
end

k=0;
for i=4:10
    k=k+1;
    color_names1{k}=TXTpar{1,i};
end


switch rig
    case 'TDT'
        path='D:\DATA_Glab\fiberphotometry\TDT_FP\';
    case 'SynTDT'
        path='D:\DATA_Glab\fiberphotometry\SynTDT_FP\';
end

files1=[ID '_' side 'fiber_' date '_' Sname];

% for SCN VIP experiments, in which TTL show when light goes off
% all_files_name={files_name1};
% all_files={files1};

%% read the df data
fullpath=[path files1];
load(fullpath);
all_dF= y;

switch rig
    case 'TDT'
        fs=382; % TDT FP rig
    case 'SynTDT'
        fs = y.fs; %Syn TDT FP rig
end

t1=0.5*fs; %skipping the first 0.5 seconds, the freq and intensity set
%all_dF.Data= all_dF.Data(:,t1:end);

all_dF.data= all_dF.data(:,t1:end);
all_dF.fit400= all_dF.fit400(t1:end);
all_dF.fit400_original=all_dF.fit400;
all_dF.t= all_dF.t(t1:end);
all_dF.dF= all_dF.dF(t1:end);

[dF] = fit_ref(all_dF.data);

%% smooth
tmp = smooth(dF,2*double(fs)); % smoothing
all_dF.dF=tmp';

%% Lowpass
all_dF.dF = lowpass(all_dF.dF,LFcut,double(fs),order); % lowpass filter, see below

%% z-scored
all_dF.dF = (all_dF.dF - median(all_dF.dF))./mad(all_dF.dF,1); % normalization using robust z-score
 
%[h]=check_data(all_dF.data(1,:),all_dF.fit400_original);

start_sec=all_dF.TTL(1);
diff=(15-start_sec);
switch files1
    case 'VIPGCA116R_Lfiber_081319_Lumencore6R2' %TTL wasn't connected 
diff=-3.4;
end

figure

for i=1:length(color_order)% go over each color
    this_start=start_sec+Sess_length*(i-1); % each session is 345 sec
    this_ind=intersect(find(all_dF.t>this_start-start_sec), find(all_dF.t<this_start+345));
   % added_ind=[this_ind(end):1:this_ind(end)+1400];
    %this_ind=[this_ind added_ind];
    dF=all_dF.dF(this_ind );
    %t=all_dF.t(this_ind)-this_start+start_sec;%
    t=all_dF.t(this_ind)-this_start+start_sec+diff;% AK 11/18/21
    
    subplot(length(color_order),1,i)
    plot(t,dF)
    ylabel(color_names1{find(color_order==i)})
    if i==1 ;title(ID); end
    xlim([0 350])
    
    rep_ind_length=[];
    this_color_df=[];
    this_color_t=[];
    for j=1:n_repeats % seperate to repeats
        rep_ind_length=[rep_ind_length length(intersect(find(t>60*(j-1)),find(t<=60*j)))];
    end
    if FIG; figure; end
    for j=1:n_repeats % seperate to repeats
        rep_ind=intersect(find(t>60*(j-1)),find(t<=60*j));
        rep_ind=rep_ind(1:min(rep_ind_length));
        repeat_df=dF(rep_ind);
        repeat_t=t(rep_ind)-60*(j-1);
        %% perctile
        Y = prctile(repeat_df,2);
        repeat_df=repeat_df-Y;
        %%
        this_color_df=[this_color_df ;repeat_df];
        this_color_t=[this_color_t ;repeat_t];
        if FIG; ph1=plot(repeat_t,repeat_df); ylim([0 17]);xlim([8 42]); ph1.Color=[0.3 0.3 0.3]; hold on;  end
        
        %for i=1:length(light_array.light_on)
           % figure; plot (repeat_df)
         
           [max_val(j) ~]=max(repeat_df);
        %end
    end
    find(color_order==i);
     if FIG; ph=plot(repeat_t,mean(this_color_df)); ph.LineWidth=2; ph.Color=[0 0 0]; title([ID ' ' color_names1{find(color_order==i)}]); end
    MEAN_COLOR_dF{find(color_order==i)}=mean(this_color_df);
    MEAN_COLOR_t{find(color_order==i)}=mean(this_color_t);    
   % plot(all_dF.t(this_ind),all_dF.dF(this_ind)+i*2)
   % hold on
   max_val_by_color(find(color_order==i),:)=max_val;
end
analysis.max_values_by_color=max_val_by_color;% 7 colors, 6 repeats
end

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
