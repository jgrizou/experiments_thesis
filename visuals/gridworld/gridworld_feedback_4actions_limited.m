%% shuffle random seed according to current time
rec = Logger();
seed = init_random_seed(2); % init seed with current time
rec.log_field('randomSeed', seed);

%%
common
setup_gridworld_4actions

%%
rec.log_field('nSteps', 100)

learnerFrame = feedbackFrame;

teacherHypothesis = 1;
teacherPolicy = rec.hypothesisPolicies{teacherHypothesis};

teacherFrame = feedbackFrame;
teacherDispatcher = feedbackDispatcher;

%%
for iStep = 1:rec.nSteps
    %% start loop
    stepTime = tic;
    fprintf('%4d/%4d',iStep, rec.nSteps);
    rec.logit(iStep)
    
    %% choose and apply action
    state = rec.environment.get_state(); rec.logit(state)
    
    % 1 is West
    % 2 is East
    % 3 is North
    % 4 is South
    if state == 1
        possibleAction = [3,2];
    elseif state == 2
        possibleAction = [3,2,1];
    elseif state == 3
        possibleAction = [3,1];
    elseif state == 4
        possibleAction = [3,4,2];
    elseif state == 5
        possibleAction = [3,4,2,1];
    elseif state == 6
        possibleAction = [3,4,1];
    elseif state == 7
        possibleAction = [4,2];
    elseif state == 8
        possibleAction = [4,2,1];
    elseif state == 9
        possibleAction = [4,1];
    end
    action = possibleAction(randi(length(possibleAction)));
    rec.logit(action)
    rec.environment.apply_action(action);
    
    %% simulate teacher response
    teacherPLabel = teacherFrame.compute_labels(teacherPolicy, state, action);
    teacherLabel = sample_action_discrete_policy(teacherPLabel);
    rec.log_field('teacherSignal', teacherDispatcher.get_sample(teacherLabel));
    
    %% compute hypothetic plabels
    hypothesisPLabel = cellfun(@(hyp) learnerFrame.compute_labels(hyp, state, action), rec.hypothesisPolicies, 'UniformOutput', false);
    rec.log_multiple_fields(rec.hypothesisRecordNames, hypothesisPLabel)
    
    %% end loop
    fprintf('\b\b\b\b\b\b\b\b\b')
end

%%
plot_gridworld_feedback
