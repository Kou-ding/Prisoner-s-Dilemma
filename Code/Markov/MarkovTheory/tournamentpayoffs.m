% Calculate all pay-offs in a tournament between 3 strategies A, B, C
% (cases AA, BB, CC, AB, AC and BC)
function P = tournamentpayoffs(p1, p2, p3, R, T, S, P)

    % A vs A
    [MAA, piAA, PAAA, payoff2] = payoff(p1, p1, R, S, T, P);
    % [~, ~, PAAA, ~] = payoff(p1, p1, R, S, T, P);

    % B vs B
    [MBB, piBB, PBBB, payoff2] = payoff(p2, p2, R, S, T, P);

    % C vs C
    [MCC, piCC, PCCC, payoff2] = payoff(p3, p3, R, S, T, P);

    % A vs B
    [MAB, piAB, PABA, PABB] = payoff(p1, p2, R, S, T, P);

    % A vs C
    [MAC, piAC, PACA, PACC] = payoff(p1, p3, R, S, T, P);

    % B vs C
    [MBC, piBC, PBCB, PBCC] = payoff(p2, p3, R, S, T, P);

    % Return all pay-offs needed
    % PXYX is the pay-off in a game between X vs Y, for X
    % PXYY is the pay-off in a game between X vs Y, for Y
    P=[PAAA; PBBB; PCCC; PABA; PABB; PACA; PACC; PBCB; PBCC];

end