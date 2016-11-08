function p = trunctriangle_pdf(args, x)
%trunctriangle_pdf Evaluate pdf of a truncated triangle probability
% distribution
%% 
% Copyright 2016 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%
%   args(1:4) = a, b, c, d
% <<trunctriangle.PNG>>
%   x = input values
%   p = output probability density at x
%%
if size(args) < 4
    error('trunctriangle_pdf: less than 4 arguments');
    return
end
a = args(1);
b = args(2);
c = args(3);
d = args(4);
p = x .* 0;
i = x > a & x <= b;
p(i) = (x(i) - a) ./ (b - a);
i = x > b & x < c;
p(i) = 1 - ((x(i) - b) ./ (d - b));
% normalization
n = 0.5 .* ((b - a) + (c - b) .* (2 - ((c-b)./(d-b))));
p = p ./ n;
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

