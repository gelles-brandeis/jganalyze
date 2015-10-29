function [pa, pn, pt] = flat_exp1_exptlpdf(t, tau, recl)
% PDF: single exponential, finite-length record, flat start dist
%%
% Copyright 2014 Jeff Gelles, Brandeis University.
% This is licensed software; see notice at end of file. 
%%
pn = (recl - t) ./ tau ./ recl .* exp(-t ./ tau);
pt = exp(-t ./ tau)./ recl;
pa = pn + pt;
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