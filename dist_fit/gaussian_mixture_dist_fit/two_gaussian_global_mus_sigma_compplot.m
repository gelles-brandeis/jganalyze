% Script to make a plot showing data, mixture model, and individual components
% From variables stored by fitscript
% for a two gaussian/1 sigma pdf
%% 
% Copyright 2016, 2018 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%
fig = figure();
orient('portrait');
histogram('BinEdges',bins, 'BinCounts',y)
hold on
errorbar(bin_centers, y, se,'ob');
efret_cat = ones(length(efret_values'),1) * i;
y2  = func(efret_cat, efret_values', nslice, phatcell{:});
hold on
plot(efret_values,y2,'-r');
% note that gmdistribution second parameter is variance, not s.d.
y3 = phat(i) * pdf(gmdistribution(phat(nslice + 1), phat(nslice + 2)^2),...
    efret_values');
plot(efret_values, y3, ':k');
y4 = (1 - phat(i)) * pdf(gmdistribution(phat(nslice + 3), phat(nslice + 2)^2),...
    efret_values');
plot(efret_values,y4,':k');
xlabel('\itE\rm_{FRET}')
ylabel('Prob. density')
legend('Data', 'Data \pm s.e.', 'Fit', 'Fit components');
hold off
fig.Visible='on';
title([run '_' condition_names{i} ' (n = ' num2str(length(dat)) ')' ],...
        'Interpreter', 'none')
savefig(fig,[run '_' condition_names{i} '_compplot']);
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