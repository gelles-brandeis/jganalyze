function y = four_gamma_mix_pdf(x,varargin)
% pdf values for a four-component gamma mixture model
%
% y = four_gamma_mix_pdf(x,parms)
% y - probability densities
% x - input data
% parms - [mu w p2 p3 p4] 
% where 0 < p <1 are the fractional amplitude of the components with 
%   p1 = 1 - p2 - p3 - p4, 
% means of each component are mu, 2 mu, 3 mu, 4 mu
% width parameter w controls the width of each component 
%   smaller w <=> wider peaks; w = 1 corresponds to a Poisson mixture model
%% 
% Copyright 2022 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%
comp = 4; % number of components
parms=cell2mat(varargin);
ps = [1 - abs(parms(3) + parms(4) + parms(5)); parms(3); parms(4); parms(5)];
mus = 1:comp;
mus = mus .* parms(1);
w = parms(2);
distn = cell(comp, 1);
component_pdfs = zeros(comp, length(x));
for i = 1:comp
    distn{i} = makedist('Gamma','a', mus(i) .* w, "b", 1 / w);
    component_pdfs(i, :) = pdf(distn{i}, x);
end
y = sum(ps .* component_pdfs);
global parm_names
parm_names = {'mu'; 'w'; 'p2'; 'p3'; 'p4'};
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
