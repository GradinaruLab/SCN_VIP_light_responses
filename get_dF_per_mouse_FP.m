function [Output] = get_dF_per_mouse_FP(mouse_info, trial_info)
% used for sess_20 experiments (SCN-VIP light 2021)
% uses get_FP_single_trial 
if nargin==0
    mouse_info.dates={'082721'; '083021'};%MMDDYY
    mouse_info.sessions=[3,4];
    mouse_info.ID='288RL'; mouse_info.side='R';% male
    %mouse_info.ID='286R'; mouse_info.side='R';% male
    trial_info.rig='SynTDT';
    trial_info.n_onsets=4;% 4 for 2 sessions of light. 2 for 1 session of light on
    trial_info.show=0;
    trial_info.path='D:\DATA_Glab\fiberphotometry\';
end

for si=1:length(mouse_info.dates)
    trial_info.date=mouse_info.dates{si};
    trial_info.sess_num=mouse_info.sessions(si);
    [dF{si},t{si},analysis{si}]=get_FP_single_trial(mouse_info, trial_info);
end
% normalized 
this_mouse_rel_amp=[];% 5 sessions
this_mouse_rel_int=[];% 5 sessions
this_mouse_rel_rate=[];% 5 sessions
  this_mouse_norm_rel_amp=[];
  this_mouse_norm_rel_int=[];
  this_mouse_norm_rel_rate=[];
for si=1:length(analysis)
   this_mouse_norm_rel_amp=[this_mouse_norm_rel_amp; analysis{si}.rel_amp/max(analysis{si}.rel_amp)];
   this_mouse_norm_rel_int=[this_mouse_norm_rel_int; analysis{si}.rel_int/max(analysis{si}.rel_int)];
   this_mouse_norm_rel_rate=[this_mouse_norm_rel_rate ;analysis{si}.rel_rate/max(analysis{si}.rel_rate)];
   this_mouse_rel_amp=[this_mouse_rel_amp; analysis{si}.rel_amp];
   this_mouse_rel_int=[this_mouse_rel_int; analysis{si}.rel_int];
   this_mouse_rel_rate=[this_mouse_rel_rate ;analysis{si}.rel_rate];

end

Output.this_mouse_rel_amp=this_mouse_rel_amp;
Output.this_mouse_rel_int=this_mouse_rel_int;
Output.this_mouse_rel_rate=this_mouse_rel_rate;

Output.this_mouse_norm_rel_amp=this_mouse_norm_rel_amp;
Output.this_mouse_norm_rel_int=this_mouse_norm_rel_int;
Output.this_mouse_norm_rel_rate=this_mouse_norm_rel_rate;