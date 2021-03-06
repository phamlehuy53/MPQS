function SET_GLOBAL_VARIABLES()
global EnvironmentWidth ImageWidth SafeDistance AlignmentRange CohesionRange...
    wanderAngle FleeDistance SpeedCorrection ...
    BoidsNum Boids TargetsNum  D_BehindLeader ObstaclesNum Obstacles ObstaclesNumB ObstaclesB ObstaclesNumR ObstaclesR ObstaclesF...
     Reds  Blues xi yi DameOfBlue DameOfRed Fights FightsNum  ...
    ShootDistanceB ShootDistanceR MaxRedNum MaxBlueNum BloodPos RedsNum ...
    Target1  Target2 SizeHPBar BaseR BaseB Targets...
    deviationXB deviationYB deviationXR deviationYR ...
    AccuracyB AccuracyR DieRNum DieBNum ...
    Booms BoomsNum ...
    BattleStatus BattlePreparing BattleWarning BattleFighting ...
    RadiusWarning RadiusFight ...
    NumBluesPerShelter...
    Tank DameOfTank AccuracyTank DieTankNum ShootDistanceTank MaxTankNum TankNum
;

NumBluesPerShelter = 3;  % so linh Blue toi da co the nap tai 1 cho

EnvironmentWidth = 600;
ImageWidth = 60;
SafeDistance = EnvironmentWidth/10; % set separation range
AlignmentRange = EnvironmentWidth/5; % set alignment range
CohesionRange = EnvironmentWidth/4; % set cohesion range
wanderAngle = 5;
FleeDistance = 200;
SpeedCorrection = 100;
%Number of Boids
BoidsNum = 300;
TankNum = 2;
%Number of Targets
BattleStatus = 1;
BattlePreparing = 1;
BattleWarning = 2;
BattleFighting = 3;

TargetsNum = 10;

BloodPos=25;
D_BehindLeader = 130;
RadiusWarning = 500;
RadiusFight = 100;

%% List of Tank
Tank = zeros(MaxTankNum,17); % initialize boids matrix
%{1-3 position, 4-6 velocity, 7-9 accelaration, 10 maxspeed, 11 maxforce, 12 angle,
% 13 max see ahead (for collision avoidance), 14 max avoid force (collision
% avoidance), 15 hit points, 16 radius-fight, 17 radius-warning
%}
%Reds(:,1:2) = 2; % set random position EnvironmentWidth*(2*rand([RedsNum,2])-1)
Tank(:,1) = 800/4*(rand([3,1]))+600; % set random position
Tank(:,2) = 800/4*(rand([3,1]))+600; % set random position
Tank(:,1) = Tank(:,1); 
Tank(:,2) = Tank(:,2);
Tank(:,4:5) = 100; %200*(2*rand([BoidsNum,2])-1); % set random velocity
Tank(:,10) = 10;%*(rand([BoidsNum,1]) + 0.2); % set maxspeed
Tank(:,11) = 0.2; % set maxforce
Tank(:,13) = 200; % set max see ahead
Tank(:,14) = 10; % set max avoid force
Tank(:,15) = 100; % set blood
Tank(:, 16) = RadiusFight;
Tank(:, 17) = RadiusWarning;
%% List of Reds
Reds = zeros(MaxRedNum,18); % initialize boids matrix
%{1-3 position, 4-6 velocity, 7-9 accelaration, 10 maxspeed, 11 maxforce, 12 angle,
% 13 max see ahead (for collision avoidance), 14 max avoid force (collision
% avoidance), 15 hit points, 16 radius-fight, 17 radius-warning
%}
%Reds(:,1:2) = 2; % set random position EnvironmentWidth*(2*rand([RedsNum,2])-1)
Reds(1:3,1) = 800/4*(rand([3,1]))+900; % set random position
Reds(1:3,2) = 800/4*(rand([3,1]))-600; % set random position
Reds(4:6,1) = 800/4*(rand([3,1]))-400; % set random position
Reds(4:6,2) = 800/4*(rand([3,1]))+800; % set random position
Reds(7:9,1) = 800/4*(rand([3,1]))-400; % set random position
Reds(7:9,2) = 800/4*(rand([3,1]))+500; % set random position
Reds(10:12,1) = 800/4*(rand([3,1]))+500; % set random position
Reds(10:12,2) = 800/4*(rand([3,1]))+700; % set random position
Reds(:,1) = Reds(:,1); 
Reds(:,2) = Reds(:,2);
Reds(:,4:5) = 100; %200*(2*rand([BoidsNum,2])-1); % set random velocity
Reds(:,10) = 10;%*(rand([BoidsNum,1]) + 0.2); % set maxspeed
Reds(:,11) = 0.2; % set maxforce
Reds(:,13) = 200; % set max see ahead
Reds(:,14) = 10; % set max avoid force
Reds(:,15) = 100; % set blood
Reds(:, 16) = RadiusFight;
Reds(:, 17) = RadiusWarning;
%% List of Blues
Blues = zeros(MaxBlueNum,18); % initialize boids matrix
%{1-3 position, 4-6 velocity, 7-9 accelaration, 10 maxspeed, 11 maxforce, 12 angle,
% 13 max see ahead (for collision avoidance), 14 max avoid force (collision
% avoidance), 15 hit points, 16 radius-fight, 17 radius-warning
%}
%Blues(:,1:2) = EnvironmentWidth*(2*rand([BluesNum,2])-1); % set random positionB
Blues(:,1) = EnvironmentWidth/4*(rand([MaxBlueNum,1]))-500; % set random position
Blues(:,2) = EnvironmentWidth/4*(rand([MaxBlueNum,1]))-500; % set random position
Blues(:,4:5) = 100; %200*(2*rand([BoidsNum,2])-1); % set random velocity
Blues(:,10) = 10;%*(rand([BoidsNum,1]) + 0.2); % set maxspeed
Blues(:,11) = 0.2; % set maxforce
Blues(:,13) = 120; % set max see ahead
Blues(:,14) = 10; % set max avoid force
Blues(:,15) = 120; % set blood
% Blues(1,15) = 10000; % set blood
Blues(:, 16) = RadiusFight;
Blues(:, 17) = RadiusWarning;
Blues(:, 18) = 0; % Obstacle index following
%% Set static Obstacle data
ObstaclesNum = 6;
Obstacles=zeros(ObstaclesNum,5);    % 1:2 - x,y position; 4 - radius; 5 - num-room
ObstaclesNumB = 1;
ObstaclesB = [0 0 0 0];
ObstaclesNumR = 1;
ObstaclesR = [0 0 0 0];
BaseR=[500 500];
BaseB=[-600 -600];
%% List of Fights
Fights = zeros(2,15);
% BlueOBJ(:,1:2) = EnvironmentWidth/4*(2*rand([BlueNum,2])-1)+300; % set random position
Fights(1,1) = 800; Fights(1,2) = -950; 
Fights(2,1) = 700; Fights(2,2) = -850; 
Fights(:,4:5) = 200; %200*(2*rand([BoidsNum,2])-1); % set random velocity
Fights(:,10) = 20;%*(rand([BoidsNum,1]) + 0.2); % set maxspeed
Fights(:,11) = 0.2; % set maxforce
Fights(:,13) = 200; % set max see ahead
Fights(:,14) = 10; % set max avoid force
Fights(:,15) = 100;

ObstaclesF=zeros(FightsNum,4);

%% Variables
xi = [1,0,0,cos(linspace(pi/2,0,30))]*(FleeDistance-15);
yi = [0,0,1,sin(linspace(pi/2,0,30))]*(FleeDistance-15);

DameOfBlue = 50;
DameOfRed=20;
DameOfTank = 70;

ShootDistanceB = 200; 
ShootDistanceR = 200; 
ShootDistanceTank = 300;
Target1 = [-400 -400 0];  
Target2 = [100 100 0];    
SizeHPBar=1;

%% Accuracy
AccuracyB =0.95; % do chinh xac
AccuracyR =0.9;
AccuracyTank = 0.6;
DieRNum =0 ; 
DieBNum =0;
DieTankNum = 0;
%% Boom
 BoomsNum= 4;
 Booms = zeros(BoomsNum,4);
 Booms( :,4) = 1;
 Booms(1,1)= -300; Booms(1,2)= -300;
 Booms(2,1)= -350; Booms(2,2)= 200;
 Booms(3,1)= 100; Booms(3,2)= -200;
 Booms(4,1)= 100; Booms(4,2)= -100;
end
