global MaxTankNum;
global TankHP;
global BloodPos;
global SizeHPBar;

delete(TankHP);
for i = 1 : TankNum           
    if (Tank(i,15)>0)       
        x1=Tank(i,1)-25;
        x2=Tank(i,1)-25 + Tank(i,15)/2;
        y1=Tank(i,2)+BloodPos;
        y2=Tank(i,2)+BloodPos;                  
        TankHP(i)=plot([x1 x2],[y1 y2],'-','Color','r','LineWidth',SizeHPBar);%line([x1 x2],[y1 y2],'Color','red','LineStyle','-');       
    end
end
drawnow;