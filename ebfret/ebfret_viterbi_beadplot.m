function ebfret_viterbi_beadplot(analysis, nstates, sec_per_frame)
% ebfret_viterbi_beadplot.m Makes "beadplot" ratergram of Viterbi output
% from a ebfret analysis
%% 
% Copyright 2018 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%
% Parameters:
%
% analysis -- analysis structure from ebfret
% nstates -- number of states in analysis being plotted
% sec_per_frame -- time interval between frames (if specified, horiz. axis
%       of plot is time, if not specified it is frames
%
% Usage:
%
% if ebfret is running:
%   ebfret_viterbi_beadplot(out.analysis,2)
% if results are loaded from a saved ebfret mat file:
%   ebfret_viterbi_beadplot(analysis,2)
% From https://github.com/gelles-brandeis/jganalyze.git
%%
switch nargin
    case 2
        sec_per_frame = 1;
    case 3
    otherwise
        error('Wrong number of arguments in ebfret_viterbi_beadplot')
end
out.analysis = analysis;
figure()
hold on
trajectories=length(out.analysis(nstates).viterbi);
for ist = 1:nstates
    x = [];
    y = [];
    for itraj = 1:trajectories
      s=out.analysis(nstates).viterbi(itraj).state;
      t = (1:length(s))' .* sec_per_frame;
      idx = (s == ist);
      x = [x; t(idx)];
      y = [y; ones(sum(idx),1)*itraj];
    end
    plot(x, y, '.')
    leg{ist}=['State ', num2str(ist)];
end
legend(leg);
switch nargin
    case 2
        xlabel('frame number');
    otherwise
        xlabel('time (s)')
end
ylabel('trajectory number');
hold off   
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

