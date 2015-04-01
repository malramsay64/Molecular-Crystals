#include <stdlib>
#include <stdio>
#include <vector>
#include <math>
#include "vect.h"

static int resolution = 360;

class shape {
    vect pos;
    double theta;
    std::vector<double> delta;

  public:
    shape();
    shape(vect, double);
    void set_pos(double, double);
    void set_pos(vect)
    void set_theta(double);
    vect get_pos();
    double get_theta();

    void calc_delta();
}

class snowman(shape){
    double dist;
    double radius;
  public:
    snowman(double, double);
    snowman(double, double, vect, double)
    double get_radius();
    double get_dist();

}
