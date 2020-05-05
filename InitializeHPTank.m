function [HPTankPlot]=InitializeHPTank(TankNum,MaxTankNum,Tank)
global EnvironmentWidth;
global BloodPos
global SizeHPBar;

%axis off;
%axis([-EnvironmentMargin EnvironmentWidth+EnvironmentMargin -EnvironmentMargin EnvironmentWidth+EnvironmentMargin]);
axis([-EnvironmentWidth EnvironmentWidth -EnvironmentWidth EnvironmentWidth]);

for i=1:MaxTankNum    
    if (i<=TankNum)        
        blood=Tank(i,30);
    else      
        blood=0;
    end       
    x1=Tank(i,1)-25;
    x2=Tank(i,1)-25+blood/2;
    y1=Tank(i,2)+BloodPos;
    y2=Tank(i,2)+BloodPos;            
    HPTankPlot(i)=plot([x1 x2],[y1 y2],'-','Color','r','LineWidth',SizeHPBar);            

end
