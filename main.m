function main()
%% Global variables
global TimeSteps;
TimeSteps = 50000;
global RedsNum;
global Targets;
global BluesNum;
global Blues;
global RangeView;
global MaxBlueNum MaxRedNum FightsNum;
MaxBlueNum =9;
MaxRedNum =20;
FightsNum =2; % Flights
% Set global variables
SET_GLOBAL_VARIABLES()
SetObstacles()
BluesNum = 7; % Choose number of Boids to demo
RedsNum = 18; % Choose number of Boids to demo
Targets = zeros(1,RedsNum);
RangeView=0;
% Behaviour__SeekBlue()
Behaviour_Red()
end