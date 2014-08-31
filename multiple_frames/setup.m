%% Learner side
% choose which frame of interaction the learner uses
rec.log_field('learnerFrameFeedback',Discrete_mdp_feedback_frame(0.01)) % learner believes teacher makes 10% of the times teaching errors

% choose which frame of interaction the learner uses
rec.log_field('learnerFrameGuidance',Discrete_mdp_guidance_frame(0.01)) % learner believes teacher makes 10% of the times teaching errors

% choose classifier to use
rec.log_field('blankClassifier', @() GaussianUninformativePrior_classifier('shrink', 0.5));

%%
rec.log_field('nFrames', 2)
rec.log_field('nHypothesis', nHypothesis * rec.nFrames)

hypothesisRecordNames = cell(1, rec.nHypothesis);
for iHyp = 1:rec.nHypothesis
    hypothesisRecordNames{iHyp} = ['plabelHyp', num2str(iHyp)];
end
rec.logit(hypothesisRecordNames)

%% Setup experiment
% I declare those variable this way to be sure to not use it from the workspace
% Otherwise an other method would be
% nSteps = 100; rec.logit(nSteps)

rec.log_field('nSteps', 200) % nb of step to simulate
rec.log_field('nInitSteps', 12) %minPointNeeded

actionSelectionInfo = struct;
actionSelectionInfo.method = 'random';
actionSelectionInfo.initMethod = 'random';
actionSelectionInfo.confidentMethod = 'random';
actionSelectionInfo.epsilon = 0;
actionSelectionInfo.nStepBetweenUpdate = 1;
rec.log_field('actionSelectionInfo', actionSelectionInfo)

methodInfo = struct;
methodInfo.classifierMethod = 'online';
methodInfo.samplingMethod = 'one_shot';
methodInfo.estimateMethod = 'matching';
methodInfo.cumulMethod = 'filter';
methodInfo.probaMethod = 'pairwise';
rec.log_field('methodInfo', methodInfo)

rec.log_field('nSampling', 20)
rec.log_field('nCrossValidation', 10)

rec.log_field('confidenceLevel', 0.9)


