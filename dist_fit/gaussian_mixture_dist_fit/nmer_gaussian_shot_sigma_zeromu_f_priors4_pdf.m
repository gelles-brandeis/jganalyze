function y = nmer_gaussian_shot_sigma_zeromu_f_priors3_pdf(x, nmer, g, k, varargin)
% pdf values for a (nmer+1)-component Gaussian mixture model for fitting
% intensity distributions from SMF data on a randomly labeled homomultimer
% with one or zero dyes per protomer.  This version of the function (with
% "zeromu" and "f" in the name) assumes that the first Gaussian component is
% centered at zero intensity (i.e., it is for background-subtracteed
% data)and has the mean fraction labeled per site, f, as a variable parameter.
% In this version we allow the width of each peak to vary according to a
% a fixed (readout) plus variable (shot) noise model, with the parameters for 
% model determined by prior knowledge from analyzing the camera properties,
% except there is an additional additive 
% fudge factor increasing the width of the
% peaks to compensate for population heterogeneity due to uneven
% illumination.
%
% Requires statistics toolbox
%
% y = nmer_gaussian_shot_sigma_zeromu_f_priors3_pdf(x, nmer, g, k,  parms)
%
% y - probability densities
% x - input data
%
% Fixed parameters:
% nmer - multimer size (i.e., nmer = 6 for a hexamer)
% g - offset to true zero of intensity (in photons)
% k - calibration factor (photons / adu)
%
% parms - [xp0 spacing f xw] 
%   1) xp0 -- additional amplitude of zero peak: binomial amplitudes should be 
%       divided by (xp0 + 1)
%   2) spacing -- spacing of peaks; peak 1 thru nmer are at mu0 + i *
%       spacing (i <= nmer) (adu)
%   3) f -- labeling probability for a protomer
%   4) xw -- additional width factor for peaks 1 to nmer
%   
%% 
% Copyright 2019, 2020 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%
ns = 0:nmer;
parms = cell2mat(varargin);
spacing = parms(2);
f = parms(3);
xw = parms(4);

% peak centers
mus = ns .* spacing;

% peak widths (expressed as *variances*)
covar = ones(1, 1, nmer + 1);
covar(1, 1, :) = ns;
covar2(1, 1, :) = ...
((sqrt(g + k .* spacing .* covar(1, 1, :)) ./ k) + xw .* sign(covar(1, 1, :))) .^ 2;

% peak heights
% constrain sum of amplitudes to be 1:
p0 = parms(1);
ps = pdf('Binomial', ns, nmer, f);
ps(1) = ps(1) + p0;
ps = ps ./ sum(ps) ; % renormalize amplitudes

distn = gmdistribution(mus', covar2, ps');
y = pdf(distn,x);

global parm_names
parm_names= {'xp0'; 'spacing'; 'label frac.'; 'addl. width'};
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
