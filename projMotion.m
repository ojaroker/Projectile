
m=1; % mass of projectile
R=6371000; % mean radius of earth
startHeight = .16*R; %height
G=6.6743e-11; % gravitational constant
M=5.97219e24; % mass of earth
v0 = -7700; % launch speed


out = sim('projectile.slx');
rVals = out.output(:,1);
thetaVals = out.output(:,2);

xVals = rVals .* cos(thetaVals);
yVals = rVals .* sin(thetaVals);
hold on
axis([-1e7 1e7 -1e7 1e7])
axis equal
th = linspace(0, 2*pi, 100);
xEarth = earthRadius * cos(th);
yEarth = earthRadius * sin(th);
plot(xEarth, yEarth, 'b');
comet(xVals,yVals,.3)
hold off