lineworld_feedback_2actions
lineworld_feedback_3actions
lineworld_guidance_2actions
lineworld_guidance_3actions


%% save plots
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
plotFolder = fullfile(pathstr, 'plot');
if ~exist(plotFolder, 'dir')
   mkdir(plotFolder)
end

plotFormats = {'png', 'eps'};

plotFilenames = {'lineworld_feedback_2actions', ...
                    'lineworld_feedback_3actions', ...
                    'lineworld_guidance_2actions', ...
                    'lineworld_guidance_3actions'};

save_all_images(plotFolder, plotFormats, plotFilenames)
close all