function dwellts=expfalltwo_pb_sim(a, tau1, tau2, pb_tau, n)
% Generates dwell times drawn from a biexponential pdf with exponential
% photobleaching
%% 
% Copyright 2015 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%
% Parameters:
%  a      amplitude fraction
%  tau1    time constants
%  tau2 
%  pb_tau  photobleaching time constant
%  n       number of dwells to generate
%%
rawdwellts=expfalltwo_sim(a, tau1, tau2, n);
pbts = random('exp',pb_tau,[n, 1]);
dwellts=min(rawdwellts,pbts);
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