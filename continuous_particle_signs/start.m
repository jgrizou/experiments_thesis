warning('off', 'ensure_positive_semidefinite:NegativeEigenvalues')
warning('off', 'ensure_symmetry:ComplexInfNaN')
warning('off', 'process_options:argUnused')
warning('off', 'cross_validation:NotEnoughData')
warning('off', 'Logger:rm_fields')

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
rec.log_field('environment', Continuous_2D_world())


%% Teacher side
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
load(fullfile(pathstr, 'sign_finger.mat'))

rec.log_field('teacherDispatcher', Dispatcher(X, Y, true));
% choose which frames of interaction the teacher uses
rec.log_field('teacherFrame', Continuous_2D_position_guidance_frame(0)) % teacher make no error

%% Learner side

%% Learner side
% choose which frames of interaction the learner uses
rec.log_field('learnerFrame', Continuous_2D_position_guidance_frame(0.01)) % learner believes teacher makes 10% of the times teaching errors

% choose classifier to use
rec.log_field('blankClassifier', @() GaussianUninformativePrior_classifier('shrink', 0.5));


%% Setup experiment
% I declare those variable this way to be sure to not use it from the workspace
% Otherwise an other method would be
% nSteps = 100; rec.logit(nSteps)

rec.log_field('nSteps', 200) % nb of step to simulate
rec.log_field('nInitSteps', 12) %minPointNeeded

% rec.log_field('nHypothesis', 10);
% rec.log_field('hypothesisSamplingMethod', 'active')
rec.log_field('diagGM', 1e-2)
rec.log_field('minWeightGM', 1e-6)
rec.log_field('muNoiseGM', [0.5, 0.5])
rec.log_field('sigmaNoiseGM', 0.1*eye(2))
rec.log_field('pNoiseGM', 0.2)


rec.log_field('uncertaintyMethod', 'signal_sample')
rec.log_field('nSampleUncertaintyPlanning', 20)

% rec.log_field('positionSamplingMethod', 'uncertainty')
rec.log_field('nSampleToEstimateUncertainty', 1000)


methodInfo = struct;
methodInfo.classifierMethod = 'online';
methodInfo.samplingMethod = 'sampling'; %'one_shot'
methodInfo.estimateMethod = 'simple_matching'; %'matching'
methodInfo.cumulMethod = 'batch'; % 'filter'
methodInfo.probaMethod = 'normal'; % 'normalize'
rec.log_field('methodInfo', methodInfo)

rec.log_field('nSampling', 20)
rec.log_field('nCrossValidation', 10)