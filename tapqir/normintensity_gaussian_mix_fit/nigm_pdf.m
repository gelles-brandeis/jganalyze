function y = nigm_pdf(x,varargin)
% pdf values for a n-component Gaussian mixture model based on up to n dyes
% per spot with Poisson noise.  Component amplitudes are free to vary
% independently.
%
% y = nigm_pdf(x, parms)
% y - probability densities
% x - input params (from tapqir cosmos model):
%       : background
% global inputs: 
%       gain -- adu per photon (from tapqir)
%       n_components -- number of gaussian components
% parms - [mu p1 p2... p(n-1)] where
%       0 < p1, p2... <1 are the fractional amplitudes; 1 - p1 - ...- p(n-1) = p(n)
%       mu is the normalized intensity of component 1
%% 
% Copyright 2022 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%
global gain_in
global n_components

% h = x(:, 1); % height
% b = x(:, 2); % background
% ni = h ./ b; % nomalized intensity

parms=cell2mat(varargin);
mu = parms(1);
mus = 1:(n_components) .* mu
covar = zeros(1, 1, n_components);
covar(1, 1, 1) = parms(3)^2;
covar(1, 1, 2) = parms(3)^2;
covar(1, 1, 3) = parms(7)^2;
distn=gmdistribution([parms(2);parms(5);parms(6)],covar,...
    [parms(1);parms(4);abs(1-parms(1)-parms(4))]);
y = pdf(distn,x);
global parm_names
parm_names{1} = {'mu'};
for i = 2:n_components
    parm_names{i} = ['p' int2str(i - 1)];
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
