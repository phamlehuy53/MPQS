function main()
%% Global variables
global TimeSteps;
TimeSteps = 50000;
global RedsNum;
global Targets;
global BluesNum;
global TankNum;
global Blues;
global RangeView;
global MaxBlueNum MaxRedNum MaxTankNum FightsNum;
MaxBlueNum =9;
MaxRedNum =20;
MaxTankNum = 3;
FightsNum =2; % Flights
% Set global variables
SET_GLOBAL_VARIABLES()
SetObstacles()
BluesNum = 8; % Choose number of Boids to demo
RedsNum = 12; % Choose number of Boids to demo
TankNum = 2;
Targets = zeros(1,RedsNum);
RangeView=0;
% Behaviour__SeekBlue()
Behaviour_Red()
end