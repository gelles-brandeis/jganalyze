% global_fitscript: Script to  globally fit and plot pdfs 
% for the specified function under multiple experimental conditions
% For example of use, including what variables need to be fit before
% running, see global_fitscript_example.m
%
% Inputs
%   func - function handle
%   fit_data - observation to be fit (a column vector)
%   fit_category - categories of each observation (a column vector)
%   nboot - number of bootstrap samples

%% 
% Copyright 2016, 2018 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%
global parm_names

% this anonymous function is to get around the restriction that mle can 
% take only 1-D data...
func2 = @(fit_data, varargin) func(fit_category, fit_data, nslice, varargin{:});
% ...and this anonymous function is required so that (if we were using) bootci
% it will only try to bootstrap sample from the data and not from
% the other input vectors (i.e., init_parm, lbounds, and ubounds).
fitfun = @(b) mle(b,'pdf',func2,'start', init_parm, 'alpha', 0.1,...
    'LowerBound', lbounds, 'UpperBound', ubounds, ...
    'Options', statset('UseParallel', true, 'MaxIter', 2000, ...
    'MaxFunEvals', 10000));

phat = fitfun(fit_data); % do the fit
phatcell = num2cell(phat);
log_likelihood = sum(log(func(fit_category, fit_data, nslice, phatcell{:})))
init_parm = phat;

% now bootstrap to get fit params confidence intervals
% can't use bootci here because we must randomly sample each category
% separately
bootparm = zeros(nboot,length(phat));
h=waitbar(0, 'Bootstrapping...');
for j = 1:nboot
    samp_fit_data = zeros(length(fit_data),1);
    for i = 1:nslice
        index = fit_category == i;
        dat=fit_data(index);
        index2 = ceil(length(dat) * rand(length(dat),1));
        samp_fit_data(index) = dat(index2); % bootstrap samp one category
    end
    bootparm(j,:) = fitfun(samp_fit_data);
    waitbar(j/nboot);
end
close(h)
se = std(bootparm);
lower_90pct_CI=prctile(bootparm, 5);
upper_90pct_CI=prctile(bootparm, 95);

% make parameters table
value=phat;
fit_parameters = table(value', se', lower_90pct_CI', upper_90pct_CI',...
    'RowNames', parm_names', 'VariableNames', {'Value', 'SE', ...
    'Lower_90pct_CI', 'Upper_90pct_CI'})

% make one fit plot for each condition
for i = 1:nslice
    dat = fit_data(fit_category == i);
    [bin_centers, y, bins, se]=binned_pdf(dat, nbins); % for plot
    fig = figure();
    orient('portrait');
    errorbar(bin_centers, y, se,'ob');
    bin_cat = ones(length(bin_centers'),1) * i;
    y2 = func(bin_cat, bin_centers',nslice, phatcell{:});
    hold on
    plot(bin_centers,y2,'sr');
    xlabel('\itE\rm_{FRET}')
    ylabel('Prob. density')
    legend('Data \pm s.e.', 'Fit');
    hold off
    fig.Visible='on';
    title([run '_' condition_names{i} ' (n = ' num2str(length(dat)) ')' ],...
        'Interpreter', 'none')
    savefig(fig,[run '_' condition_names{i}]);
    
    plot_function();
end
%% notice
% This is free software: you can redistribute it and/or modify it under the
% terms of the GNU General Public License as published by the Free Software
% Foundation, either version 3 of the License, or (at your option) any later
% version.

% This software is distributed in the hope that it will be useful, but WITHOUT ANY
% WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
% A PARTICULAR PURPOSE. See the GNU General Public License for more details.
% You should have received a copy of the GNU General Public License
% along with this software. If not, see <http://www.gnu.org/licenses/>.