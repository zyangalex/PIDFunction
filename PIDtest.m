clc %Clears the command window
global Up Ui Ud DerPts Pzero;
global PreviousTime PreviousSetpointT PreviousFurnaceT IntegralSetpointT 
global IntegralFurnaceT;
global DTime DSetTemp DFurnTemp DPointsCounter 
global FirstTimeIntegral
fileID=fopen('/Users/alexanderyoung/Documents/MATLAB/PIDTest.txt','w');
%Initialize
Up = 100/700; Ui = 0.005; Ud = 0.1; DerPts = 50; Pzero = 20;
DTime=zeros(DerPts,1); DSetTemp=zeros(DerPts,1); DFurnTemp=zeros(DerPts,1);
IntegralFurnaceT=0; IntegralSetpointT=0; FirstTimeIntegral=0; 
DPointsCounter=0;
x=[];
y=[];
set = [];
Fur = [];
for i=1:1000
    CurTime = 60*i/1000;
    FurnaceTemp = 25 + 5*CurTime;
    SetpointTemp = 25 + 10*CurTime;
    ConPow=PID(CurTime,SetpointTemp,FurnaceTemp);
    fprintf(fileID,'%f, %f, %f, %f\r\n',CurTime,SetpointTemp,FurnaceTemp,ConPow);    
    x=[x,CurTime];
    y=[y, ConPow];
    set = [set, SetpointTemp];
    Fur = [Fur, FurnaceTemp];
end
fclose(fileID);
plot(x, y, x, set, x, Fur);
title('Line Plot of Time versus Setpoint Temp, Furnace Temp and Control Power')
xlabel('time(s)') 
ylabel('Temperature/Control Power') 
legend('ControlPower','SetpointTemp','FurnaceTemp')