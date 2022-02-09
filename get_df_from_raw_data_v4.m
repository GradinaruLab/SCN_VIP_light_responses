function [all_dF]=get_df_from_raw_data_v4(all_dF,baseline,params)
% get dF and t after lowpass/ z score etc

%set parameters
LFcut = 2; % cut-off frequency of lowpass filter
order = 4; % N-th order for butterworth filter
Smth=params.Smth;%1;
Lpass=params.Lpass; %1;
Zscore=params.Zscore; %1;
fs=params.fs;
%   end
%% z-scored
if Zscore
        all_dF = (all_dF - nanmedian(baseline))./mad(baseline); % normalization using robust z-score      
end
%% smooth
if Smth
    tmp = smooth(all_dF,3*double(fs)); % smoothing
    all_dF=tmp';
end
%% Lowpass
if Lpass
    %all_dF.data = zeros(size(all_dF.Data));
    if ~isnan(all_dF)
    all_dF = lowpass(all_dF,LFcut,double(fs),order); % lowpass filter, see below
    end
        
end



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



  