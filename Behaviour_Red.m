function Behaviour_Red()
global TimeSteps;
global Reds RedsNum MaxRedNum RedsHP DieRNum;
global Blues BluesNum MaxBlueNum BluesHP DieBNum;
global Fights FightsNum MaxFightNum ObstaclesF ;
global Booms BoomsNum Targets TargetsNum;
global SaveMousePosition;
global ImageWidth;
global ObstaclesB ObstaclesNumB;
global ObstaclesR ObstaclesNumR;
global Obstacles ObstaclesNum;
global ShootDistanceB ShootDistanceR;
global kB kR Target1 Target2;
global deviationXB deviationYB deviationXR deviationYR ;
global AccuracyB AccuracyR;
global NumBluesPerShelter;
global TankHP Tank TankNum MaxTankNum DieTankNum;
%%
% 
%  PREFORMATTED
%  TEXT
% 
global goToAttack;
goToAttack = 0;
global makeInformation;
global BattleStatus BattlePreparing BattleWarning BattleFighting ...
        RadiusWarning RadiusFight;
makeInformation = zeros(1,RedsNum);
global Counter;

%% first draw
% load image
[v_ImageR,v_AlphaR,v_ImageB,v_AlphaB,v_ImageE,v_AlphaE]=LoadImageBoids();
[v_ImageS1,v_AlphaS1,v_ImageS2,v_AlphaS2,v_ImageS3,v_AlphaS3,v_ImageS4,v_AlphaS4,v_ImageS5,v_AlphaS5,v_ImageS6,v_AlphaS6]=LoadImageOther1();
[v_ImageBB,v_AlphaBB,v_ImageBR,v_AlphaBR,v_ImageBF,v_AlphaBF,v_ImageF,v_AlphaF]=LoadImageBase();
[v_ImageBoom,v_AlphaBoom,v_ImageN,v_AlphaN,v_ImageEmpty,v_AlphaEmpty]=LoadImageBoom();
[v_ImageFR,v_AlphaFR,v_ImageFB,v_AlphaFB]=LoadImageFlag();
[v_ImageTank,v_AlphaTank,v_ImageTankDied,v_AlphaTankDied]=LoadImageTank();
% draw graphic
[fHandler]=InitializeGraphicN();
% draw base

[BasesPlot]=InitializeBase(v_ImageBB,v_AlphaBB,v_ImageBR,v_AlphaBR,v_ImageBF,v_AlphaBF);
[BoomsPlot]=InitializeBoom(v_ImageBoom,v_AlphaBoom,v_ImageEmpty,v_AlphaEmpty,Booms,BoomsNum);
[FightsPlot]=InitializeFight(v_ImageF,v_AlphaF);

% draw obstacles
InitializeObstacles(v_ImageS1,v_AlphaS1,v_ImageS2,v_AlphaS2,v_ImageS3,v_AlphaS3,v_ImageS4,v_AlphaS4,v_ImageS5,v_AlphaS5,v_ImageS6,v_AlphaS6)

[RedsPlot]=InitializeBoid(v_ImageR,v_AlphaR,v_ImageE,v_AlphaE,RedsNum,Reds);
[RedsHP]=InitializeHP(RedsNum,MaxRedNum,Reds);

[BluesPlot]=InitializeBoid(v_ImageB,v_AlphaB,v_ImageE,v_AlphaE,BluesNum,Blues);
[BluesHP]=InitializeHP(BluesNum,MaxBlueNum,Blues);

[TankPlot] =InitializeTank(v_ImageTank,v_AlphaTank,v_ImageTankDied,v_AlphaTankDied,TankNum,Tank); 
[TankHP]=InitializeHP(TankNum, MaxTankNum, Tank);
%%load sound
[bomb,gun,fight,bombFs,gunFs,fightFs]=loadSound();


%%
    MousePosition = [0 0 0];
    titleStr = 'MO PHONG 1 QUAN TAN CONG, 1 QUAN PHONG THU';
    titleStr = [titleStr newline 'KET THUC KHI 1 TRONG 2 BEN HET QUAN!'];
    title(titleStr);
    set(fHandler, 'WindowButtonDownFcn',@cursorClickCallback);
    kB=1;
    kR=1;

%% 
%Event Mouse click
    function cursorPosition = cursorClickCallback(o,e)
        p = get(gca,'CurrentPoint');
        cursorPosition(1:2) = p(1,1:2);
        cursorPosition(3) = 0;
        MousePosition = cursorPosition;
        %Draw Circle - position  
        
        
        if( MousePosition(1:2) <0 ) % click chuot goc trai duoi -> them Obstacles cho B
            ObstaclesNumB = ObstaclesNumB + 1;
            ObstaclesB(ObstaclesNumB, 1:3) = zeros(1, 3);
            SaveMousePosition = plot(MousePosition(1), MousePosition(2), 'o','MarkerSize',6, 'MarkerFaceColor','blue','Color','blue');
%             ObstaclesB(ObstaclesNumB, 1:3) = MousePosition(1:3);
            ObstaclesB(1, 1:3) = MousePosition(1:3);
            kB= ObstaclesNumB;
            
        elseif( MousePosition(1)>0) || ( MousePosition(2)>0)
            ObstaclesNumR = ObstaclesNumR + 1;
            ObstaclesR(ObstaclesNumR, 1:3) = zeros(1, 3);
            SaveMousePosition = plot(MousePosition(1), MousePosition(2), 'o','MarkerSize',6, 'MarkerFaceColor','red','Color','red');
            ObstaclesR(ObstaclesNumR, 1:3) = MousePosition(1:3);
            kR= ObstaclesNumR;
        end
    end

%% calculate agents' positions to move to each iteration
timeTick = 1;
sound(fight,fightFs);
count=0;
%% daviation Bule
deviationXB = ShootDistanceB*(1-AccuracyB*(2*rand - 1));
deviationYB = ShootDistanceB*(1-AccuracyB*(2*rand - 1));

%% daviation Red
deviationXR = ShootDistanceR*(1-AccuracyR*(2*rand - 1));
deviationYR = ShootDistanceR*(1-AccuracyR*(2*rand - 1));
%% 
currentStatus = -1;
global lineDrawn numLines;
lineDrawn = [line([0,0], [0,1], 'Color', 'r', 'LineWidth', 2)];
numLines = 1;
pauseGame = 0;
% feature('DefaultCharacterSet','UTF-8');

while (timeTick < TimeSteps)
    AttackBlue = zeros(1,BluesNum);    % damage caused by R on B
    AttackRed=zeros(1,RedsNum);  
%             for BlueIndex = 1:BluesNum
%                 CurrentBoid = Blues(BlueIndex, :);
%                 force_steek = steer_seek(CurrentBoid, ObstaclesB( 1,1:3));
%                 Blues(BlueIndex,:) = applyForce(CurrentBoid, force_steek);
% 
%             end
%             for BlueIndex = 1:RedsNum
%             end
    
% ?? show messeage box 
    if (currentStatus~=BattleStatus)
        disp(BattleStatus);
        currentStatus = BattleStatus;
        if currentStatus == BattlePreparing
            disp("DEPLOY TROOPS!");
%             waitfor(msgbox("DEPLOY TROOPS!"));
        end
        if currentStatus == BattleWarning
        disp("ENCOUNTER ENEMIES!");
            %             waitfor(msgbox("ENCOUNTER ENEMIES!"));
        end
        if currentStatus == BattleFighting
        disp("ATTACK!");
            %             waitfor(msgbox("ATTACK!"));
        end
        
    end
    switch BattleStatus
        
        case BattlePreparing
        disp("check prepare");
% cho Blues ?i lung tung
        for BlueIndex = 1:BluesNum
    %         Blues = updateAtBoundary(Blues,BlueIndex);
             Blues = updateAtCustomArea(Blues,BlueIndex, [-600, 0], [0, -600]);
            CurrentBoid = Blues(BlueIndex, :);
            force_steek = 0;
            force_wander = steer_wander(CurrentBoid);
            force_separation = steer_separation(CurrentBoid, Blues, BluesNum);

            force =  force_steek*2 + force_wander*0.4 + force_separation*0.6;
             Blues(BlueIndex,:) = applyForce(CurrentBoid, force);

        end
            %% Flight attack
%             ?o?n này cho máy báy bay ra th? bom
         for FightIndex = 1:FightsNum
            %Fights = updateAtBoundary(Fights,FightIndex);
            CurrentBoid = Fights(FightIndex, :);
            force = 5* steer_seek(CurrentBoid, ObstaclesF(FightIndex ,1:3));
            Fights(FightIndex,:) = applyForce(CurrentBoid, force);
            if(dist(Fights(FightIndex,1:3),[0,0,0]) <200)
                  count = count+2;
                  if(count == 20)
                        [BombsPlot]=InitializeBomb2(v_ImageN,v_AlphaN,FightIndex);
                        pause(0.05);
                        sound(bomb,bombFs);
                        delete(BombsPlot); 
                        count=0;
                  end
            end
         end

         %% set target Tank  
         for i = 1:TankNum
             if(Tank(i,15)>0)
                 [tgIndex, tmpDistTank]=distTargets_Tank(Tank(i,:),BluesNum,Blues); 
                 if tmpDistTank < RadiusWarning
                 disp(["Distance warning: ", tmpDist]);
                 BattleStatus = BattleWarning;
                 end
                 Tank = updateAtBoundary_Tank(Tank,i);
                 CurrentTank = Tank(i,:);
                 seek_force = steer_seek(CurrentTank,[-200,-200,0,0]);
                 avd_force=steer_collision_avoidance(CurrentTank,1,Obstacles, ObstaclesNum);
                 force = seek_force*0.5;
                 Tank(i,:) = applyForce(CurrentTank,force);
             end    
         end    
        %% set target Red             
        for i = 1:RedsNum
            if(Reds(i,15)>0)  % still alive
                
%                 N?u phát hi?n Blue thì chuy?n -> BattleWarning, xu?ng case duoies
                [tgIndex, tmpDist]=distTargets(Reds(i,:),BluesNum,Blues);  
                if tmpDist < RadiusWarning
                    disp(["Distance warning: ", tmpDist]);
                    BattleStatus = BattleWarning;
                else
%                     disp(["Distance: ", tmpDist]);
                end
                Reds = updateAtBoundary(Reds,i);
                CurrentBoid = Reds(i, :);
                % Red t?p trung l?i
                see_force = steer_seek(CurrentBoid, ObstaclesR(1,1:3));
                flk_force=steer_flock(CurrentBoid,Reds,RedsNum);
                avd_force=steer_collision_avoidance(CurrentBoid,1,Obstacles, ObstaclesNum);
                force = see_force*1+flk_force*1+avd_force*0.07;
    %             if(Reds(i,15)>0)  % still alive
                    Reds(i,:) = applyForce(CurrentBoid, force);
            end
        end
         
     
        case BattleWarning
            for BlueIndex = 1:BluesNum
        %         Blues = updateAtBoundary(Blues,BlueIndex);
                 Blues = updateAtCustomArea(Blues,BlueIndex, [-600, 0], [0, -600]);  % ?? cho Blues ch? ?i quanh vùng g?n base, ko ?i ra ngoài
                CurrentBoid = Blues(BlueIndex, :);
                force_wander = steer_wander(CurrentBoid);
                force_separation = steer_separation(CurrentBoid, Blues, BluesNum);

                [ObstIndex, tmpDist]=distTargets(Blues(BlueIndex,1:4),ObstaclesNum,Obstacles(:, 1:4));  
                force_arrival = 0;
                if tmpDist > 10 && Obstacles(5) < NumBluesPerShelter
                     Obstacles(5) =  Obstacles(5) + 1 ;
                    % Blue tìm ?á g?n nh?t ?? n?p
                    force_arrival = steer_arrival(CurrentBoid, Obstacles(ObstIndex, :));
                end

                force =  force_arrival*3 + force_separation*1;
                 Blues(BlueIndex,:) = applyForce(CurrentBoid, force);
            end
            
            for i = 1:RedsNum
                if(Reds(i,15)>0)  % still alive
                    [tgIndex, tmpDist]=distTargets(Reds(i,:),BluesNum,Blues);  % kho?ng cách ?? g?n thì chuy?n thành BattleFighting
                        if tmpDist < RadiusFight
                            disp(["Distance fighting: ", tmpDist]);
                            BattleStatus = BattleFighting;
                        else
        %                     disp(["Distance: ", tmpDist]);
                        end
                    Reds = updateAtBoundary(Reds,i);
                    CurrentBoid = Reds(i, :);
                    see_force = steer_seek(CurrentBoid, [-200, -200, 0, 0]); % Red lao th?ng xu?ng base c?a Blue
                    flk_force=steer_flock(CurrentBoid,Reds,RedsNum);
                    avd_force=steer_collision_avoidance(CurrentBoid,1,Obstacles, ObstaclesNum);
                    force = see_force*0.7+flk_force*2+avd_force*0.1;
        %             if(Reds(i,15)>0)  % still alive
                        Reds(i,:) = applyForce(CurrentBoid, force);
                end
            end
        case BattleFighting
               %% Reds
        for i=1:RedsNum
                if(Reds(i,15)>0)
                    Reds = updateAtBoundary(Reds,i);
                    CurrentBoid = Reds(i, :);
                    [J,tmpDist]=findTarget(Reds(i,:),BluesNum,Blues);       
                    if (J>0 && dist(Reds(i,:),Blues(J,:))<ShootDistanceB) % ?? g?n thì b?n

                        numLines = numLines+1;
                        lineDrawn(numLines)=line([Reds(i,1), Blues(J,1)],[Reds(i,2), Blues(J,2)],'Color','red','LineStyle','-.');
                        pause(0.00001);
                        sound(gun,gunFs);

                            AttackBlue(1,J)=AttackBlue(1,J)+25; 

                    else
                        flk_force=steer_flock(CurrentBoid,Reds,RedsNum);    % còn không thì t? l?i
                        avd_force=steer_collision_avoidance(CurrentBoid,1,Obstacles, ObstaclesNum); 

                        if (J>0)
                            arr_force = steer_arrival(CurrentBoid, Blues(J,:));
                        else
                            arr_force = steer_arrival(CurrentBoid, Target1);
                        end
                        force=arr_force*2+flk_force*1+avd_force*0.07;
                        Reds(i,:) = applyForce(CurrentBoid, force); 

                    end 

                end

%             end                
        end

         %% Blues
        for i=1:BluesNum
            if(Blues(i,15)>0)
                
                 Blues = updateAtCustomArea(Blues,i, [-600, 0], [0, -600]);
                CurrentBoid = Blues(i,:);
                [J,tmpDist]=findTarget(Blues(i,:),RedsNum,Reds);  
                if (J>0 && dist(Blues(i,:),Reds(J,:))<ShootDistanceB)
                    % Shoot
                    numLines = numLines+1;
                    lineDrawn(numLines)=line([Reds(J,1), Blues(i,1)-2],[Reds(J,2), Blues(i,2)],'Color','blue','LineStyle','-.');
                    pause(0.00001);
                    sound(gun,gunFs);
                    AttackRed(1,J)=AttackRed(1,J)+30;
                else


                    align_force=steer_alignment(CurrentBoid,Blues,BluesNum);
                    coh_force=steer_cohesion(CurrentBoid,Blues,BluesNum);
                    sepr_force=steer_separation(CurrentBoid,Blues,BluesNum);  
                    force=align_force*7+coh_force*9+sepr_force*0.5;
                    
                    Blues(i,:) = applyForce(CurrentBoid, force);
                end
                
            end
        end 
    end
 %% Boom
    
    % C? 3 timeTick thì v? l?i ???ng ??n 1 l?n
     if(mod(timeTick, 3) == 0)
%         disp("deleted line")
        delete(lineDrawn)
        numLines = 0;
%         disp(AttackBlue)
    end   
 
    % Red dính bom thì ch?t
    for i=1:BoomsNum
        if(Booms(i,4)>0)
            [n]=findTargetBoom(Booms(i,:));
            if (n>0)
              for index = 1:n
                AttackRed(1,Targets(1,index))= AttackRed(1,Targets(1,index))+200;
              end
              Booms(i,4)=0;
              RedrawBoom(Booms,BoomsNum,v_ImageBoom,v_AlphaBoom,v_ImageEmpty,v_AlphaEmpty,BoomsPlot);
              [BombsPlot]=InitializeBomb(v_ImageN,v_AlphaN,i);
              pause(0.3);
              delete(BombsPlot);
            end
        end
    end
    
    
    %% 
    timeTick = timeTick+1;
    %% Update Blues
    [BluesNum,Blues] = UpdateBoid(AttackBlue,BluesNum,Blues);    
    %% Update Reds
    [RedsNum,Reds] = UpdateBoid(AttackRed,RedsNum,Reds);   
    
    %% redraw    
    RedrawFight(v_ImageF,v_AlphaF,FightsPlot);
    RedrawBoom(Booms,BoomsNum,v_ImageBoom,v_AlphaBoom,v_ImageEmpty,v_AlphaEmpty,BoomsPlot)
    RedrawBoid(Reds,RedsNum,v_ImageR,v_AlphaR,v_ImageE,v_AlphaE,RedsPlot);
    RedrawBoid(Blues,BluesNum,v_ImageB,v_AlphaB,v_ImageE,v_AlphaE,BluesPlot);
    RedrawTank(Tank,TankNum,v_ImageTank,v_AlphaTank,v_ImageTankDied,v_AlphaTankDied,TankPlot);
    RedrawRedsHP();
    RedrawBlueHP();
    RedrawTankHP();
    %% Blue Win 
    for i = 1: RedsNum
        if ( Reds(i,15)<= 0 ) 
            DieRNum = DieRNum +1;
        end
    end   
    if ( DieRNum == RedsNum) 
        InitializeFlag (v_ImageFB,v_AlphaFB);
        break;
     else
       DieRNum =0;
     end
        
    %% Red Win 
   for i = 1: BluesNum
        if ( Blues(i,15)<= 0 ) 
            DieBNum = DieBNum +1;
        end
   end
   if ( DieBNum == BluesNum) 
       InitializeFlag (v_ImageFR,v_AlphaFR);
         break;
   else
       DieBNum =0;
   end 
        
end
end