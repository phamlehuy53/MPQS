function [index,tmpDist]=distTargets(Boid,OBJNum,OBJs)
tmpDist=100000;J=0;
for i=1:OBJNum
    if (dist(Boid(1:4),OBJs(i,1:4))<tmpDist )
        tmpDist=dist(Boid(1:4),OBJs(i,1:4));
        J=i;
    end
end
index=J;
end