common

%% Environement
% set-up world
environment = Discrete_mdp_gridworld(3);
environment.set_state(5);

figure('Position', figPositionSquare)
environment.draw_grid()

figure('Position', figPositionSquare)
environment.draw_grid_state_number()