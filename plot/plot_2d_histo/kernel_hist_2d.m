function [f, intgl, x1s, x2s] = kernel_hist_2d(x,gridx1,gridx2,bw, cellarea)
% KSDENSITY2D Compute kernel density estimate in 2D.
% F = KSDENSITY2D(X,GRIDX,GRIDX2,BW) computes a nonparametric estimate of
% the probability density function of the sample in the N-by-2 matrix X.
% f is the vector of density values evaluated at the points in the grid
% defined by the vectors GRIDX1 and GRIDX2. The estimate is based on a
% normal kernel function, using a window parameter (bw) that is
% specified for both the x1 and x2 directions. intgl is the integral of f.
% cellarea is the area of one cell in the grid (used to normalize)
%%
% Modified from http://www.mathworks.com/matlabcentral/newsreader/view_thread/37873
% Portions copyright 2016 Jeff Gelles, Brandeis University.
% This is licensed software; see notice at end of file. 
%%
[n,~] = size(x);
m1 = length(gridx1);
m2 = length(gridx2);
% Compute the kernel density estimate
[gridx2,gridx1] = meshgrid(gridx2,gridx1);
x1s = gridx1;
x2s = gridx2;
x1 = repmat(gridx1, [1,1,n]);
x2 = repmat(gridx2, [1,1,n]);
mu1(1,1,:) = x(:,1); mu1 = repmat(mu1,[m1,m2,1]);
mu2(1,1,:) = x(:,2); mu2 = repmat(mu2,[m1,m2,1]);
f = sum((normpdf(x1,mu1,bw(1)) .* normpdf(x2,mu2,bw(2))), 3) ./ n .* cellarea;
intgl = sum(sum(f));
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
end
