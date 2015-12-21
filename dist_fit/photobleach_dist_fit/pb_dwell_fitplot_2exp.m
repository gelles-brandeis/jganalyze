% Script to calculate and plot dwell time distns/fits/bootstraps including
% photobleaching
%%
% Copyright 2014,2015 Jeff Gelles, Brandeis University.
% This is licensed software; see notice at end of file.
%%
% Global variables used:
%   dwellts - list of durations of dwells 
%   pwr = exsposure values (laser power or frac duration) for each dwell
%   inargzero - vector of parameter initial guesses 
%   tm - shortest dwell detectable 
%   tx - duration of experimental record
%   nboot - number of bootstrap samples
%   nbins - number of bins in pdf histograms
%% make experimental pdfs
pwrs = unique(pwr); % list of powers
npwr = length(pwrs);
dwell_pdf = zeros(npwr,nbins);
n = 1;
[bin_centers, dwell_pdf(n,:), bins] = binned_pdf...
            (dwellts(pwr == pwrs(n)), nbins);
for n = 2:npwr
    [~, dwell_pdf(n,:), bins] = binned_pdf...
            (dwellts(pwr == pwrs(n)), bins);
end
%% fit
[fitparm, ~, ~, fitoutput] = ...
    fminsearch('expfalltwo_pb_mxl',inargzero,[],dwellts,pwr,tm,tx)
fitparm_recip = 1 ./ fitparm
%% plot pdfs
% generate fit curves
delta_t = max(dwellts)/1000.;
t=0:delta_t:max(dwellts);
clear p;
for n = 1:npwr
    p(n,:) = expfalltwo_pb_pdf(fitparm, t, pwrs(n), tm, tx);
end
% plot
figure();
orient('landscape');
subplot(2,2,1);
plot(bin_centers, dwell_pdf, '.', t, p, '-');
leg = cell(2 * npwr, 1);
for n = 1:npwr
    leg{n} = ['data; power = ', num2str(pwrs(n))];
    leg{n+npwr} = ['fit; power = ', num2str(pwrs(n))];
end
legend (leg);
title ('PDFs of data and fit');
xlabel ('dwell time (s)');
ylabel ('pdf (s^{-1})'); 

%% bootstrap
boot_results = zeros(nboot, length(fitparm));
boot_dwells = zeros(length(dwellts),1);
for n = 1:nboot
% sample each power setting separately
    for i = 1:npwr
        locs = (pwr == pwrs(i));
        one_power = dwellts(locs);
        boot_dwells(locs) = one_power(randi(length(one_power), length(one_power), 1));
    end
    boot_results(n,:) = ... 
    fminsearch('expfalltwo_pb_mxl',fitparm,optimset('MaxFunEvals', 4000),boot_dwells,pwr,tm,tx);
end
% parameter statistics
boot_mean = mean(boot_results)
boot_std = std(boot_results)
boot_mean_recip = mean(1 ./ boot_results)
boot_std_recip = std(1 ./ boot_results)
% %% calculate c.i.s and plot fit bootstraps
% l_ci = prctile(boot_results, 2.5);
% u_ci = prctile(boot_results, 97.5);
% [yl, ~, ~] = flat_exp1_exptlpdf(t, l_ci, recl);
% [yu, ~, ~] = flat_exp1_exptlpdf(t, u_ci, recl);
% subplot(2, 2, 2);
% plot(bin_centers, all_pdf, '.', t, pa, '-',  t, yl, '-', t, yu, '-');
% orient('landscape');
% title ('PDFs of data and fit and bootstraps');
% xlabel ('lifetime (s)');
% ylabel ('experimental PDF (s^{-1})'); 
% legend ('data', ['fit; tau = ', num2str(tau), ' (s)'],...
%     ['lower 95% c.i. = ', num2str(l_ci), ' (s)'],...
%     ['upper 95% c.i. = ', num2str(u_ci), ' (s)']);
% 
% %% survival plots
% % numerically integrate the pdfs
% allts = sort(allts);
% n_allts = length(allts);
% f = n_allts:-1:0;
% f = f ./ n_allts;
% allts = [0; allts];
% ipa = 1-cumsum(pa) .* delta_t;
% iyl = 1-cumsum(yl) .* delta_t;
% iyu = 1-cumsum(yu) .* delta_t;
% 
% subplot(2,2,3);
% plot(allts, f, '.', t, ipa, '-', t, iyl , '-', t, iyu, '-' );
% orient('landscape');
% title ('Experimental survival fraction');
% xlabel ('lifetime (s)');
% ylabel ('fraction');
% legend ('data', ['fit; tau = ', num2str(tau), ' (s)'],...
%     ['lower 95% c.i. = ', num2str(l_ci), ' (s)'],...
%     ['upper 95% c.i. = ', num2str(u_ci), ' (s)']);
% 
% % remove negative/small values
% thr = .001;
% ipat = ipa(ipa>thr);
% ipatt = t(ipa>thr);
% iylt = iyl(iyl>thr);
% iyltt = t(iyl>thr);
% iyut = iyu(iyu>thr);
% iyutt = t(iyu>thr);
% subplot(2,2,4);
% semilogy(allts, f, '.', ipatt, ipat, '-', iyltt, iylt , '-',...
%     iyutt, iyut, '-' );
% orient('landscape');
% title ('Experimental survival fraction');
% xlabel ('lifetime (s)');
% ylabel ('fraction');
% legend ('data', ['fit; tau = ', num2str(tau), ' (s)'],...
%     ['lower 95% c.i. = ', num2str(l_ci), ' (s)'],...
%     ['upper 95% c.i. = ', num2str(u_ci), ' (s)']);
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