% four_gamma_mix_compplot.m script to make a plot,
% mixture  model, and individual components from variables stored by
% fitscript2 for the four_gamma_mix_pdf model

fig = figure();
orient('portrait');

% data histogram bargraph
%histogram('BinEdges',bins, 'BinCounts',y(:,1))
hold on

% data histogram points and error bars
errorbar(bin_centers, y(:,1), se(:,1),'ob');
hold on;

% fit plot
intensity = 0:0.1:maxintensity;
y2  = func(intensity',phat);
hold on
plot(intensity,y2,'-r');

% component plots
comp = 4; % number of components
ps = [1 - abs(phat(3) + phat(4) + phat(5)); phat(3); phat(4); phat(5)];
mus = 1:comp;
mus = mus .* phat(1);
w = phat(2);
distn = cell(comp, 1); %initialize to empty cell array
ls = {':m', ':g', ':c', ':b'};
component_pdfs = zeros(comp, length(intensity));
for i = 1:comp
    distn{i} = makedist('Gamma','a', mus(i) .* w, "b", 1 / w);
    component_pdfs(i, :) = pdf(distn{i}, intensity) .* ps(i);
    plot(intensity, component_pdfs(i, :),ls{i}, 'LineWidth',1.5);
end
xlabel('Intensity (photons)')
ylabel('Prob. density')
legend('Data \pm S.E.', 'Fit', '\mu_1', '\mu_2','\mu_3','\mu_4');
hold off
p = gca;
p.FontSize = 14;
p.FontWeight='bold';
% fig.Visible='on';
% title([dataset '_' func2str(func)], 'Interpreter', 'none')
% savefig(fig,[dataset '_' func2str(func)]);