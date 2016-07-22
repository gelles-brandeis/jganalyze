function y = two_gaussian_one_sigma_pdf(x,varargin)
% pdf values for a two-component Gaussian mixture model with the same sigma
% for each
%
% y = two_gaussian_one_sigma_pdf(x,parms)
% y - probability densities
% x - input params
% parms - [p1 mu1 sigma mu2] where 0 < p <1 is fractional amplitude; p1 +
%   p2 = 1
%% 
% Copyright 2016 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%
parms=cell2mat(varargin);
a=parms(1);
covar=parms(3)^2;
distn=gmdistribution([parms(2);parms(4)],covar,[a;1-a]);
y = pdf(distn,x);
global parm_names
parm_names= {'p1'; 'mu1'; 'sigma'; 'mu2'};
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
