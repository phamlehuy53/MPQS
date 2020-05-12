function [HPPlotTank]=InitializeHPTank(TankNum,MaxTankNum,Tank)
global EnvironmentWidth;
global BloodPosTank
global SizeHPTankBar;

%axis off;
%axis([-EnvironmentMargin EnvironmentWidth+EnvironmentMargin -EnvironmentMargin EnvironmentWidth+EnvironmentMargin]);
axis([-EnvironmentWidth EnvironmentWidth -EnvironmentWidth EnvironmentWidth]);

for i=1:MaxTankNum    
    if (i<=TankNum)        
        blood=Tank(i,15);
    else      
        blood=0;
    end       
    x1=Tank(i,1)-25;
    x2=Tank(i,1)-25+blood/2;
    y1=Tank(i,2)+BloodPosTank;
    y2=Tank(i,2)+BloodPosTank;            
    HPPlotTank(i)=plot([x1 x2],[y1 y2],'-','Color','red','LineWidth',SizeHPTankBar);            

end
