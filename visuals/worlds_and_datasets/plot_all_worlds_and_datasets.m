plot_feedback_dataset
plot_guidance_dataset_4actions
plot_guidance_dataset_5actions
plot_lineworld
plot_Tworld
plot_gridworld

%% save plots
% [pathstr, ~, ~] = fileparts(mfilename('fullpath'));
% plotFolder = fullfile(pathstr, 'plot');
% if ~exist(plotFolder, 'dir')
%     mkdir(plotFolder)
% end
% 
% plotFormats = {'eps'};
% 
% plotFilenames = {'feedback_dataset', ...
%     'guidance_dataset_4actions', ...
%     'guidance_dataset_5actions', ...
%     'lineworld', 'lineworld_with_statenb',...
%     'Tworld', 'Tworld_with_statenb',...
%     'gridworld', 'gridworld_with_statenb'};
% 
% 
% save_all_images(plotFolder, plotFormats, plotFilenames)
% close all