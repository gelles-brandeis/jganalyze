% expfalltwo_pb_sim_test: Script to test expfalltwo_pb_sim
n = 5000;
nbins = 20;
ap = 0.2;
tau1 = 2; 
tau2 = 20;
pb_tau = 100;
dwellts=expfalltwo_pb_sim(ap, tau1, tau2, pb_tau, n);
[bin_centers, y, bins] = binned_pdf(dwellts, nbins);
plot(bin_centers, y, '.-');
xlabel('Time (s)')
ylabel('Probability density (s^-^1)')
hold on
pb_taus = [50, 25, 10, 5, 2, 1];
for i = 1:length(pb_taus)
    dwellts=expfalltwo_pb_sim(ap, tau1, tau2, pb_taus(i), n);
    [bin_centers, y, bins] = binned_pdf(dwellts, bins);
    plot(bin_centers, y, '.-');
end
legend('100','50', '25', '10', '5', '2', '1')
hold off