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

    P = [];
    while( i > 0 or j > 0 ):
        P.append(i , j);
        if D(i-1,j)=D(i,j):
            i=i-1;
            continue;
        if D(i,j-1)=D(i,j)
            j=j-1;
            continue;

        i=i-1;
        j=j-1;

    return P;





################################################################################

if __name__ == '__main__':
    seq_A = 'RKVRHKV';
    seq_B = 'RKRHV';

    D = align(seq_A , seq_B);

    backtracing(D);

    #pdb.set_trace();

