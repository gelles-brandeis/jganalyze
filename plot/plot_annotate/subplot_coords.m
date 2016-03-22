function [x1, y1, x2, y2] = subplot_coords(subplot_params)
% Calculates the fractional coordinates of a subplot bounding box
%
% Input:
% subplot_params: a three-element vector having the same elements as the
% arguments of subplot().  Example: the same are of the figure that is
% referenced by
%       subplot (2,2,3) and subplot_coords ([2 2 3])
% 
% Output:
% Fractional coordinates of the lower left (x1,y1) and upper right (x2,y2)
% of the subplot area given that (0,0) is the lower left and (1,1) the
% upper right of the figure.
%%
% Copyright 2014,2015 Jeff Gelles, Brandeis University.
% This is licensed software; see notice at end of file.
%%
x = subplot_params(1);
y = subplot_params(2);
n = subplot_params(3);
ny = ceil(n ./ x); % ordinal plot number from top
nx = n - (ny-1)*y; % ordinal plot number from left
x1 = (nx - 1) ./ x;
x2 = (nx) ./ x;
y1 = (y - ny) ./ y;
y2 = (y - ny + 1) ./ y;
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