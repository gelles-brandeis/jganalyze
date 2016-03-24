% fit_script.m: script to fit gamma function to dwell time data
% n.b. needs statistics and parallel processing toolboxes

x_max=200;
n_bins = 6;
nboot = 2000;

dataset = 'gate_1st_106'; 
load ('03_26_15_106_gate_fret_1st.mat');
dwells = gate_1st_106';
gamma_fit_script;

dataset = 'cum_gate_fret'; 
load('05_23_15_cum_gate_fret_2nd.mat');
dwells = cum_gate_fret';
gamma_fit_script;
