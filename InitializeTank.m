function [TankPlot]=InitializeTank(v_ImageTank,v_AlphaTank,v_ImageDiedTank,v_AlphaDiedTank,OBJNum,OBJs)
global EnvironmentWidth;
global ImageWidth;

axis([-EnvironmentWidth EnvironmentWidth -EnvironmentWidth EnvironmentWidth]);

for i=1:OBJNum
    angle = -180;	% imrotate rotates ccw  
        if (OBJs(i,15)>=0)
            img_i = imrotate(v_ImageTank, angle);
            alpha_i = imrotate(v_AlphaTank, angle); 
        else
        img_i = imrotate(v_ImageDiedTank, angle);
        alpha_i = imrotate(v_AlphaDiedTank, angle);                
        end  
    TankPlot(i) = image(OBJs(i,1)- ImageWidth/2, OBJs(i,2)-ImageWidth/2, img_i);
    TankPlot(i).AlphaData = alpha_i;      
end