#!/usr/bin/env python
# coding: utf-8
################################################################################
## author: yudalang
## date:   2017.10.08
## aim:	  programming the alignment code


################################################################################
import sys;
import pdb;
import numpy as np;


################################################################################
## function here !
def align(seq_A , seq_B):

    m = len(seq_B);
    n = len(seq_A);
    D = np.zeros( shape = ( m + 1, n + 1) );
    #print m,n;

    for i in xrange(1 , m + 1): # 要注意加1

        for j in xrange(1 , n + 1 ):
            delta = 0;
            if seq_B[i-1] == seq_A[j-1]:
                delta = 1;
                #pdb.set_trace();
            D[i,j] = max( D[i-1,j-1] + delta, D[i-1,j], D[i,j-1] );
            # print i,j,D[i,j],seq_B[i-1] ,seq_A[j-1];
        #print "---------------------------";
    return D;


def backtracing(D):
    (i , j) = D.shape;
    # 注意要减1， 因为行和列从0下标开始！
    i = i - 1;
    j = j - 1;

    P = [];
    while( i > 0 or j > 0 ):

        P.append([i , j]);
        #pdb.set_trace();
        if D[i-1,j] == D[i,j]:
            i=i-1;
            continue;
        if D[i,j-1] == D[i,j]:
            j=j-1;
            continue;

        i=i-1;
        j=j-1;

    return P;

def backtracing_all(D):

    (i , j) = D.shape;
    # 注意要减1， 因为行和列从0下标开始！
    i = i - 1;
    j = j - 1;

    P2 = [[]];
    # 1 2 4
    direction = 4;
    while( i > 0 or j > 0 ):

        P2[0].append(direction);
        direction = 0; #clear direction
        #pdb.set_trace();
        if D[i-1,j] == D[i,j]: # 1
            direction += 1;
        if D[i,j-1] == D[i,j]: # 2
            direction += 2;
        if direction < 1:
            direction += 4;

        # 4

    (i , j) = D.shape;
    i = i - 1;
    j = j - 1;



    return P2;



################################################################################

if __name__ == '__main__':
    seq_A = 'RKVRHKV';
    seq_B = 'RKRHV';

    D = align(seq_A , seq_B);

    print D;

    print backtracing(D);

    #pdb.set_trace();

