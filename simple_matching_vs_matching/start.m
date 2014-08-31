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
gSize = 5;
environment = Discrete_mdp_gridworld(gSize);
environment.set_state(randi(environment.nS));
rec.logit(environment)

% generate task hypothesis
% hytothesis are represented as optimal policies
nStates = environment.nS;
nHypothesis = environment.nS;
hypothesisPolicies = cell(1, nHypothesis);
for iHyp = 1:nHypothesis
    tmpEnvironment = Discrete_mdp_gridworld(environment.gSize);
    tmpR = zeros(nStates, 1);
    tmpR(iHyp) = 1; % sparse reward function, zero everywhere but 1 on a randomly selected state
    tmpEnvironment.set_reward(tmpR);
    [~, hypothesisPolicies{iHyp}] = VI(tmpEnvironment);
end
rec.logit(nHypothesis)
rec.logit(hypothesisPolicies)

hypothesisRecordNames = cell(1, rec.nHypothesis);
for iHyp = 1:rec.nHypothesis
    hypothesisRecordNames{iHyp} = ['plabelHyp', num2str(iHyp)];
end
rec.logit(hypothesisRecordNames)

%% Teacher side
%generate artificial teaching signals
dim = 2;
samplingAccuracyRnd = @() rand()/2 + 0.5;
isValid = false;
while ~isValid
    [path, isValid] = sample_artificial_dataset_path(dim, samplingAccuracyRnd);
end
load(path) % load X, Y, accuracy
rec.log_field('accuracy', accuracy)
rec.log_field('teacherDispatcher', Dispatcher(X, Y, true));

% %generate artificial teaching signals
% nFeatures = 34;
% expNames = {'OT1', 'OT2', 'RL2', 'RL3'};
% isValid = false;
% while ~isValid % it should alwyas be valid
%     [path, isValid] = sample_EEG_dataset_path(nFeatures, expNames);
% end
% load(path)
% rec.log_field('nFeatures', nFeatures)
% rec.log_field('filename', path)
% rec.log_field('teacherDispatcher', Dispatcher(X, Y, true));

% choose which frames of interaction the teacher uses
rec.log_field('teacherFrame' ,Discrete_mdp_feedback_frame(0)) % teacher make no error (error included in dataset for EEG)

%% Learner side
% choose which frames of interaction the learner uses
rec.log_field('learnerFrame',Discrete_mdp_feedback_frame(0.1)) % learner believes teacher makes 10% of the times teaching errors

% choose classifier to use
rec.log_field('blankClassifier', @() GaussianUninformativePrior_classifier('shrink', 0.5));


%% Setup experiment
% I declare those variable this way to be sure to not use it from the workspace
% Otherwise an other method would be
% nSteps = 100; rec.logit(nSteps)

rec.log_field('nSteps', 500) % nb of step to simulate
rec.log_field('nInitSteps', 12) %minPointNeeded)

actionSelectionInfo = struct;
actionSelectionInfo.method = 'uncertainty';
actionSelectionInfo.initMethod = 'random';
actionSelectionInfo.confidentMethod = 'greedy';
actionSelectionInfo.epsilon = 0.2;
actionSelectionInfo.nStepBetweenUpdate = 1;
rec.log_field('actionSelectionInfo', actionSelectionInfo)

rec.log_field('nStepBetweenStateReset', 0) % 0 means never reset

rec.log_field('uncertaintyMethod', 'signal_sample')
rec.log_field('nSampleUncertaintyPlanning', 20)

rec.log_field('nCrossValidation', 10)
% rec.log_field('nSampling', 50)
% rec.log_field('calibrationRatio', [0.8, 0.2])

rec.log_field('confidenceLevel', 0.9)