function [n_start, n_end, dwells] = discrim_model_2parm(t_start, t_end, fb, fe)
% discrim_model_2parm simulates a hysteretic dwell discrimination algorithm
% Dwells start at times t_start and end at times t_end.
% The script assumes a model of the dwell begin/end detection algorithm that
% is defined by the parameters fb and fe as defined in dwell_time_disc_sim.mlx
% Discrimination is non-hysteretic when fb = 1 - fe
%
% From https://github.com/gelles-brandeis/jganalyze.git
%% 
% Copyright 2016 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%
n_mid = floor(t_end) - ceil(t_start);
n_start = (ceil(t_start) - t_start) > fb;
n_end = t_start & ((t_end - floor(t_end)) > fe);
dwells = n_start + n_mid + n_end;
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

