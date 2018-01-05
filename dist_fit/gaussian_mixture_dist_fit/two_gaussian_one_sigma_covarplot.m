% Script make parameter covariance plots
% for a two gaussian/1 sigma pdf
%% 
% Copyright 2016 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%
fig = figure();
title([dataset '_' func2str(func)], 'Interpreter', 'none')
subplot(2, 2, 1)
plot(bootstat(:,2),bootstat(:,3), '.')
xlabel('mu1')
ylabel('sigma')
subplot(2, 2, 2)
plot(bootstat(:,4),bootstat(:,3), '.')
xlabel('mu2')
ylabel('sigma')
subplot(2, 2, 3)
plot(bootstat(:,4),bootstat(:,1), '.')
xlabel('mu2')
ylabel('p1')
subplot(2, 2, 4)
plot(bootstat(:,3),bootstat(:,1), '.')
xlabel('sigma')
ylabel('p1')
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