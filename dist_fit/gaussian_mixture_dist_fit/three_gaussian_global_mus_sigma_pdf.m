function y = three_gaussian_global_mus_sigma_pdf(fit_category, fit_data, n_cdns, varargin)
% y = three_gaussian_global_mus_sigma_pdf(fit_category, fit_data, n_cdns, <parms>)
% pdf values for a three-component Gaussian mixture model with the same sigma
% for each component and global mus over several "conditions", e.g., 
% time slices of a kinetics experiment/mutants/concentrations
%
% Inputs:
%   fit_category - categories of each observation (a ROW vector)
%       (an integer from 1 to n where n is the total 
%       number of conditions)
%   fit_data - observation to be fit (a ROW vector)
%   n_cdns - number of conditions
%   parms - parameters:
%       p1.1, p1.2, ... p1.n_cdns, p2.1, p2.2, ... p2.n_cdns, mu1, mu2, mu3, sigma
%       where 0 < p1.i <1 is fractional amplitude of component 1 
%           under condition i; and 
%       where 0 < p2.i <1 is fractional amplitude of component 2 
%           under condition i; and 
%       p1.i + p2.i + p3.i = 1
% Output:
%   y - vector of probability densities for each of the elements in
%       fit_category/fit_data
%% 
% Copyright 2016, 2018 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%
if nargin ~= 3 + 2 * n_cdns + 4 % 3 (for fit_category, fit_data, n_cdns) plus 
                        % number of parameters
    error('Function called with %d parameters; expecting %d.'...
        , nargin, 3 + 2 * n_cdns + 4);
end
parms = cell2mat(varargin); 
global parm_names
parm_names = cell(1, 2 * n_cdns + 4);

parm_names{2 * n_cdns + 1} = 'mu1';
mu1 = parms(2 * n_cdns + 1);
parm_names{2 * n_cdns + 2} = 'mu2'; 
mu2 = parms(2 * n_cdns + 2);
parm_names{2 * n_cdns + 3} = 'mu3';
mu3 = parms(2 * n_cdns + 3);
parm_names{2 * n_cdns + 4} = 'sigma'; 
covar = parms(2 * n_cdns + 4)^2;

global condition_names

y = ones(length(fit_data), 1); % for data points not in any category, pdf = 1
for i = 1:n_cdns
    amps = [parms(i); parms(n_cdns + i); 1 - parms(i) - parms(n_cdns + i)];
    if sum((amps < 0) + (amps > 1)) > 0
        parms
        amps
        error('Gaussian mixture model amplitude parameter out of range [0,1].')
    end
    distn = gmdistribution([mu1; mu2; mu3], covar, amps);
    index = (fit_category == i);
    y(index) = pdf(distn, fit_data(index));
    parm_names{i} = ['p1_' condition_names{i}];
    parm_names{i + n_cdns} = ['p2_' condition_names{i}];
end
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
