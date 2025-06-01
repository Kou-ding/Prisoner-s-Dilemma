function [allcurrentstates, allnextstates, allprobs] = remaintosamestate(probability, n, allcurrentstates, allnextstates, allprobs)
    currentstate = "("+num2str(n(1))+","+num2str(n(2))+","+num2str(n(3))+")";
    nextstate = "("+num2str(n(1))+","+num2str(n(2))+","+num2str(n(3))+")";
    allcurrentstates=[allcurrentstates;currentstate];
    allnextstates=[allnextstates;nextstate];
    allprobs=[allprobs;probability];
    fprintf('%s->%s %.3f\n',currentstate,nextstate,probability);
    fprintf('\n');
end