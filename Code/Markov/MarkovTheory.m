function [Ps, allcurrentstates, allnextstates, allprobs, MTheory, mcTheory] = MarkovTheory(p1, p2, p3, payoff, N, roundsth, predetermined, alluniquestates)

    fprintf('Markov theoretical calculations...\n\n');

    % Unpack the payoff matrix
    R = payoff(1); S = payoff(2); T = payoff(3); P= payoff(4);

    % Return the payoffs in a play between two oppenents
    % PXYX is the pay-off in a game between X vs Y, for X
    % PXYY is the pay-off in a game between X vs Y, for Y

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% EXPECTED AVERAGE PAYOFF %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if predetermined == ""
        fprintf('Tournament calculations based on expected average payoff...\n\n');
        Ps = tournamentpayoffs(p1, p2, p3, R, T, S, P);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% DETERMINISTIC GAME THEORY %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    else 
        fprintf('Predetermined payoff calculations used...\n\n');
        Ps = deterministicPayoffs(R, T, S, P, roundsth, predetermined);
    end
    
    fprintf('Current to next state transition rules are applied...\n\n');
    [allcurrentstates,allnextstates,allprobs] = transitionRules(Ps, N, roundsth);
    
    fprintf('Graphing, please wait...\n\n');
    [MTheory, mcTheory] = theoryGraphs(allcurrentstates, allnextstates, allprobs, N, alluniquestates);

end