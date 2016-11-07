function fitargs = trunctriangle_chisq_fit(frameint, x, y)
% trunctriangle_chisq_fit: non-linear least-squares fit to trunctriangle
% pdf
%% 
% Copyright 2016 Jeff Gelles, Brandeis University 
% Modified from expfalltwo_mxl Copyright 2014 Larry Friedman, Brandeis
% University
% This is licensed software; see notice at end of file. 
%%
%   (x, y): data;
%   frameint: time interval between frames (for intiatial parameter guess)
%   fitargs: argument fit values
%%
chisqval = @(args, x, y) sum((y - trunctriangle_pdf(args, x)) .^ 2);

% initial parameter guesses
[~, b] = max(y);
b = x(b);
a = b - frameint;
c = b + frameint; 
d = c + frameint;
args0 = [a b c d];
fitargs = fminsearch(chisqval, args0, [], x, y);
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

