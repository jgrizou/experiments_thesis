%% shuffle random seed according to current time
rec = Logger();
seed = init_random_seed(0); % init seed with current time
rec.log_field('randomSeed', seed);

%%
common
setup_pick_and_place_world

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
    state = randi(rec.environment.nS); 
    rec.environment.set_state(state); rec.logit(state)
    action = select_action('random', rec.environment); rec.logit(action)
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
plot_pick_and_place_feedback
