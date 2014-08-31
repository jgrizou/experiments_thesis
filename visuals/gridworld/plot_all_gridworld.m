gridworld_feedback_4actions
gridworld_feedback_4actions_limited
gridworld_feedback_5actions_limited

%% save plots
% [pathstr, ~, ~] = fileparts(mfilename('fullpath'));
% plotFolder = fullfile(pathstr, 'plot');
% if ~exist(plotFolder, 'dir')
%     mkdir(plotFolder)
% end
% 
% plotFormats = {'png', 'eps'};
% 
% plotFilenames = {'gridworld_feedback_4actions_hyp', 'gridworld_feedback_4actions_world', ...
%     'gridworld_feedback_4actions_limited_hyp', 'gridworld_feedback_4actions_limited_world', ...
%     'gridworld_feedback_5actions_limited_hyp', 'gridworld_feedback_5actions_limited_world'};
% 
% save_all_images(plotFolder, plotFormats, plotFilenames)
% close all