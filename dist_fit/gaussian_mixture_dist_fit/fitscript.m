% fitscript: Script to fit and plots pdfs for the specified function
% For example of use, including what variables need to be specified before
% running, see fitscript_example.m
%% 
% Copyright 2016, 2019 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%

global parm_names
[bin_centers, y, bins, se]=binned_pdf(x',nbins); % for plot

% note: the anonymous function below is required so that bootci
% (below) only tries to bootstrap sample from x and not from
% the other input vectors (i.e., init_parm, lbounds, and ubounds).
fitfun = @(x) mle(x,'pdf',func,'start', init_parm, 'alpha', 0.1,...
    'LowerBound', lbounds, 'UpperBound', ubounds, ...
    'Options', statset('UseParallel', true, 'MaxIter', 2000, ...
    'MaxFunEvals', 10000));

phat = fitfun(x'); % do the fit
init_parm = phat;

% now bootstrap to get fit params confidence intervals
[pci, bootstat] = bootci(nboot,{fitfun, x'},'alpha', 0.1,...
    'Options', statset('UseParallel', true, 'MaxIter', 2000, ...
    'MaxFunEvals', 10000)); 

% make the plot
fig = figure();
orient('portrait');
errorbar(bin_centers, y, se,'ob');
y2 = func(bin_centers',phat);
hold on
plot(bin_centers,y2,'sr');
xlabel('Fluorescence (AU)')
ylabel('Prob. density')
legend('Data \pm s.e.', 'Fit');
hold off
fig.Visible='on';
fname = erase(replaceBetween(func2str(func), '(', ')', ''), ...
    [")", "(", " ", "@"]); % remove everything that's not the function name
title([dataset '_' fname], 'Interpreter', 'none')
savefig(fig,[dataset '_' fname]);

% make parameters table
value=phat';
lower_90pct_CI=pci(1,:)';
upper_90pct_CI=pci(2,:)';
fit_parameters = table(value,lower_90pct_CI,upper_90pct_CI,...
    'RowNames',parm_names)
%% versions
% 5/10/19 - updated to handle more complex anonymous function names
% gracefully
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