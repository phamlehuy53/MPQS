function Boids = updateAtCustomArea(Boids, BoidIndex, topLeft, botRight)
global EnvironmentWidth
global SpeedCorrection

if Boids(BoidIndex,1) < topLeft(1)
    Boids(BoidIndex,4)  = Boids(BoidIndex,4) + SpeedCorrection;
    if  Boids(BoidIndex,5) > 0
        Boids(BoidIndex,5)  = Boids(BoidIndex,5) + SpeedCorrection;
    else
        Boids(BoidIndex,5)  = Boids(BoidIndex,5) - SpeedCorrection;
    end
end
if Boids(BoidIndex,1)  > botRight(1)
    Boids(BoidIndex,4)  = Boids(BoidIndex,4) - SpeedCorrection;
    if  Boids(BoidIndex,5) > 0
        Boids(BoidIndex,5)  = Boids(BoidIndex,5) + SpeedCorrection;
    else
        Boids(BoidIndex,5)  = Boids(BoidIndex,5) - SpeedCorrection;
    end
end
if Boids(BoidIndex,2) < botRight(2)
    Boids(BoidIndex,5)  = Boids(BoidIndex,5) + SpeedCorrection;
    if  Boids(BoidIndex,4) > 0
        Boids(BoidIndex,4)  = Boids(BoidIndex,4) + SpeedCorrection;
    else
        Boids(BoidIndex,4)  = Boids(BoidIndex,4) - SpeedCorrection;
    end
end
if Boids(BoidIndex,2)  > topLeft(2)
    Boids(BoidIndex,5)  = Boids(BoidIndex,5) - SpeedCorrection;
    if  Boids(BoidIndex,4) > 0
        Boids(BoidIndex,4)  = Boids(BoidIndex,4) + SpeedCorrection;
    else
        Boids(BoidIndex,4)  = Boids(BoidIndex,4) - SpeedCorrection;
    end
end
end