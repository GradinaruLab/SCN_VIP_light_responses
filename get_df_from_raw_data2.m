function [dF,t,all_dF]=get_df_from_raw_data2(all_dF,fs,NUMpar,t1,t2,TRANGE,time_epoc,is_onset)
% get dF and t after lowpass/ z score etc

%set parameters
LFcut = 2; % cut-off frequency of lowpass filter
order = 4; % N-th order for butterworth filter
Zscore=NUMpar(1,6);%3;; % zero when amplitude is compared 
Smth=1;
%Smth=0; % 102121 check 
Perc=NUMpar(1,5);%3;;
Lpass=1;
interval=NUMpar(1,1);
    
t1=int32(t1);
all_dF.data= all_dF.data(:,t1:t2);
all_dF.fit400= all_dF.fit400(t1:t2);
all_dF.fit400_original=all_dF.fit400;
all_dF.t= all_dF.t(t1:t2);
all_dF.dF= all_dF.dF(t1:t2);

%% trying to remove ref with sliding window
%Fit and Align 405 signal to 490, with sliding window

%interval=240;% will give 4 minutes window
if interval>1
    max_size=size(all_dF.data,2); %lowpass data
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
  
  
 
%   if ~isempty(Factors) % for session onset. used in v4
%       this_median=Factors.median;
%       this_mad=Factors.mad;
%       
%   else
      this_median=median(all_dF.dF);
       this_mad=mad(all_dF.dF,1);
%       
%   end
if Zscore
    %% z-scored
    all_dF.dF = (all_dF.dF - this_median)./this_mad; % normalization using robust z-score
    %  all_dF = (all_dF - mean(all_dF))./std(all_dF); % standard z-score
    all_dF.fit400 = (all_dF.fit400 - median(all_dF.fit400))./mad(all_dF.fit400,1); % normalization using robust z-score
 
end
if Smth
    %% smooth
    tmp = smooth(all_dF.dF,2*double(fs)); % smoothing
    all_dF.dF=tmp';
     tmp2 = smooth(all_dF.fit400,2*double(fs)); % smoothing
    all_dF.fit400=tmp2';
end
if Lpass
    %% Lowpass
    %all_dF.data = zeros(size(all_dF.Data));
    all_dF.dF = lowpass(all_dF.dF,LFcut,double(fs),order); % lowpass filter, see below
    all_dF.fit400 = lowpass(all_dF.fit400,LFcut,double(fs),order); % lowpass filter, see below
end
%% perctile
if Perc
%     if ~isempty(Factors)% for sessOnset 
%         this_Y=Factors.Y;
%     else
        this_Y=prctile(all_dF.dF,10);
%    end
    all_dF.dF=all_dF.dF-this_Y;
    Y2 = prctile(all_dF.fit400,2);
    all_dF.fit400=all_dF.fit400-Y2;
end

if is_onset.is
    all_dF.dF=all_dF.dF(1:is_onset.L-t1);
    all_dF.data=all_dF.data(:,1:is_onset.L-t1);
    all_dF.fit400_original(1:is_onset.L-t1);
    all_dF.t=all_dF.t(1:is_onset.L-t1);
end
%t = 0:1/fs:length(all_dF.dF)/fs-1/fs;
all_dF.dF=all_dF.dF(intersect(find(all_dF.t>time_epoc+TRANGE(1)),find(all_dF.t<(time_epoc+TRANGE(2)))));
all_dF.data=all_dF.data(:,intersect(find(all_dF.t>time_epoc+TRANGE(1)),find(all_dF.t<(time_epoc+TRANGE(2)))))-time_epoc-TRANGE(1);
all_dF.fit400_original=all_dF.fit400_original(intersect(find(all_dF.t>time_epoc+TRANGE(1)),find(all_dF.t<(time_epoc+TRANGE(2)))))-time_epoc-TRANGE(1);
% also put t start to ~zero
all_dF.t=all_dF.t(intersect(find(all_dF.t>time_epoc+TRANGE(1)),find(all_dF.t<(time_epoc+TRANGE(2)))))-time_epoc-TRANGE(1);

%% reduce sampling rate 
dF=interp1(all_dF.t,all_dF.dF,[1:0.05:all_dF.t(end)]);
%all_dF.fit400=interp1(all_dF.t,all_dF.fit400,[1:0.05:all_dF.t(end)]);
t=[1:0.05:all_dF.t(end)];

% Factors.median=median(all_dF.dF);
% Factors.mad=mad(all_dF.dF,1);
% Factors.Y=this_Y;


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



  