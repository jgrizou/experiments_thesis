warning('off', 'process_options:argUnused')

%% feedback dataset
clear mus
clear sigmas
dist = 3;
covDiag = 0.8;

mus(1, :, 1) = [dist, 0];
mus(1, :, 2) = [-dist, 0];
sigmas(:, :, 1) = eye(2) * covDiag;
sigmas(:, :, 2) = eye(2) * covDiag;

[X, Y] = gaussian_clusters(mus, sigmas, 1000, false);
feedbackDispatcher = Dispatcher(X, Y, true);

feedbackFrame = Discrete_mdp_feedback_frame(0);

%% 5 guidance dataset
clear mus
clear sigmas
dist = 5;

mus(1, :, 1) = [0, dist]; %N
mus(1, :, 2) = [0, -dist]; %S
mus(1, :, 3) = [dist, 0]; %E
mus(1, :, 4) = [-dist, 0]; %W
mus(1, :, 5) = [0, 0]; %Noop
sigmas(:, :, 1) = eye(2) * covDiag;
sigmas(:, :, 2) = eye(2) * covDiag;
sigmas(:, :, 3) = eye(2) * covDiag;
sigmas(:, :, 4) = eye(2) * covDiag;
sigmas(:, :, 5) = eye(2) * covDiag;

[X, Y] = gaussian_clusters(mus, sigmas, 1000, false);
guidanceDispatcher = Dispatcher(X, Y, true);

guidanceFrame = Discrete_mdp_guidance_frame(0);

%% 3 guidance dataset
clear mus
clear sigmas

mus(1, :, 1) = [dist, 0]; %E
mus(1, :, 2) = [-dist, 0]; %W
mus(1, :, 3) = [0, 0]; %Noop
sigmas(:, :, 1) = eye(2) * covDiag;
sigmas(:, :, 2) = eye(2) * covDiag;
sigmas(:, :, 3) = eye(2) * covDiag;

[X, Y] = gaussian_clusters(mus, sigmas, 1000, false);
guidanceLineDispatcher = Dispatcher(X, Y, true);

%% pickAndPlace guidance 4 action
%the same as the cardinal action but reordered
% 1 for right
% 2 for left
% 3 for grasping
% 4 for ungrapsing
clear mus
clear sigmas

mus(1, :, 1) = [dist, 0]; %right
mus(1, :, 2) = [-dist, 0]; %left
mus(1, :, 3) = [0, -dist]; %grasping
mus(1, :, 4) = [0, dist]; %ungrapsing
sigmas(:, :, 1) = eye(2) * covDiag;
sigmas(:, :, 2) = eye(2) * covDiag;
sigmas(:, :, 3) = eye(2) * covDiag;
sigmas(:, :, 4) = eye(2) * covDiag;

[X, Y] = gaussian_clusters(mus, sigmas, 1000, false);
guidanceDispatcherPickAndPlace = Dispatcher(X, Y, true);

%% plot option

% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Courier')
DefaultAxesFontSize = 25;
set(0,'DefaultAxesFontSize', DefaultAxesFontSize)
set(0,'DefaultAxesFontWeight','bold')
set(0,'DefaultAxesLineWidth', 2.5)

figPositionBasic = [0, 0, 800, 500];
figPositionFullScreen = [0, 0, 1200, 500];
figPositionSquare = [0, 0, 600, 600];
figPositionWide = [0, 350, 1200, 350];

niceGreen = [0.4, 0.8, 0.2]; % green
niceRed = [1, 0.2, 0.2]; % red
feedbackColors = [niceGreen; niceRed];

feedbackRadius = 0.3;

feedbackLimCst = 6;
feedbackXLim = [-feedbackLimCst, feedbackLimCst];
feedbackYLim = [-feedbackLimCst, feedbackLimCst];

%
niceBlue = [0.2, 0.4, 0.8]; % 
niceOrange = [0.9, 0.5, 0]; %
niceBlack = [0.07, 0.06, 0.2]; % black
nicePurple = [0.6, 0.07, 0.86]; % purple
niceGray = [0.5, 0.5, 0.5]; %clear grey
guidanceColors = [niceBlue; niceOrange; niceBlack; nicePurple; niceGray];

guidanceRadius = 0.5;

guidanceLimCst = 10;
guidanceXLim = [-guidanceLimCst, guidanceLimCst];
guidanceYLim = [-guidanceLimCst, guidanceLimCst];

%
guidanceLineColors = [niceBlack; nicePurple; niceGray];
guidanceLineRadius = guidanceRadius;

guidanceLineLimCst = guidanceLimCst;
guidanceLineXLim = [-guidanceLimCst, guidanceLimCst];
guidanceLineYLim = [-guidanceLimCst, guidanceLimCst];

%
guidancePickAndPlaceColors = [niceBlack; nicePurple; niceOrange; niceBlue];
guidancePickAndPlaceRadius = guidanceRadius;

guidancePickAndPlaceLimCst = guidanceLimCst;
guidancePickAndPlaceXLim = [-guidanceLimCst, guidanceLimCst];
guidancePickAndPlaceYLim = [-guidanceLimCst, guidanceLimCst];
