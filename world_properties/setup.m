
%% Teacher side
%generate artificial teaching signals
dim = 2;
samplingAccuracyRnd = @() 0.95;%rand()/2 + 0.5;
isValid = false;
while ~isValid
    [path, isValid] = sample_artificial_dataset_path(dim, samplingAccuracyRnd);
end
load(path) % load X, Y, accuracy
rec.log_field('accuracy', accuracy)
rec.log_field('teacherDispatcher', Dispatcher(X, Y, true));

% choose which frames of interaction the teacher uses
rec.log_field('teacherFrame' ,Discrete_mdp_feedback_frame(0)) % teacher make no error (error included in dataset for EEG)

%% Learner side
% choose which frames of interaction the learner uses
rec.log_field('learnerFrame',Discrete_mdp_feedback_frame(0.01)) % learner believes teacher makes 10% of the times teaching errors

% choose classifier to use
rec.log_field('blankClassifier', @() Gaussian_classifier('shrink', 0.5));


%% Setup experiment
% I declare those variable this way to be sure to not use it from the workspace
% Otherwise an other method would be
% nSteps = 100; rec.logit(nSteps)

rec.log_field('nSteps', 100) % nb of step to simulate
rec.log_field('nInitSteps', 10) %minPointNeeded

actionSelectionInfo = struct;
% actionSelectionInfo.method = 'uncertainty';
actionSelectionInfo.initMethod = 'random';
actionSelectionInfo.confidentMethod = 'greedy';
% actionSelectionInfo.epsilon = 0.2;
actionSelectionInfo.nStepBetweenUpdate = 1;
rec.log_field('actionSelectionInfo', actionSelectionInfo)

rec.log_field('nStepBetweenStateReset', 0) % 0 means never reset

% rec.log_field('uncertaintyMethod', 'signal_sample') %task
rec.log_field('nSampleUncertaintyPlanning', 20)

rec.log_field('nCrossValidation', 10)
% rec.log_field('nSampling', 50)
% rec.log_field('calibrationRatio', [0.8, 0.2])

rec.log_field('confidenceLevel', 0.9)

methodInfo = struct;
methodInfo.classifierMethod = 'online';
methodInfo.samplingMethod = 'one_shot';
methodInfo.estimateMethod = 'simple_matching';
methodInfo.cumulMethod = 'filter';
methodInfo.probaMethod = 'normalize'; %pairwise
rec.log_field('methodInfo', methodInfo)