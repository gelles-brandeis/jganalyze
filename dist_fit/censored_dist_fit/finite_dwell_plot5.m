% Script to calculate and plot finite-record dwells, fits, and bootstraps
%
% Global variables used:
%   dwellts - list of durations of dwells observed to their end
%   dwell_rec - time from start of each of the above dwells to the end of
%   the recording
%   obsts - list of durations of dwells terminated by end of record
%   inargzero - vector of parameter initial guesses 
%   tm - shortest dwell detectable (not used)
%   recl - duration of experimental record
%   nboot - number of bootstrap samples
%   nbins - number of bins in pdf histograms
%%
% Copyright 2014 Jeff Gelles, Brandeis University.

% This is free software: you can redistribute it and/or modify it under the
% terms of the GNU General Public License as published by the Free Software
% Foundation, either version 3 of the License, or (at your option) any later
% version.

% This software is distributed in the hope that it will be useful, but WITHOUT ANY
% WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
% A PARTICULAR PURPOSE. See the GNU General Public License for more details.
% You should have received a copy of the GNU General Public License
% along with this software. If not, see <http://www.gnu.org/licenses/>.

%% make experimental pdfs for non-trunc, trunc, and sum
allts = [dwellts; obsts];
[~, all_pdf, bins, ses] = binned_pdf(allts, nbins);
[~, dwell_pdf, bins] = binned_pdf(dwellts, bins);
dwell_pdf = dwell_pdf .* length(dwellts) ./ length(allts);
[bin_centers, obs_pdf, bins] = binned_pdf(obsts, bins);
obs_pdf = obs_pdf .* length(obsts) ./ length(allts);

%% fit
tau =fminsearch('flat_exp1_mxlall2', inargzero, [], dwellts,obsts,tm,recl)

%% plot pdfs
delta_t = max(allts)/1000.;
t=0:delta_t:max(allts);
[pa, pn, pt] = flat_exp1_exptlpdf(t, tau, recl);
orient('landscape');
subplot(2,2,1);
plot(bin_centers, all_pdf, '.k',...
    bin_centers, dwell_pdf, '.r', ...
    bin_centers, obs_pdf, '.b',...
    t, pa, '-k',...
    t, pn, '-r',...
    t, pt, '-b');
legend ('all', 'complete', 'truncated',...
    ['fit; tau = ', num2str(tau), ' (s)']);
title ('PDFs of data and fit');
xlabel ('lifetime (s)');
ylabel ('experimental PDF (s^{-1})'); 

%% bootstrap
boot_results = zeros(nboot, 1);
nontrunc = logical([ones(length(dwellts), 1); zeros(length(obsts), 1)]);
for n = 1:nboot
%     % fixed numbers of truncated/non-trucated
%     boot_dwells = dwellts(randi(length(dwellts), length(dwellts), 1));
%     boot_obsts = obsts(randi(length(obsts), length(obsts), 1));
%     boot_results(n) = ...
%         fit_finite_dwells(boot_dwells,boot_obsts, tau, tm, recl);

% random umbers of truncated/non-truc
indices = randi(length(allts), length(allts), 1);
sel = allts(indices);
clear boot_dwells 
clear boot_obs
boot_dwells = sel(nontrunc(indices));
boot_obsts = sel(~nontrunc(indices));
boot_results(n) = ... 
    fminsearch('flat_exp1_mxlall2', tau, [], ...
    boot_dwells,boot_obsts,tm, recl);
end

%% calculate c.i.s and plot fit bootstraps
l_ci = prctile(boot_results, 2.5);
u_ci = prctile(boot_results, 97.5);
[yl, ~, ~] = flat_exp1_exptlpdf(t, l_ci, recl);
[yu, ~, ~] = flat_exp1_exptlpdf(t, u_ci, recl);
subplot(2, 2, 2);
plot(bin_centers, all_pdf, '.', t, pa, '-',  t, yl, '-', t, yu, '-');
hold on
errorbar(bin_centers, all_pdf, ses, 'o');
orient('landscape');
title ('PDFs of data and fit and bootstraps');
xlabel ('lifetime (s)');
ylabel ('experimental PDF (s^{-1})'); 
legend ('data', ['fit; tau = ', num2str(tau), ' (s)'],...
    ['lower 95% c.i. = ', num2str(l_ci), ' (s)'],...
    ['upper 95% c.i. = ', num2str(u_ci), ' (s)']);

%% survival plots
% numerically integrate the pdfs
allts = sort(allts);
n_allts = length(allts);
f = n_allts:-1:0;
f = f ./ n_allts;
allts = [0; allts];
ipa = 1-cumsum(pa) .* delta_t;
iyl = 1-cumsum(yl) .* delta_t;
iyu = 1-cumsum(yu) .* delta_t;
frac_censored = n_censored ./ (n_censored + n_allts);
ipa = ipa .* (1 - frac_censored) + frac_censored;
iyl = iyl .* (1 - frac_censored) + frac_censored;
iyu = iyu .* (1 - frac_censored) + frac_censored;
subplot(2,2,3);
plot(allts, f, '.', t, ipa, '-', t, iyl , '-', t, iyu, '-' );
orient('landscape');
title ('Experimental survival fraction');
xlabel ('lifetime (s)');
ylabel ('fraction');
legend ('data', ['fit; tau = ', num2str(tau), ' (s)'],...
    ['lower 95% c.i. = ', num2str(l_ci), ' (s)'],...
    ['upper 95% c.i. = ', num2str(u_ci), ' (s)']);

% remove negative/small values
thr = .001;
ipat = ipa(ipa>thr);
ipatt = t(ipa>thr);
iylt = iyl(iyl>thr);
iyltt = t(iyl>thr);
iyut = iyu(iyu>thr);
iyutt = t(iyu>thr);
subplot(2,2,4);
semilogy(allts, f, '.', ipatt, ipat, '-', iyltt, iylt , '-',...
    iyutt, iyut, '-' );
orient('landscape');
title ('Experimental survival fraction');
xlabel ('lifetime (s)');
ylabel ('fraction');
legend ('data', ['fit; tau = ', num2str(tau), ' (s)'],...
    ['lower 95% c.i. = ', num2str(l_ci), ' (s)'],...
    ['upper 95% c.i. = ', num2str(u_ci), ' (s)']);
