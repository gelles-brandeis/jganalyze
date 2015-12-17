% expfalltwo_pb_sim_test: Script to test expfalltwo_pb_sim
%% parameters
n = 5000;
nbins = 20;
ap = 0.3;
tau1 = 1; 
tau2 = 10;
pwrs = [.5, 1, 1.5, 2]; % laser power or exposure 
pb_tau = 5; % photobleaching lifetime at power = 1
%% parameters not used in this sim but needed for pb_dwell_fitplot_2exp
inarg0 = 
%%
pb_taus = pb_tau./pwrs;
lbls = cell(length(pb_taus),1);
dwellts = [];
pwr = [];
for i = 1:length(pb_taus)
    ts=expfalltwo_pb_sim(ap, tau1, tau2, pb_taus(i), n);
    if i == 1 
        [bin_centers, y, bins] = binned_pdf(ts, nbins);
    else
        [bin_centers, y, bins] = binned_pdf(ts, bins);
    end
    plot(bin_centers, y, '.-');
    hold on
    lbls{i} = strcat('Power = ',num2str(pwrs(i)));
    dwellts = [dwellts, ts];
    pwr = [pwr, pwrs(i) * ones(length(ts))];
end
xlabel('Time (s)')
ylabel('Probability density (s^-^1)')
legend(lbls);
hold off
%% versions
% ver 2: make output suitable for pb_dwell_fitplot_2exp