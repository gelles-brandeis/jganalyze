function pc=expfalltwo_pb_mxl(inarg,dwellts,pwr,tm,tx)
% -log liklihood of a biexponential pdf with photobleaching
%% 
% Copyright 2015 Jeff Gelles, Brandeis University 
% Modified from expfalltwo_mxl Copyright 2014 Larry Friedman, Brandeis
% University
% This is licensed software; see notice at end of file. 
%%
% Parameters:
%   inarg (vector) - fitting parameters vector:
%      [ap      note that the fractional amplitude of the first component is
%               a = 1/(1+ap^2)
%       tau1    ACTUAL taus that do not include photobleaching
%       tau2 
%       c]      proportionality constant that relates power to photobleaching
%               lifetime (c * power = 1 / pb lifetime)
%   dwellts (vector) - list of durations of dwells 
%   pwr (vector) = exsposure values (laser power or frac duration) for each dwell
%   tm - shortest dwell detectable 
%   tx - duration of experimental record
% 
% % Usage:
%   fminsearch('expfalltwo_pb_mxl',inargzero,[],dwellts,pwr,tm,tx)
%%
a=1/(1+inarg(1)^2);
% taus below are the APPARENT taus that include the effect of
% photobleaching
c=inarg(4);
tau1 = 1 ./ (1 ./ abs(inarg(2)) + abs(c .* pwr));
tau2 = 1 ./ (1 ./ abs(inarg(3)) + abs(c .* pwr));
% tau1 = 1 ./ (1 ./ inarg(2) + (c .* pwr));
% tau2 = 1 ./ (1 ./ inarg(3) + (c .* pwr));
probability_vector = ...
    (  1./( a.*(exp(-tm./tau1)-exp(-tx./tau1)) + (1-a).*(exp(-tm./tau2)-exp(-tx./tau2)) )  ).*...
                                 ( a./tau1.*exp(-dwellts./tau1)+(1-a)./tau2.*exp(-dwellts./tau2) );
prodprob=sum(log(probability_vector));% Take product of all probabilities;
pc=-prodprob;    
%% Notice
% This is free software: you can redistribute it and/or modify it under the
% terms of the GNU General Public License as published by the Free Software
% Foundation, either version 3 of the License, or (at your option) any later
% version.
%
% This software is distributed in the hope that it will be useful, but WITHOUT ANY
% WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
% A PARTICULAR PURPOSE. See the GNU General Public License for more details.
% You should have received a copy of the GNU General Public License
% along with this software. If not, see <http://www.gnu.org/licenses/>.