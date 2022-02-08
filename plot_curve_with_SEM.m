function plot_curve_with_SEM(x,y,SEM,figure_params)
% plot curve with sem 
curve1 = y + SEM;
curve2 = y - SEM;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
fill(x2, inBetween, figure_params.background,'FaceAlpha',.7);
hold on;
plot(x, y, figure_params.line, 'LineWidth', 2); hold on;