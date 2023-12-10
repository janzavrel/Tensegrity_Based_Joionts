%% test model parameters
clear all, close all, clc;

k_all=1e3*ones(6, 1); %stiffness
b_all=2*ones(6, 1); %damping

%points on the frame
G1=[0, 0, 0.5];
G2=[1, 0, 0.5];
G3=[0.5, 1, 0.5];

%bar dimensions
a1=0.04; %cross dimension [m]
h1=0.5; %bar length [m]
A1=[0.3, 0.3, 0.2];
B1=[0.3, 0.3, 0.2+h1];
rho=2700; %density [kg/m3]

%cable lenght
l01=sqrt(sum((A1-G1).^2));
l02=sqrt(sum((A1-G2).^2));
l03=sqrt(sum((A1-G3).^2));
l04=sqrt(sum((B1-G1).^2));
l05=sqrt(sum((B1-G2).^2));
l06=sqrt(sum((B1-G3).^2));

l0_all=[l01, l02, l03, l04, l05, l06]';

predpeti=0.95; %zkraceni volne delky na 95 %