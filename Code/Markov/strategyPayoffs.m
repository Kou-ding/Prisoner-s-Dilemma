function [SA, SB, SC] = strategyPayoffs(Ps, n, roundsth)
    
    % Unpack Ps
    PAAA = Ps(1);
    PBBB = Ps(2);
    PCCC = Ps(3);
    PABA = Ps(4); PABB = Ps(5);
    PACA = Ps(6); PACC = Ps(7);
    PBCB = Ps(8); PBCC = Ps(9);
    
    % Unpack n
    n1 = n(1); n2 = n(2); n3 = n(3);
    
    % Strategy total pay-offs per generation
    SA = (n1*(n1-1)*PAAA + n1*n2*PABA + n1*n3*PACA)* roundsth;
    SB = (n1*n2*PABB + n2*(n2-1)*PBBB + n2*n3*PBCB)* roundsth;
    SC = (n1*n3*PACC + n2*n3*PBCC +n3*(n3-1)*PCCC)* roundsth;

end