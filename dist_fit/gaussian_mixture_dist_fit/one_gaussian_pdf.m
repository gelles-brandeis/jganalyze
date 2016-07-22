function y = one_gaussian_pdf(x,varargin)
% Compute probability densities for a Gaussian 
% y = one_gaussian_pdf(x,parms)
% y - probability densities
% x - input params (can be a vector or a cell vector)
% parms - [mu sigma] 
%% 
% Copyright 2016 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%
parms=cell2mat(varargin);
y = pdf('Normal', x, parms(1), parms(2));
global parm_names
parm_names= {'mu'; 'sigma'};
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