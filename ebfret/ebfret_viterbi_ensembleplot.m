function ebfret_viterbi_ensembleplot(analysis, nstates)
% ebfret_viterbi_ensembleplot.m Makes Viterbi ensemble timecourse plot
% from a ebfret analysis
%% 
% Copyright 2018 Jeff Gelles, Brandeis University 
% This is licensed software; see notice at end of file. 
%%
% Parameters:
%
% analysis -- analysis structure from ebfret
% nstates -- number of states in analysis being plotted
%
% Usage:
%
% if ebfret is running:
%   ebfret_viterbi_ensembleplot(out.analysis,2)
% if results are loaded from a saved ebfret mat file:
%   ebfret_viterbi_ensembleplot(analysis,2)
% From https://github.com/gelles-brandeis/jganalyze.git
%%
out.analysis = analysis;
for j = 1:nstates
       leg{j} = ['State ', num2str(j)];
end
n=length(out.analysis(nstates).viterbi); % number of trajectories
for i = 1:n
   times(i) = length(out.analysis(nstates).viterbi(i).state);
end  
maxt = max(times);
sumviterbi = zeros(maxt, nstates);
for i = 1:n % loop over trajectories
    clear vit
    vit = zeros(maxt,1);
    vit(1:times(i),1) = out.analysis(nstates).viterbi(i).state; % vit is the state list for a single trajectory, 
    %                                                       padded with zeros at bottom
    for j = 1:nstates % loop over states
        sumviterbi(:, j) = sumviterbi(:, j) + (vit == j);
    end
end 
N = sum(sumviterbi,2);
figure();
subplot(2,1,2);
plot(N);
xlabel('Time (frames)');
ylabel('Number of molecules in dataset');
subplot(2,1,1);
p = sumviterbi ./ N;
plot(p, '.')
legend (leg)
xlabel('Time (frames)');
ylabel('Fraction of molecules in state');
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

