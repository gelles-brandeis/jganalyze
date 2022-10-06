% nigm_fitscript: Script to fit and plots pdfs for the specified 
% normalized intensity gaussian mixture (nigm) function
% For example of use, including what variables need to be specified before
% running, see nigm_fitscript_example.m
%
% Inputs
%   nbins -- number of bins in the histograms
%   func - function handle to a function that calculates the pdf
%   x - observations to be fit (an (n x 2) column vector: col 1 is height
%       col 2 is background)
%   nboot - number of bootstrap samples
%   init_parm, lbounds, ubounds - row vectors specifying parameter initial
%       guesses, lower bounds, and upper bounds
%   fit_opts (optional) -- statset() options for mle
%   dataset, (optional) run -- strings to create graph titles and file
%   names
%
%   The pdf function will define global parm_names, a cell array of the
%   parameter names.
%% 
% Copyright 2016, 2019, 2020, 2022 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%
global parm_names
norm_intensity = x(:,1) ./ x(:,2);
[bin_centers, y, bins, se]=binned_pdf(x, nbins); % for plot
if ~exist('fit_opts')
    fit_opts = statset('UseParallel', true, 'MaxIter', 2000, ...
    'MaxFunEvals', 10000);
end
fname = erase(replaceBetween(func2str(func), '(', ')', ''), ...
    [")", "(", " ", "@"]); % remove everything that's not the function name
if ~exist('run')
    titlestring = [dataset '_' fname];
else
    titlestring = [dataset '_' fname '_' run];
end
    
% note: the anonymous function below is required so that bootci
% (below) only tries to bootstrap sample from x and not from
% the other input vectors (i.e., init_parm, lbounds, and ubounds).

fitfun = @(x) mle(x,'pdf',func,'start', init_parm, 'alpha', 0.1,...
    'LowerBound', lbounds, 'UpperBound', ubounds, ...
    'Options', fit_opts);

phat = fitfun(x'); % do the fit

init_parm = phat;

% now bootstrap to get fit params confidence intervals
% Note: using type = per because the default bca algorithm
% implemented by the bootci function is excessively time-consuming for 
% large datasets.
% See https://www.mathworks.com/matlabcentral/answers/52011-why-is-bootci-not-terminating

[pci, bootstat] = bootci(nboot,{fitfun, x'},'alpha', 0.1, 'type',...
    'per', 'Options', fit_opts); 

% make the plot
fig = figure();
orient('portrait');
errorbar(bin_centers, y, se,'ob');
y2 = func(bin_centers',phat);
hold on
plot(bin_centers,y2,'sr');
xlabel('Normalized fluorescence (AU)')
ylabel('Prob. density')
legend('Data \pm s.e.', 'Fit');
hold off
fig.Visible='on';
title(titlestring, 'Interpreter', 'none')
savefig(fig,titlestring);

% make parameters table
value=phat';
lower_90pct_CI=pci(1,:)';
upper_90pct_CI=pci(2,:)';
fit_parameters = table(value,lower_90pct_CI,upper_90pct_CI,...
     lbounds', ubounds', ...
    'RowNames', parm_names, 'VariableNames', {'Value', ...
    'Lower_90pct_CI', 'Upper_90pct_CI', 'Lower_bound', 'Upper_bound'})
%% versions
% 5/10/19 - updated to handle more complex anonymous function names
% gracefully
% 3/27/20 added comment about requiring row vector
% 5/1/20 cleaned up comments, switched booctci to type = norm, added
% optional runname and fit_opts parameters
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