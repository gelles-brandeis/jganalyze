function h = fret_hist_2d(gridx1,gridx2,f)
% fret_hist_2d: Plot an Efret vs. time 2-d histogram
% all agruments are 2-d matices
% gridx1 - matrix of x (time) values
% gridx2 - matrix of y (Efret) values
% f - matrix of z (probability density) values
% h - handle of resultant figure
%%
% Copyright 2016 Jeff Gelles, Brandeis University.
% This is licensed software; see notice at end of file. 
%%
h=figure();
pcolor(gridx1,gridx2,f);
shading flat
xlabel ('Time (s)')
ylabel ('\itE\rm_{FRET}')
c=colorbar;
c.Label.String='Probability density (s^{-1})';
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