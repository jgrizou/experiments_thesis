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
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
load(fullfile(pathstr, 'precomputed_gridworld25.mat'))

environment.set_state(randi(environment.nS));
rec.logit(environment)
rec.logit(nHypothesis)
rec.logit(hypothesisPolicies)
rec.logit(hypothesisRecordNames)


% % set-up world
% gSize = 25;
% environment = Discrete_mdp_gridworld(gSize);
% environment.set_state(randi(environment.nS));
% rec.logit(environment)
% 
% % generate task hypothesis
% % hytothesis are represented as optimal policies
% nStates = environment.nS;
% nHypothesis = environment.nS;
% hypothesisPolicies = cell(1, nHypothesis);
% for iHyp = 1:nHypothesis
%     tmpEnvironment = Discrete_mdp_gridworld(environment.gSize);
%     tmpR = zeros(nStates, 1);
%     tmpR(iHyp) = 1; % sparse reward function, zero everywhere but 1 on a randomly selected state
%     tmpEnvironment.set_reward(tmpR);
%     [~, hypothesisPolicies{iHyp}] = VI(tmpEnvironment);
% end
% rec.logit(nHypothesis)
% rec.logit(hypothesisPolicies)
% 
% hypothesisRecordNames = cell(1, rec.nHypothesis);
% for iHyp = 1:rec.nHypothesis
%     hypothesisRecordNames{iHyp} = ['plabelHyp', num2str(iHyp)];
% end
% rec.logit(hypothesisRecordNames)
