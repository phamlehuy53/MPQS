function [index,tmpDist]=distTargets(Boid,OBJNum,OBJs)
tmpDist=100000;J=0;
for i=1:OBJNum
q-    if (dist(Boid,OBJs(i,:))<tmpDist )
        tmpDist=dist(Boid,OBJs(i,:));
        J=i;
    end
end
index=J;
end