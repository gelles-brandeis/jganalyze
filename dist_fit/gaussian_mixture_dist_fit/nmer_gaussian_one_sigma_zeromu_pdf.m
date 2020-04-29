function y = nmer_gaussian_one_sigma_zeromu_pdf(x, nmer, f, varargin)
% pdf values for a (nmer+1)-component Gaussian mixture model for fitting
% intensity distributions from SMF data on a randomly labeled homomultimer
% with one or zero dyes per protomer.  This version of the function (with
% "zeromu" in the name) assumes that the first Gaussian component is
% centered at zero intensity (i.e., it is for background-subtracteed data).
%
% See nmer_gaussian_zeromu_example.mlx for usage
%
% Requires statistics toolbox
%
% y = y = nmer_gaussian_one_sigma_zeromu_pdf(x, varargin)
%
% y - probability densities
% x - input data
% nmer -- multimer size (i.e., nmer = 6 for a hexamer)
% f -- labeling probability for a protomer
% parms - [xp0 sigma spacing] 
%   xp0 -- additional amplitude of zero peak: binomial amplitudes should be 
%       divided by (xp0 + 1)
%   sigma -- width of all peaks
%   spacing -- spacing of peaks; peak 1 thru nmer are at mu0 + nmer *
%       spacing
%
%% 
% Copyright 2019, 2020 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%
parms=cell2mat(varargin);
covar=parms(2)^2;
% constrain sum of amplitudes to be < 1:
p0 = parms(1);
ns = 0:nmer;
ps = pdf('Binomial', ns, nmer, f);
ps(1) = ps(1) + p0;
ps = ps ./ sum(ps) ; % normalize amplitudes
mus = ns .* parms(3);
distn=gmdistribution(mus', covar, ps');
y = pdf(distn,x);
global parm_names
parm_names= {'xp0'; 'sigma'; 'spacing'};
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
