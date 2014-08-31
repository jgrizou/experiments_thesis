%% Environement
% set-up world
environment = Discrete_mdp_pick_and_place();
environment.init()
environment.set_state(1)
rec.logit(environment)

% generate task hypothesis
% hytothesis are represented as optimal policies
nHypothesis = 3;
nStates = environment.nS;
hypothesisPolicies = cell(1, nHypothesis);
for iHyp = 1:nHypothesis
    tmpEnvironment = Discrete_mdp_pick_and_place();
    tmpEnvironment.init()
    tmpR = zeros(nStates, 1);
    if iHyp == 1
        tmpR(tmpEnvironment.feature_to_state(1,1,1,5,2)) = 1; % sparse reward function
    elseif iHyp == 2
        tmpR(tmpEnvironment.feature_to_state(1,3,1,3,2)) = 1; % sparse reward function
    elseif iHyp == 3
        tmpR(tmpEnvironment.feature_to_state(1,1,5,1,2)) = 1; % sparse reward function     
    end
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