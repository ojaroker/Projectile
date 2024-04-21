
m=1; % mass of projectile
R=6371000; % mean radius of earth
startHeight = .155*R; %height, abt 1000 km
G=6.6743e-11; % gravitational constant
M=5.97219e24; % mass of earth
v0 = 7000; % launch speed

scaleFactor = 1e4;


figure(1)
hold on

% load and scale image
img = imread("NewtonWorld.png");
img = imresize(img, [1770,1770]);
img = flipdim(img,1);
% center image
imshow(img, 'XData', [-883, -883 + size(img,2)], ...
    'YData', [-884, -884 + size(img,1)]);


axis([-1e3 1e3 -1e3 1e3])
% make pi/2 top and positive velocity clockwise
set(gca,'XDir','reverse','YDir','normal') 
axis equal

% Plot Earth as circle
% th = linspace(0, 2*pi, 100);
% xEarth = R * cos(th) ./scaleFactor;
% yEarth = R * sin(th) ./scaleFactor;
% plot(xEarth,yEarth,'b')

% white background
set(gcf,'Color','w')

v0vals = [2000 4000 5500 6500 7090 7500];
for i = v0vals
    v0 = i;
    % get simulated trajectory values r,theta
    out = sim('projectile.slx');
    rVals = out.output(:,1);
    thetaVals = out.output(:,2);
    % convert to cartestian, scale
    xVals = rVals .* cos(thetaVals) ./ scaleFactor;
    yVals = rVals .* sin(thetaVals) ./ scaleFactor;
    
    comet(xVals,yVals,.3)
end
legend(char(['v0=' int2str(v0vals(1))]), ...
    char(['v0=' int2str(v0vals(2))]), ...
    char(['v0=' int2str(v0vals(3))]), ...
    char(['v0=' int2str(v0vals(4))]), ...
    char(['v0=' int2str(v0vals(5))]), ...
    char(['v0=' int2str(v0vals(6))]))
title('Trajectories for Different Initial Velocities (m/s)')

hold off

hold on
subplot(2,1,1)
plot(out.tout,rVals)

subplot(2,1,2)
plot(out.tout,thetaVals)

sgtitle(["Initial Velocity = " int2str(v0)])
hold off