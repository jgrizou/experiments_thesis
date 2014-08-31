warning('off', 'ensure_positive_semidefinite:NegativeEigenvalues')
warning('off', 'ensure_symmetry:ComplexInfNaN')
warning('off', 'process_options:argUnused')
warning('off', 'cross_validation:NotEnoughData')

% We choose to use a Logger as a kind of workspace to store and retrieve usefull variable
% It also allow to easilly creates history of data and retrieve then as easilly
% You may get confuse at first but compare this file with the
% demo_no_recorder to see the benefit of it
% rec is the only short name variable that you should see and stand for
% recorder, a Logger instance.
rec = Logger();

%% shuffle random seed according to current time
seed = init_random_seed(); % init seed with current time
rec.log_field('randomSeed', seed);

%% Environement
% set-up world
nA = 3;
environment = Discrete_mdp_lineworld(nA);
environment.P{1}(5,5) = 0.5; % trick to avoid having two optimal action
environment.P{1}(5,4) = 0.5;
environment.P{2}(1,1) = 0.5;
environment.P{2}(1,2) = 0.5;
environment.set_state(3);
rec.logit(environment)

% generate task hypothesis
% hytothesis are represented as optimal policies
nHypothesis = 2;
nStates = environment.nS;
hypothesisPolicies = cell(1, nHypothesis);
for iHyp = 1:nHypothesis
    tmpEnvironment = Discrete_mdp_lineworld(nA);
    tmpEnvironment.P{1}(5,5) = 0.5; % trick to avoid having two optimal action
    tmpEnvironment.P{1}(5,4) = 0.5;
    tmpEnvironment.P{2}(1,1) = 0.5;
    tmpEnvironment.P{2}(1,2) = 0.5;
    tmpR = zeros(nStates, 1);
    if iHyp == 1
        tmpR(1) = 1; % sparse reward function
    elseif iHyp == 2
        tmpR(5) = 1; % sparse reward function
    end
    tmpEnvironment.set_reward(tmpR);
    [~, hypothesisPolicies{iHyp}] = VI(tmpEnvironment);
end
rec.logit(hypothesisPolicies)

%% Teacher side
% 3 guidance dataset
% clear mus
% clear sigmas
% dist = 5;
% covDiag = 0.8;
%
% mus(1, :, 1) = [dist, 0]; %E
% mus(1, :, 2) = [-dist, 0]; %W
% mus(1, :, 3) = [0, 0]; %Noop
% sigmas(:, :, 1) = eye(2) * covDiag;
% sigmas(:, :, 2) = eye(2) * covDiag;
% sigmas(:, :, 3) = eye(2) * covDiag;

% [X, Y] = gaussian_clusters(mus, sigmas, 1000, false);

[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
load(fullfile(pathstr, 'move_finger.mat'))

rec.log_field('teacherDispatcher', Dispatcher(X, Y, true));