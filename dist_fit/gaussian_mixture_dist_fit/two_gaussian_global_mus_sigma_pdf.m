function y = two_gaussian_global_mus_sigma_pdf(fit_category, fit_data, n_cdns, varargin)
% y = two_gaussian_global_mus_sigma_pdf(fit_category, fit_data, <parms>)
% pdf values for a two-component Gaussian mixture model with the same sigma
% for each component and global mus over several "conditions", e.g., 
% time slices of a kinetics experiment/mutants/concentrations
%
% Inputs:
%   fit_category - categories of each observation (a ROW vector)
%       (an integer from 1 to n where n is the total 
%       number of conditions)
%   fit_data - observation to be fit (a ROW vector)
%   n_cdns - number of conditions
%   parms - parameters[p1.1 p1.2 ... p1.n_cdns mu1 sigma mu2] where 0 < p1.i <1 
%       is fractional amplitude of component 1 under condition i; p1.i +
%       p2.i = 1
% Output:
%   y - vector of probability densities for each of the elements in
%       fit_category/fit_data
%% 
% Copyright 2016, 2018 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%
% n_cdns = max(fit_category); % number of conditions now passed as
% parameter
if nargin ~= n_cdns + 6
    error('Function called with %d parameters; expecting %d'...
        , nargin, n_cdns + 6);
end
parms = cell2mat(varargin); 
global parm_names
parm_names = cell(1, n_cdns + 3);
parm_names{n_cdns + 1} = 'mu1';
mu1 = parms(n_cdns + 1);
parm_names{n_cdns + 2} = 'sigma'; 
covar = parms(n_cdns + 2)^2;
parm_names{n_cdns + 3} = 'mu2';
mu2 = parms(n_cdns + 3);
global condition_names

y = ones(length(fit_data), 1); %for data points not in any category, pdf = 1
for i = 1:n_cdns
    distn=gmdistribution([mu1; mu2],covar,[parms(i); 1-parms(i)]);
    index = (fit_category == i);
    y(index) = pdf(distn, fit_data(index));
    parm_names{i} = ['p1_' condition_names{i}];
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
