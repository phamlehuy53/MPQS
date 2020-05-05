function [index,tmpDist]=distTargets_Tank(Tank,OBJNum,OBJs)
tmpDist=100000;J=0;
for i=1:OBJNum
    if (dist(Tank,OBJs(i,:))<tmpDist )
        tmpDist=dist(Tank,OBJs(i,:));
        J=i;
    end
end
index=J;
end