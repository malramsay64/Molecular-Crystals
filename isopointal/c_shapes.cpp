#include "c_shapes.h"


shape::shape(){
    pos = vect(0,0);
    theta = 0;
    calc_delta();
}

shape::shape(vect p, double t){
    pos = vect(p);
    theta = t;
    calc_delta();
}

void shape::set_pos(double x, double y){
    pos = vect(x,y);
}

void shape::set_theta(double t){
    theta = t;
}

vect shape::get_pos(){
    return pos;
}

double shape::get_theta(){
    return theta;
}

void shape::calc_delta(){
    double dtheta = (2*M_PI)/resolution;
    for (int i = 0; i < resolution; i++){
        delta.push_back(1);
    }
}

snowman::snowman(double r, double d){
    dist = d;
    radius = r;
    calc_delta();
}

snowman::(double r, double d, vect p, double t){
    dist = d;
    radius = r;
    pos = vect(p);
    theta = t;
    calc_delta();
}

double snowman::get_radius(){
    return radius;
}

double snowman::get_dist(){
    return dist;
}

void snowman::calc_delta(){
    double dtheta = (2*M_PI)/resolution;
    double t, x;
    double m = radius-(radius+1-dist)/2;
    for (int i = 0; i < resolution; i++){
        t = i*dtheta;
        if (cos(t) < 0){
            x = -(
            delta.push_back(
