function [index,tmpDist]=findTarget(Boid,OBJNum,OBJs)
tmpDist=100000;J=0;
for i=1:OBJNum
    if (dist(Boid(1:4),OBJs(i,1:4))<tmpDist ) && ( OBJs(i,15)>0)
        tmpDist=dist(Boid(1:4),OBJs(i,1:4));
        J=i;
    end
end
index=J;