common

%% Environement
% set-up world
environment = Discrete_mdp_lineworld();
environment.set_state(3);

figure('Position', figPositionBasic)
environment.draw_grid()

figure('Position', figPositionBasic)
environment.draw_grid_state_number()