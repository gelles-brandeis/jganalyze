function y = three_gaussian_one_sigma_pdf(x,varargin)
% pdf values for a three-component Gaussian mixture model with the same sigma
% for each component
%DEFUNCT use three_gaussian_one_sigma_pdf_2
%
% y - probability densities
% x - input params
% parms - [p1 mu1 sigma p2 mu2 mu3] where 0 < p1, p2 <1 are the fractional 
% amplitudes; p1 + p2 + p3 = 1
%% 
% Copyright 2016 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%
parms=cell2mat(varargin);
covar=parms(3)^2;
distn=gmdistribution([parms(2);parms(5);parms(6)],covar,...
    [parms(1);parms(4);abs(1-parms(1)-parms(4))]);
y = pdf(distn,x);
global parm_names
parm_names= {'p1'; 'mu1'; 'sigma'; 'p2'; 'mu2'; 'mu3'; };
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

