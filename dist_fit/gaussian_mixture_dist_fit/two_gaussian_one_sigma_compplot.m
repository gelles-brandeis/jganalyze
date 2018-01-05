% Script to make a plot showing data, mixture model, and individual components
% From variables stored by fitscript
% for a two gaussian/1 sigma pdf
%% 
% Copyright 2016 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%
fig = figure();
orient('portrait');
histogram('BinEdges',bins, 'BinCounts',y)
hold on
errorbar(bin_centers, y, se,'ob');
efret_values = -0.4:0.01:1;
y2  = func(efret_values',phat);
hold on
plot(efret_values,y2,'-r');
% note that gmdistribution second parameter is variance, not s.d.
y3 = phat(1) * pdf(gmdistribution(phat(2), phat(3)^2),efret_values');
plot(efret_values,y3,':k');
y4 = (1 - phat(1)) * pdf(gmdistribution(phat(4), phat(3)^2),efret_values');
plot(efret_values,y4,':k');
xlabel('\itE\rm_{FRET}')
ylabel('Prob. density')
legend('Data', 'Data \pm s.e.', 'Fit', 'Fit components');
hold off
fig.Visible='on';
title([dataset '_' func2str(func)], 'Interpreter', 'none')
savefig(fig,[dataset '_' func2str(func)]);
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