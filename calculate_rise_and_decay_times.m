function [times] = calculate_rise_and_decay_times(input)
% calculates the decay and rise times of a GCaMP signal 
% AK July 2021


x = input.t(input.t>=input.OFF);
y = input.df(input.t>=input.OFF);
f = fit(x,y,'exp1')

figure
plot(input.t,input.df); hold on
plot(x,y,'k')