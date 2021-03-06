function param=gamma_fit(dwells)
% gamma distribution pdf fitter for bootci
%%
% Copyright 2016 Jeff Gelles, Brandeis University.
% This is licensed software; see notice at end of file. 
%%
param = zeros(1,2);
pd = fitdist(dwells, 'Gamma');
param(1) = pd.a;
param(2) = pd.b;
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