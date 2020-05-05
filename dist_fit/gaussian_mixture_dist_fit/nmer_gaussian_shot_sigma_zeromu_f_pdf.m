function y = nmer_gaussian_shot_sigma_zeromu_f_pdf(x, nmer, varargin)
% pdf values for a (nmer+1)-component Gaussian mixture model for fitting
% intensity distributions from SMF data on a randomly labeled homomultimer
% with one or zero dyes per protomer.  This version of the function (with
% "zeromu" and "f" in the name) assumes that the first Gaussian component is
% centered at zero intensity (i.e., it is for background-subtracteed
% data)and has the mean fraction labeled per site, f, as a variable parameter.
% In this version we allow the width of each peak to vary according to a
% a fixed (readout) plus variable (shot) noise model.
%
% Requires statistics toolbox
%
% y = nmer_gaussian_shot_sigma_zeromu_f_pdf(x, nmer, parms)
%
% y - probability densities
% x - input data
% nmer -- multimer size (i.e., nmer = 6 for a hexamer)
% parms - [xp0 k spacing f fixedsigma g] 
%   1) xp0 -- additional amplitude of zero peak: binomial amplitudes should be 
%       divided by (xp0 + 1)
%   2) k -- shot noise proportionality constant (see writeup)
%   3) spacing -- spacing of peaks; peak 1 thru nmer are at mu0 + nmer *
%       spacing
%   4) f -- labeling probability for a protomer
%   5) fixedsigma -- fixed component of noise (e.g., readout noise)
%   6) g -- offset to true zero of intensity (see writeup)
%
%% 
% Copyright 2019, 2020 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%
ns = 0:nmer;
parms = cell2mat(varargin);
k = parms(2);
spacing = parms(3);
f = parms(4);
fixedsigma = parms(5);
g = parms(6);

% peak centers
mus = ns .* spacing;

% peak widths (expressed as *variances*)
covar = ones(1, 1, nmer + 1);
covar(1, 1, :) = ns;
covar2(1, 1, :) = ...
    (fixedsigma + sqrt(k .* (g + spacing .* covar(1, 1, :)))) .^ 2;

% peak heights
% constrain sum of amplitudes to be 1:
p0 = parms(1);
ps = pdf('Binomial', ns, nmer, f);
ps(1) = ps(1) + p0;
ps = ps ./ sum(ps) ; % renormalize amplitudes

distn = gmdistribution(mus', covar2, ps');
y = pdf(distn,x);

global parm_names
parm_names= {'xp0'; 'k'; 'spacing'; 'label frac.'; 'fixedsigma'; 'offset'};
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
