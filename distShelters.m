function [index,tmpDist]=distShelters(Boid,OBJNum,OBJs)
global NumBluesPerShelter
tmpDist=100000;J=0;
for i=1:OBJNum
    if OBJs(i, 5)>=NumBluesPerShelter
%         disp([i, " full"])
        continue
    end
    if (dist(Boid(1:4),OBJs(i,1:4))<tmpDist )
        tmpDist=dist(Boid(1:4),OBJs(i,1:4));
%         disp)
        J=i;
    end
end
index=J;
end