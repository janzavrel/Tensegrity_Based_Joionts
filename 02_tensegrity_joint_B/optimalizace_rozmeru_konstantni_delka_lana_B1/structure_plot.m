function structure_plot(a, b, d, e, phi, popis)

xC=-d;
yC=e;
xD=d;
yD=e;
xA=b*sin(phi)-a*cos(phi);
yA=b*cos(phi)+a*sin(phi);
xB=b*sin(phi)+a*cos(phi);
yB=b*cos(phi)-a*sin(phi);
xS=0;
yS=0;

figure(100)
clf;
hold on;
axis equal;
axis([-0.2, 0.2, -0.02, 0.3])
%bodies
plot([xS, (xA+xB)/2], [yS, (yA+yB)/2], '-k', 'LineWidth', 3);
plot([xA, xB], [yA, yB], '-k', 'LineWidth', 3);
plot(xA, yA, 'ok', 'LineWidth', 3);
plot(xB, yB, 'ok', 'LineWidth', 3);
plot(xS, yS, 'ok', 'LineWidth', 3);
plot(xC, yC, 'ok', 'LineWidth', 3);
plot(xD, yD, 'ok', 'LineWidth', 3);
%cables
plot([xA, xC], [yA, yC], '-.b', 'LineWidth', 1);
plot([xB, xD], [yB, yD], '-.b', 'LineWidth', 1);
xlabel('x [m]');
ylabel('y [m]');
title(popis);

hold off

