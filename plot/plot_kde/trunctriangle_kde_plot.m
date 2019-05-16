function [histox, sy] = trunctriangle_kde_plot(dwells, frameint, tmin, disc_sim_results, histres, smoothing)
% trunctriangle_kde_plot Kernel density estimate plot of dwell time
% distribution using truncated triangle kernels
%
% Inputs:
%     dwells - vector of dwell times in seconds
%     frameint - frame time interval (i.e., start to start or center to center)
%         in seconds
%     timin = shortest tetectable dwell time (seconds)
%     disc_sim_results - the structure (e.g., produced by dwell_time_disc_sim) that
%         cludes the parameters for the truncated triangle PDFs for each real event 
%         length and the detection efficiency for each real event length.
%     histres - resultion of the output histogram in units of frame numbers.  
%         (Optional; default = 0.1)
%     smoothing - smoothing of final histogram in points (Optional; default = 60).
%     
% Outputs: x and y values in smoothed histogram.      
%
% From https://github.com/gelles-brandeis/jganalyze.git
%%
% Copyright 2016 Jeff Gelles, Brandeis University
% This is licensed software; see notice at end of file. 
%%
if nargin < 5
    histres = 0.1;
end
if nargin < 6
    smoothing = 60;
end
fitparm = disc_sim_results.fitparm;
dmax = max(dwells) + frameint;
histox = 0:(frameint * histres):(dmax + frameint);
histoy = zeros(1, length(histox));

% make the histogram by summing data from each measured event length
for i = 1:floor(dmax ./ frameint)  % measured event lengths in frames
    ni = sum(round(dwells./frameint) == i); % number of events of that length
    frow = min(i + 1, size(fitparm, 1)); % row of fitparm to use
    subs = (1 + ((i - 1) / histres)): (1 + ((i + 1) / histres));
%    kern = (trunctriangle_pdf(fitparm(frow, :), (0:histres:2)') .* ni)';
    kern = (trunctriangle_pdf(fitparm(frow, :), (2:-histres:0)') .* ni)';
    histoy(subs) = histoy(subs) + kern;
end

% truncate histo for t < tmin
histoy = histoy(histox >= tmin);
histox = histox(histox >= tmin);

% adjust for detection efficiency
cmax = max(disc_sim_results.truevals); % maximum dwell for which efficiency is available
adjfac = ones(size(histox));
adjfac(histox < cmax) = interp1(disc_sim_results.truevals,...
    disc_sim_results.eff, histox(histox < cmax)); 
histoy = histoy ./ adjfac;

% smooth
sy = smooth(histoy, smoothing);
plot(histox, histoy, '.', 'Color', [0.7 0.7 0.7]);
hold on
plot(histox, sy, '-r');
hold off
xlabel('dwell time (s)');
ylabel('probability density (s^-^1)');
end
%% notice
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
%
% https://github.com/gelles-brandeis/jganalyze.git