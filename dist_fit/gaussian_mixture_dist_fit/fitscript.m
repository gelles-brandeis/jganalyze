% Script to fits and plots pdfs for the specified function
% For example of use, including what variables need to be sett before
% running, see fitscript_example.m

global parm_names
[bin_centers, y, bins, se]=binned_pdf(x',nbins); % for plot

% note: the anonymous function below is required so that bootci
% (below) only tries to bootstrap sample from x and not from
% the other input vectors (i.e., init_parm, lbounds, and ubounds).
fitfun = @(x) mle(x,'pdf',func,'start', init_parm, 'alpha', 0.1,...
    'LowerBound', lbounds, 'UpperBound', ubounds, ...
    'Options', statset('UseParallel', true, 'MaxIter', 200));

phat = fitfun(x'); % do the fit
init_parm = phat;

% now botstrap fit params
pci = bootci(nboot,{fitfun, x'},'alpha', 0.1,...
    'Options', statset('UseParallel', true, 'MaxIter', 200)); 

% make the plot
fig = figure();
orient('portrait');
errorbar(bin_centers, y, se,'ob');
y2 = func(bin_centers',phat);
hold on
plot(bin_centers,y2,'sr');
xlabel('\itE\rm_{FRET}')
ylabel('Prob. density')
legend('Data \pm s.e.', 'Fit');
hold off
fig.Visible='on';
title([dataset '_' func2str(func)], 'Interpreter', 'none')
savefig(fig,[dataset '_' func2str(func)]);

% parameters table
value=phat';
lower_90pct_CI=pci(1,:)';
upper_90pct_CI=pci(2,:)';
fit_parameters = table(value,lower_90pct_CI,upper_90pct_CI,...
    'RowNames',parm_names)