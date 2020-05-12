function [TankNum,Tank]=UpdateTank(Attack,TankNum,Tank)
Point=zeros(1,TankNum);
for i=1:TankNum
    if(Tank(i,15)>0)    
        Tank(i,15)=Tank(i,15)-Attack(1,i);     
    end
end
