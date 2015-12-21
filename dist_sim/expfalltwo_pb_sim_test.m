%% expfalltwo_pb_sim_test
% Script to test expfalltwo_pb_sim
%%
% Copyright 2014,2015 Jeff Gelles, Brandeis University.
% This is licensed software; see notice at end of file.
%% parameters
n = 2500; % number of dwells to sim at each power
nbins = 15; %number of histogram bins
a = 0.5;
tau1 = 1; 
tau2 = 30;
pwrs = [0.25, 1, 4, 16]; % laser power or exposure 
pb_tau = 10; % photobleaching lifetime at power = 1
tm = 0.1;   % tmin
tx = 200;   % tmax
%% parameters not used in this sim but needed for pb_dwell_fitplot_2exp
ap = sqrt(1 ./ a - 1);
inargzero = 1.5 .* [ap, tau1, tau2, 1 ./ pb_tau];  % initial guesses 
%                               deliberately off by a factor of 1.5
nboot = 20;
%% simulate
pb_taus = pb_tau./pwrs; %actual photobleaching lifetimes
lbls = cell(length(pb_taus),1);
dwellts = [];
pwr = [];
figure();
orient('landscape');
for i = 1:length(pb_taus)
    ts=expfalltwo_pb_sim(a, tau1, tau2, pb_taus(i), n);
    if i == 1 
        [bin_centers, y, bins] = binned_pdf(ts, nbins);
    else
        [~, y, bins] = binned_pdf(ts, bins);
    end
    subplot(2,2,1);
    plot(bin_centers, y, '.-');
    hold on
    subplot(2,2,2);
    semilogy(bin_centers, y, '.-');
    hold on
    lbls{i} = ['Power = ',num2str(pwrs(i))];
    ts = ts(ts > tm & ts < tx); % remove out-of-range dwell times
    dwellts = [dwellts; ts];
    pwr = [pwr; pwrs(i) * ones(length(ts),1)];
end
for j = 1:2
    subplot(2,2,j);
    xlabel('Time (s)')
    ylabel('Probability density (s^-^1)')
    legend(lbls);
end
h=subplot(2,2,3);
ax=gca;
ax.Color='none';
ax.XAxis.Color='none';
ax.YAxis.Color='none';
show_vars({'n'; 'ap'; 'tau1'; 'tau2'; 'pb_tau'; 'tm'; 'tx'});
hold off
%% versions
% ver 2: make output suitable for pb_dwell_fitplot_2exp
%% Notice
% This is free software: you can redistribute it and/or modify it under the
% terms of the GNU General Public License as published by the Free Software
% Foundation, either version 3 of the License, or (at your option) any later
% version.
%
% This software is distributed in the hope that it will be useful, but WITHOUT ANY
% WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
% A PARTICULAR PURPOSE. See the GNU General Public License for more details.
% You should have received a copy of the GNU General Public License
% along with this software. If not, see <http://www.gnu.org/licenses/>.