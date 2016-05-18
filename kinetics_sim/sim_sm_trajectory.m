function traj = sim_sm_trajectory(model, max_length)
% sim_sm_trajectory: produces a single reaction trajectory by Gillespie
% simulation of a kinetic model.
% 
% Inputs:
%
%   model.states: column cell array with names of states
%   model.k: rate constant matrix; model.k(i,j) is the rate constant (in 
%       s-1 or min-1 for conversion of state i ==> state j.  All diagonal
%       elements should be zero for a Markov process.  If model.k(i,:) is
%       all zeros, that defines state i as a dead end meaning that entry
%       into state i temrinates the trajectory.
%   model.start_prob: column vector; model.start_prob(i) is the probability
%       that a trajectory will start in state i. Elements must be
%       non-negative and sum to 1.
%
%   max_length: terminate the trajectory after this number of steps, if it
%       doesn't stop sooner.
%
% Outputs:
%
%   traj.* are all column vectors of the same length describing the
%   trajectory
%       .no: state number
%       .name: state name
%       .duration: duration in the state
%       .time: cumulative time till the end of state.

%%
% Copyright 2016 Jeff Gelles, Brandeis University.
% This is licensed software; see notice at end of file. 

%% 
i = sum(cumsum(model.start_prob)<rand())+1;   % pick starting state
for n = 1:max_length
    traj.no(n) = i;
    traj.name(n) = model.states(i);
    sum_k = sum(model.k(i,:));
    if sum_k > 0 
        traj.duration(n) = random('exp', 1 ./ sum_k); % duration in this state
        i = sum(cumsum(model.k(i,:) ./ sum_k)<rand())+1; % next state
    else
    % end trajectory if in a dead-end state
        traj.duration(n) = 0; % by definition
        break
    end
end
traj.time = cumsum(traj.duration);
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