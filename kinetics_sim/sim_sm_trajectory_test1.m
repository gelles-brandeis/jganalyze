% A <==> B --> C Test script for sim_sm_trajectory
model.states = {'A';'B';'C'};
model.k = [0, 5, 0; 5, 0, 5; 0, 0, 0];
model.start_prob = [1; 0; 0];
traj = sim_sm_trajectory(model, 10);