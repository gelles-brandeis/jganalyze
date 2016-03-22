function [strings] = show_vars(vlist, loc)
%SHOW_VARS Places a text box in the current figure that displays variable
%values
%
%Example:
%  show_vars({'tx'; 'tm'}) would produce a box with the text
%
%      tx = 200.0000
%      tm = 0.1000
%
%  if the variables exist in the caller's worspace with those values
%
%  use of evalin in this context suggested by
%  http://www.mathworks.com/matlabcentral/newsreader/view_thread/166740
%
%  loc is an optional 3-element vctor having the same elements as the
%  arguments of subplot().  For example,
%
%       show_vars({'tx'; 'tm'}, [2, 2, 4])
%
% produces output in the lower left quarter of the figure.
%
%%
% Copyright 2014,2015 Jeff Gelles, Brandeis University.
% This is licensed software; see notice at end of file.
%%
if nargin == 1
    % loc not specified; use full plot
    loc = [1 1 1];
end
[x1, y1, x2, y2]=subplot_coords(loc);
% explanation of dim:  [x y w h]; when fitboxtotext is on, upper left corner
% of the text box will be at (x, y+h) where (0,0) is the lower left of the figure
dim = [x1, y1, x2 - x1, y2 - y1];
%%
s = length(vlist);
strings = cell(s, 1);
for n = 1:s
    if vlist{n}(1) == '%';
        strings{n} = vlist{n}(2:end);
    else
%       strings{n} = sprintf('%s = %4.4f',vlist{n},evalin('caller',char(vlist{n})));
        strings{n} = [vlist{n}, ' =  ', num2str(evalin('caller',char(vlist{n})))];
    end
end
%
annotation('textbox', dim, 'String', strings, 'FitBoxToText', 'on', ...
    'Interpreter', 'none');
end
%% versions
% ver 2 3/20/16
%     Added optional loc parameter to specify location of textbox in fig
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
