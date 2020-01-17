% gamma_fit_script.m: script to fit gamma function to dwell time data
% n.b. needs statistics and parallel processing toolboxes

%  fit
model = 'Gamma';
ndwells = length(dwells);
pd = fitdist(dwells, model);
a_shape = pd.a;
b_scale = pd.b;
plot_x = 0:1:x_max;
plot_y = pdf(pd,plot_x);

% parameter confidence intervals (90% CI)
[ci, bootstat] = bootci(nboot,{@gamma_fit, dwells},'alpha', 0.1,...
    'Options', statset('UseParallel', true));
a_lower_90_ci = ci(1, 1);
a_upper_90_ci = ci(2, 1);
b_lower_90_ci = ci(1, 2);
b_upper_90_ci = ci(2, 2);
% parm_names =  {'a_shape'; 'a_lower_90_ci'; 'a_upper_90_ci';...
%     'b_scale'; 'b_lower_90_ci'; 'b_upper_90_ci'};
% fit_parameters = table(a_shape, a_lower_90_ci, a_upper_90_ci,...
%     b_scale, b_lower_90_ci, b_upper_90_ci...
%     )
%     'RowNames', parm_names)

fig = figure();
orient('portrait');
%% plot parameter covariance
subplot (3,2,5);
plot (bootstat(:,1),bootstat(:,2),'.')
title ('Fit parameter covariance');
xlabel ('shape a');
ylabel ('scale b (s)');
% set lower axis limits to zero
xl = xlim;
xlim([0, xl(2)]);
yl = ylim;
ylim([0, yl(2)]);

%% plot pdf
subplot (3,2,2);
plot(plot_x,plot_y)
hold on
[bin_centers, y, bins, se] = binned_pdf(dwells,n_bins);
errorbar(bin_centers,y,se,'or')
hold off
title ('Binned PDF');
xlabel ('dwell time (s)');
ylabel ('pdf (s^{-1})');
legend ('fit', 'data \pm s.e.');

%% normal kernel histogram
[yi, l_ci, u_ci] = kernel_pdf(dwells, plot_x, nboot, 90);
subplot(3,2,4);
h=area(plot_x,[l_ci;u_ci-l_ci]','LineStyle','none');
h(1).FaceColor=[1,1,1];
h(2).FaceColor=[1,0.85,0.85];
hold on
plot(plot_x,yi,'r', plot_x, plot_y, 'b');
title ('Gaussian kernel PDF');
xlabel ('dwell time (s)');
ylabel ('pdf (s^{-1})');
legend (' ','data 90% c.i.','data', 'fit');
hold off

%% survival plot
% numerically integrate the pdf
allts = sort(dwells);
n_allts = length(allts);
f = n_allts:-1:0;
f = f ./ n_allts;
allts = [0; allts];

subplot(3,2,6);
sf = 1. - cdf(pd, plot_x);
plot(plot_x, sf, '-b', allts, f, '.r');
title ('Survival fraction');
xlabel ('lifetime (s)');
ylabel ('fraction');
legend ('fit','data');

%% Annotate plot
show_vars({'dataset', 'ndwells', 'model', 'a_shape', 'b_scale', 'a_lower_90_ci',...
    'a_upper_90_ci', 'b_lower_90_ci', 'b_upper_90_ci'}, [3, 2, 1]);
%savefig(dataset);