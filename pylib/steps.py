#!/usr/local/bin/python

import math
import sys

def my_dist(steps, num, freq):
    prev = [-1]
    linear_scale = [ i1*(steps/num) for i1 in xrange(num+1) ]
    log_scale = [ math.ceil(math.exp(i2*(math.log(steps/num)/freq)))-1 for i2 in xrange(freq) ]
    for s1 in linear_scale:
        for s2 in log_scale:
            s = int(s1 + s2)
            if s == 0:
                continue
            if s not in prev:
                print s
                prev = [s]
            else:
                while s in prev:
                    s += 1
                print s
                prev += [s]




if __name__ == "__main__":
    if len(sys.argv) == 2:
        num_key = 100
        num_freq = 40
        steps = int(sys.argv[1])
    if len(sys.argv) == 4:
        steps, num_key, num_freq = [ int(n) for n in sys.argv[1:] ]
    my_dist(steps, num_key, num_freq)
