%% shuffle random seed according to current time
rec = Logger();
seed = init_random_seed(5); % init seed with current time
rec.log_field('randomSeed', seed);

%%
common

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

%%
rec.log_field('nFrames', 2)
rec.log_field('nHypothesis', nHypothesis * rec.nFrames)

hypothesisRecordNames = cell(1, rec.nHypothesis);
for iHyp = 1:rec.nHypothesis
    hypothesisRecordNames{iHyp} = ['plabelHyp', num2str(iHyp)];
end
rec.logit(hypothesisRecordNames)


%%
rec.log_field('nSteps', 200)

learnerFrameFeedback = feedbackFrame; 
learnerFrameGuidance = guidanceFrame;

teacherHypothesis = 1;
teacherPolicy = rec.hypothesisPolicies{teacherHypothesis};

teacherFrame = guidanceFrame;
teacherDispatcher = guidanceLineDispatcher;

%%
for iStep = 1:rec.nSteps
    %% start loop
    stepTime = tic;
    fprintf('%4d/%4d',iStep, rec.nSteps);
    rec.logit(iStep)
    
    %% choose and apply action
    state = rec.environment.get_state(); rec.logit(state)
    action = select_action('random', rec.environment); rec.logit(action)
    rec.environment.apply_action(action);
    
    %% simulate teacher response
    teacherPLabel = teacherFrame.compute_labels(teacherPolicy, state, action);
    teacherLabel = sample_action_discrete_policy(teacherPLabel);
    rec.log_field('teacherSignal', teacherDispatcher.get_sample(teacherLabel));
    
    %% compute hypothetic plabels
    
    hypothesisPLabelFeedback = cellfun(@(hyp) learnerFrameFeedback.compute_labels(hyp, state, action), rec.hypothesisPolicies, 'UniformOutput', false);
    hypothesisPLabelGuidance = cellfun(@(hyp) learnerFrameGuidance.compute_labels(hyp, state, action), rec.hypothesisPolicies, 'UniformOutput', false);
    hypothesisPLabel = [hypothesisPLabelFeedback, hypothesisPLabelGuidance];
    rec.log_multiple_fields(rec.hypothesisRecordNames, hypothesisPLabel)
    
    %% end loop
    fprintf('\b\b\b\b\b\b\b\b\b')
end

%%
figure('Position', figPositionBasic)

subplot(3,2,1)
rec.environment.draw_grid(3, 5, 1)

subplot(3,2,[3,5])
scatterpie(rec.teacherSignal(:,1), rec.teacherSignal(:,2), ...
    rec.plabelHyp1, feedbackColors, guidanceLineRadius, 'EdgeColor', 'none');
xlim(guidanceLineXLim)
ylim(guidanceLineXLim)
axis square

subplot(3,2,2)
rec.environment.draw_grid(3, 5, 5)

subplot(3,2,[4,6])
scatterpie(rec.teacherSignal(:,1), rec.teacherSignal(:,2), ...
    rec.plabelHyp2, feedbackColors, guidanceLineRadius, 'EdgeColor', 'none'); 
xlim(guidanceLineXLim)
ylim(guidanceLineXLim)
axis square

figure('Position', figPositionBasic)

subplot(3,2,1)
rec.environment.draw_grid(3, 5, 1)

subplot(3,2,[3,5])
scatterpie(rec.teacherSignal(:,1), rec.teacherSignal(:,2), ...
    rec.plabelHyp3, guidanceLineColors, guidanceLineRadius, 'EdgeColor', 'none');
xlim(guidanceLineXLim)
ylim(guidanceLineYLim)
axis square

subplot(3,2,2)
rec.environment.draw_grid(3, 5, 5)

subplot(3,2,[4,6])
scatterpie(rec.teacherSignal(:,1), rec.teacherSignal(:,2), ...
    rec.plabelHyp4, guidanceLineColors, guidanceLineRadius, 'EdgeColor', 'none'); 
xlim(guidanceLineXLim)
ylim(guidanceLineYLim)
axis square