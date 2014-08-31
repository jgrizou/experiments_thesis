%% Environement
% set-up world

environment = Discrete_mdp_pick_and_place();
environment.init();

%%
figure('Position', figPositionBasic)
environment.set_state(environment.feature_to_state(1,1,1,5,2));
environment.draw()

%%
figure('Position', figPositionBasic)
environment.set_state(environment.feature_to_state(2,1,1,9,2));
environment.draw()

%%
figure('Position', figPositionBasic)
environment.set_state(environment.feature_to_state(2,2,1,9,2));
environment.draw()

%%
figure('Position', figPositionBasic)
environment.set_state(environment.feature_to_state(2,3,1,9,2));
environment.draw()

%%
figure('Position', figPositionBasic)
environment.set_state(environment.feature_to_state(1,3,1,3,2));
environment.draw()

%%
figure('Position', figPositionBasic)
environment.set_state(environment.feature_to_state(1,2,1,3,2));
environment.draw()

%%
figure('Position', figPositionBasic)
environment.set_state(environment.feature_to_state(1,1,1,3,2));
environment.draw()

%%
figure('Position', figPositionBasic)
environment.set_state(environment.feature_to_state(2,1,9,3,2));
environment.draw()

%%
figure('Position', figPositionBasic)
environment.set_state(environment.feature_to_state(2,2,9,3,2));
environment.draw()

%%
figure('Position', figPositionBasic)
environment.set_state(environment.feature_to_state(1,2,6,3,2));
environment.draw()

%%
figure('Position', figPositionBasic)
environment.set_state(environment.feature_to_state(1,3,6,3,2));
environment.draw()

%%
figure('Position', figPositionBasic)
environment.set_state(environment.feature_to_state(2,3,6,9,2));
environment.draw()

%%
figure('Position', figPositionBasic)
environment.set_state(environment.feature_to_state(2,2,6,9,2));
environment.draw()

%%
figure('Position', figPositionBasic)
environment.set_state(environment.feature_to_state(2,1,6,9,2));
environment.draw()

%%
figure('Position', figPositionBasic)
environment.set_state(environment.feature_to_state(1,1,6,1,2));
environment.draw()

%%
figure('Position', figPositionBasic)
environment.set_state(environment.feature_to_state(1,2,6,1,2));
environment.draw()

%%
figure('Position', figPositionBasic)
environment.set_state(environment.feature_to_state(2,2,9,1,2));
environment.draw()

%%
figure('Position', figPositionBasic)
environment.set_state(environment.feature_to_state(2,1,9,1,2));
environment.draw()

%%
figure('Position', figPositionBasic)
environment.set_state(environment.feature_to_state(1,1,5,1,2));
environment.draw()

%% save plots
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
plotFolder = fullfile(pathstr, 'plot');
if ~exist(plotFolder, 'dir')
    mkdir(plotFolder)
end

plotFormats = {'png', 'eps'};

save_all_images(plotFolder, plotFormats, {})
close all

