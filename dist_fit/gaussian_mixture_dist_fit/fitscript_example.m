nbins=17; % number of bins in histograms
nboot=10; % number of bootstrap samples
global parm_names; % may not be necessary
dataset='12_16_16_990_efret_fr0to15.mat'
load(dataset);
x=efret_fr1to5;
func=@two_gaussian_one_sigma_pdf
lbounds = [0, 0, 0, -1]; % constrain lower bounds of parameters
ubounds = [1, 1, 1, 1]; % constrain upper bounds of parameters
init_parm = [0.97, 0.2, 0.06, -.05]; % initial param guesses
fitscript;