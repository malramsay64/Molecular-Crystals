
set terminal png

set output 'trimer.png'

set size ratio -1
set polar

r1 = 0.6
r2 = 0.5

theta_1 = acos((2.0-r1*r1)/2.0)
alpha = acos((2.0-(r2/r1)*(r2/r1))/2.0)
x2 = 1.0 + r1*cos(pi/2 + theta_1/2 - alpha)
y2 = r1*sin(pi/2 + theta_1/2 - alpha)
theta_2 = atan(y2/x2)
theta_3 = acos((2.0-r2*r2)/2.0)

shape(phi) = (phi > 2*pi - theta_1 || phi < theta_2) ? cos(phi)+sqrt(cos(phi)*cos(phi)-1.0+r1*r1) :\
        (phi < (theta_1+theta_3)) ? cos(phi-theta_1)+sqrt(cos(phi-theta_1)*cos(phi-theta_1)-1.0+r1*r1):\
        1.0

r1 = 0.637556
r2 = 120

theta_1 = r2*pi/180
theta_2 = theta_1/2.0
theta_3 = acos((2.0-r1**2)/2.0)

shape(phi) = (phi > theta_2-theta_3 && phi < theta_2+theta_3) ? \
            cos(phi-theta_2)+sqrt(cos(phi-theta_2)**2-1.0+r1**2) :\
        (phi < 2*pi-theta_2+theta_3 && phi > 2.0*pi-theta_2-theta_3) ?\
            cos(phi-2*pi+theta_2)+sqrt(cos(phi-2*pi+theta_2)**2-1.0+r1**2):\
        1.0



plot shape(t)
