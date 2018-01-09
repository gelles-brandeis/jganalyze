function [bin_centers, y, bins, se] = binned_pdf(x, nbins)
% [bin_centers, y, bins, se] = binned_pdf(x, nbins)
% constructs a binned pdf of vector x suitable for plotting
%
% if nbins is a scalar, program constructs nbins equally populated bins and
% returns bin edges vector bins (nbins + 1 long) and bin_centers (nbins
% long).  [With sparse data, sometimes it is not possible to construct
% nbins unique bins; in this case fewer bins are made.]
% 
% if nbins is a vector, it is used as bin edges and returned in bins;
% bin_centers is also returned
%
% y is the population in each bin
%
% se is the binomial standard error for each bin
%
% typical usage of results: errorbar(bin_centers, y, se)
%%
% Copyright 2014, 2016, 2018 Jeff Gelles, Brandeis University.
% This is licensed software; see notice at end of file. 
%%
if length(nbins) < 2
    bins = unique(prctile(x, 0:(100./nbins):100));
else
    bins = nbins;
end
n = length(x);
if n > 0
    y1 = histc(x, bins);
else
    n = length(bins);
    y1 = zeros(n,1); % histc doesn't handle "no data" inputs gracefully
end
y = y1(1:end-1);
p = y ./ n;
q = 1 - p;
se = sqrt(p .* q ./ n)./ diff(bins)'; % binomial s.e.
y = y ./ diff(bins)' ./ n;  % calculate pdf
bin_centers = bins(1:end-1) + diff(bins) ./ 2;
end
%% versions
% ver 2
% - make sure bins are unique
% ver 3 3/20/16
% - calculate binomial s.e. for each bin
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