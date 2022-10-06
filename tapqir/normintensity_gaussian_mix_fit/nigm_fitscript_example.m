% nigm_fitscript_example.m: 
% Example script illustrating the use of nigm_fitscript.m

run = '1comp';
nbins=17; % number of bins in histograms
nboot=10; % number of bootstrap samples
global gain_in
gain_in = 45.89;
global n_components
n_compnents = 1;
global parm_names; % may not be necessary
dataset='nigm_fitscript_example.m';
load(dataset);
% data is height (hs) and background(bs) for spots
% both are COLUMN vectors
% 
% x(:, 1) = hs;
% x(:, 2) = bs;


func=@nigm_pdf;

lbounds = [0, 0, 0, -1]; % constrain lower bounds of parameters
ubounds = [1, 1, 1, 1]; % constrain upper bounds of parameters
init_parm = [0.97, 0.2, 0.06, -.05]; % initial param guesses

nigm_fitscript2;