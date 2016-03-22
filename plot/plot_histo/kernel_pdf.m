function [yi, l_ci, u_ci] = kernel_pdf(dwells, plot_x, nboot, ci)
% constructs a normal kernel pdf of vector dwells suitable for plotting
%
% dwells - dwell time vector
% plot_x - values along x-axis of hist at which to compute histo
% nboot - number of bootstrap evaluations for c.i. calc; 0 = don't calc c.i.
% confidence interval width 0 < ci < 100
%
% yi - histo values
%%
% Copyright 2016 Jeff Gelles, Brandeis University.
% This is licensed software; see notice at end of file. 
%%
[yi, ~] = ksdensity(dwells,plot_x,'support','positive');
if nboot > 0
    %bootstrap it
    boot_results = zeros(nboot, length(plot_x));
    boot_dwells = zeros(length(dwells),1);
    parfor n = 1:nboot
        boot_dwells = dwells(randi(length(dwells), length(dwells), 1));
        boot_results(n,:) = ksdensity(boot_dwells,plot_x,'support','positive');
    end
    l_ci = prctile(boot_results, (100-ci)./2);
    u_ci = prctile(boot_results, 100 - ((100-ci)./2));
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