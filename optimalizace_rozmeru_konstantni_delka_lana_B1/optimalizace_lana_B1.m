%%%% Optimalizace rozmeru konstantni delky lana pro kloub B1


clear all, close all, clc;

%% Rozmery pocatecni
a=0.03;
b=0.2;
d=0.05;
e=0.02;
phi=0;

%% Vypocet konstantnich rozmeru
m=sqrt(e^2 + d^2);
delta=atan(e/d);

%% Vypocet rozmeru
xA=b*sin(phi)-a*cos(phi);
yA=b*cos(phi)+a*sin(phi);
xB=b*sin(phi)+a*cos(phi);
yB=b*cos(phi)-a*sin(phi);
xC=-d;
yC=e;
xD=d;
yD=e;

l1=sqrt((xA-xC)^2 + (yA-yC)^2);
l4=sqrt((xB-xD)^2 + (yB-yD)^2);

%celkova delka lana pri uhlu phi=0;
lc0=l1+l4+2*a;

%% Optimalizace rozmeru
x0=[a, d, e];
X=fminsearch(@optim_fcn, x0);


