function RedrawTank(Tank,TankNum,v_ImageTank,v_AlphaTank,v_ImageTankDied,v_AlphaTankDied,TankPlot)
global EnvironmentWidth;
global ImageWidth;


for TankIndex = 1 : TankNum
    if (Tank(TankIndex, 15) > 0)            
                %     v_angle = Boids(BoidIndex,12);
        v_angle = 180;
        try
            img_i = imrotate(v_ImageTank, v_angle );
            alpha_i = imrotate(v_AlphaTank, v_angle );
        catch Me
            v_angle
        end

        TankPlot(TankIndex).CData = img_i;
        TankPlot(TankIndex).AlphaData = alpha_i;

        try
            TankPlot(TankIndex).XData = Tank(TankIndex,1)-ImageWidth/2;
            TankPlot(TankIndex).YData = Tank(TankIndex,2)-ImageWidth/2;
        catch Me
            [Tank(TankIndex,1),Tank(TankIndex,2)]
        end
    else
        TankPlot(TankIndex).CData = v_ImageTankDied;
        TankPlot(TankIndex).AlphaData = v_AlphaTankDied;
    end
end

drawnow;