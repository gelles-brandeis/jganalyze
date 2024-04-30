function y = two_seq_steps_pdf(x,varargin)
% pdf values for a two-sequential step irreversible mechanism
% 
% y = two_seq_steps_pdf(x,parms)
% y - probability densities
% x - input params
% parms - [k1 k2] the rate constants for the two steps.  k1 and k2 must not
% be equal.
%% 
% Copyright 2024 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%
parms=cell2mat(varargin);
k1 = parms(1);
k2 = parms(2);
y = k1 .* k2 ./ (k2 - k1) .* (exp(-k1 .* x) - exp(-k2 .* x));
global parm_names
parm_names= {'k1'; 'k2'};
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