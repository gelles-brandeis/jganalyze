function pc=flat_exp1_mxlall2(inarg,dwellts,obsts,tm,recl)
% Liklihood: single exponential, finite-length record, flat start dist
%
% inarg - lifetime parameter
% dwellts - lengths of non-trucated dissociation events 
% obsts - lengths of events truncated by end of observation
% tm = minimum interval length that can be resolved in the experiment
%       (not currently used)
% recl = length of recording
% pc = negative log likelihood given the inarg and the observations
%
% Example:
%   fminsearch('exp1_mxlall2',inargzero,[],dwellts,obsts,tm);
%
%%
% Copyright 2014 Jeff Gelles, Brandeis University.
% This is licensed software; see notice at end of file. 
%%
tau=abs(inarg);
probvector = (recl - dwellts) ./ recl ./tau .* exp(-dwellts/tau); 
probstable= 1 ./ recl .* exp(-obsts/tau);
pc= -sum(log(probvector)) - sum(log(probstable));                   
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