function Ps = deterministicPayoffs(R, T, S, P, roundsth, deterministic)
    
switch deterministic
    case 'A'
    % All-C (strategy A) vs All-D (strategy B) vs Trigger (strategy C)

    PAAA = R * roundsth;
    PBBB = P * roundsth;
    PCCC = R * roundsth;
    PABA = S * roundsth; 
    PABB = T * roundsth;
    PACA = R * roundsth; 
    PACC = R * roundsth;
    PBCB = T + P * (roundsth - 1); 
    PBCC = S + P * (roundsth - 1);

    case 'B'
    % CCD (strategy A) vs DDC (strategy B) vs Trigger (strategy C)

    PAAA = fix(roundsth/3) * (2 * R + P) + mod(roundsth, 3) * R;
    PBBB = fix(roundsth/3) * (2 * P + R) + mod(roundsth, 3) * P;
    PCCC = R * roundsth;

    PABA = fix(roundsth/3) * (2 * S + T) + mod(roundsth, 3) * S; 
    PABB = fix(roundsth/3) * (2 * T + S) + mod(roundsth, 3) * T;

    if roundsth == 1
        PACA = R; 
        PACC = R;
    elseif roundsth == 2
        PACA = 2 * R; 
        PACC = 2 * R;
    elseif roundsth == 3
        PACA = 2 * R + T; 
        PACC = 2 * R + S;
    else 
        PACA = 2 * R + T + fix((roundsth-3)/3) * (2 * S + T) + mod(roundsth-3, 3) * S; 
        PACC = 2 * R + S + fix((roundsth-3)/3) * (2 * T + S) + mod(roundsth-3, 3) * T;
    end

    if roundsth == 1
        PBCB = T; 
        PBCC = S;
    elseif roundsth == 2
        PBCB = T + P; 
        PBCC = S + P;
    elseif roundsth == 3
        PBCB = T + S + P; 
        PBCC = T + S + P;
    else 
        PBCB = T + S + P + fix((roundsth-1)/3) * (2 * P + S) + mod(roundsth-1, 3) * P; 
        PBCC = T + S + P + fix((roundsth-1)/3) * (2 * P + T) + mod(roundsth-1, 3) * P;
    end
    
end

    % Return all pay-offs needed
    % PXYX is the pay-off in a game between X vs Y, for X
    % PXYY is the pay-off in a game between X vs Y, for Y
    Ps = [PAAA; PBBB; PCCC; PABA; PABB; PACA; PACC; PBCB; PBCC];
end