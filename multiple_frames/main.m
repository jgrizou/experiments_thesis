% choose which hypothesis is the one taught by the teacher
teacherHypothesis = randi(rec.nHypothesis/rec.nFrames); % this will be recorded at each iteration so not now
teacherPolicy = rec.hypothesisPolicies{teacherHypothesis};
targetReached = false;
isConfident = false;
for iStep = 1:rec.nSteps
    %% start loop
    stepTime = tic;
    fprintf('%4d/%4d',iStep, rec.nSteps);
    rec.logit(iStep)
    
    %% choose and apply action
    state = rec.environment.get_state(); rec.logit(state)
    action = recorder_select_action(rec, rec.methodInfo); rec.logit(action)
    rec.environment.apply_action(action);
    
    %% simulate teacher response
    teacherPLabel = rec.teacherFrame.compute_labels(teacherPolicy, state, action);
    teacherLabel = sample_action_discrete_policy(teacherPLabel);
    rec.log_field('teacherSignal', rec.teacherDispatcher.get_sample(teacherLabel));
    
    %% compute hypothetic plabels
    % here we have two frames!!!
    hypothesisPLabelFeedback = cellfun(@(hyp) rec.learnerFrameFeedback.compute_labels(hyp, state, action), rec.hypothesisPolicies, 'UniformOutput', false);
    hypothesisPLabelGuidance = cellfun(@(hyp) rec.learnerFrameGuidance.compute_labels(hyp, state, action), rec.hypothesisPolicies, 'UniformOutput', false);
    hypothesisPLabel = [hypothesisPLabelFeedback, hypothesisPLabelGuidance];
    rec.log_multiple_fields(rec.hypothesisRecordNames, hypothesisPLabel)
    
    %% compute hypothesis probabilities
    recorder_compute_proba(rec, rec.methodInfo)
    
    %% detect confidence
    [isConfident, bestHypothesis] = recorder_check_confidence(rec, rec.methodInfo);
    rec.logit(isConfident)
    rec.logit(bestHypothesis)
    rec.logit(teacherHypothesis)
        
    %% end loop
    rec.log_field('dispatcher_empty', rec.teacherDispatcher.who_is_empty())
    rec.log_field('stepTime', toc(stepTime))
    fprintf('\b\b\b\b\b\b\b\b\b')
end

%% saving
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
folder = fullfile(pathstr, 'results', rec.expFolderName);
if ~exist(folder, 'dir')
    mkdir(folder)
end
recFilename = generate_timestamped_filename(folder, 'mat');
rec.save(recFilename)
