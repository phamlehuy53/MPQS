function Tank = updateAtBoundary_Tank(Tank, TankIndex)
global EnvironmentWidth
global SpeedCorrection

if Tank(TankIndex,1) < - EnvironmentWidth
    Tank(TankIndex,4)  = Tank(TankIndex,4) + SpeedCorrection;
    if  Tank(TankIndex,5) > 0
        Tank(TankIndex,5)  = Tank(TankIndex,5) + SpeedCorrection;
    else
        Tank(TankIndex,5)  = Tank(TankIndex,5) - SpeedCorrection;
    end
end
if Tank(TankIndex,1)  > EnvironmentWidth
    Tank(TankIndex,4)  = Tank(TankIndex,4) - SpeedCorrection;
    if  Tank(TankIndex,5) > 0
        Tank(TankIndex,5)  = Tank(TankIndex,5) + SpeedCorrection;
    else
        Tank(BoidIndex,5)  = Tank(BoidIndex,5) - SpeedCorrection;
    end
end
if Tank(TankIndex,2) < - EnvironmentWidth
    Tank(TankIndex,5)  = Tank(TankIndex,5) + SpeedCorrection;
    if  Tank(TankIndex,4) > 0
        Tank(TankIndex,4)  = Tank(TankIndex,4) + SpeedCorrection;
    else
        Tank(TankIndex,4)  = Tank(TankIndex,4) - SpeedCorrection;
    end
end
if Tank(TankIndex,2)  > EnvironmentWidth
    Tank(TankIndex,5)  = Tank(TankIndex,5) - SpeedCorrection;
    if  Tank(TankIndex,4) > 0
        Tank(TankIndex,4)  = Tank(TankIndex,4) + SpeedCorrection;
    else
        Tank(TankIndex,4)  = Tank(TankIndex,4) - SpeedCorrection;
    end
end
end