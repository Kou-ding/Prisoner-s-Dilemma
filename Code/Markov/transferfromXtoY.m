function [allcurrentstates, allnextstates, allprobs] = transferfromXtoY(strategyX, strategyY, probability, n, idx, allcurrentstates, allnextstates, allprobs)
    currentstate = "("+num2str(n(1))+","+num2str(n(2))+","+num2str(n(3))+")";
    n(idx(strategyX)) = n(idx(strategyX)) - 1;
    n(idx(strategyY)) = n(idx(strategyY)) + 1;
    nextstate = "("+num2str(n(1))+","+num2str(n(2))+","+num2str(n(3))+")";
    allcurrentstates=[allcurrentstates;currentstate];
    allnextstates=[allnextstates;nextstate];
    allprobs=[allprobs;probability];
    fprintf('%s->%s %.3f\n',currentstate,nextstate,probability);
    fprintf('\n');
end