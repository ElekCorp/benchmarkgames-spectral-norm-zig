#include <stdlib.h>
#include <stdio.h> 
#include <math.h>

#define FP double
//#define STATIC 2000

FP A(int i, int j)
{
    return (i + j) * (i + j + 1) / 2 + i + 1;
}

FP dot(double* v, double* u, int n)
{
    FP sum=0;
    for (int i = 0; i<n; ++i) {
        sum+=v[i]*u[i];
    }
    
    return sum;
}

void mult_Av(double* in, double* out, int n)
{
    for (int i=0; i<n; ++i) {
        FP sum=0;
        for (int j=0; j<n; ++j) {
            sum+=in[j]/A(i,j);
        }
        out[i]=sum;
    }
}

void mult_Atv(double* in, double* out, int n)
{
    for (int i=0; i<n; ++i) {
        FP sum=0;
        for (int j=0; j<n; ++j) {
            sum+=in[j]/A(j,i);
        }
        out[i]=sum;
    }
}

void mult_AtAv(double* in, double* out, int n, double*tmp) {
    mult_Av(in, tmp, n);
    mult_Atv(tmp, out, n);
}



int main(int argc, char **argv)
{
    int N = ((argc >= 2) ? atoi(argv[1]) : 2000);
    
#ifndef STATIC
    FP* u=malloc(N*sizeof(FP));
    FP* v=malloc(N*sizeof(FP));
    FP* tmp=malloc(N*sizeof(FP));
#else
    if (N!=STATIC) {
        printf("input N != STATIC/n");
        return -1;
    }
    
    FP u[STATIC];
    FP v[STATIC];
    FP tmp[STATIC];
    
#endif
    for (int i=0; i<N; ++i) {
        u[i]=1;
    }
    
    for (int i=0; i<10; ++i) {
        mult_AtAv(u, v, N, tmp);
        mult_AtAv(v, u, N, tmp);
    }
    
#ifndef STATIC
    free(tmp);
#endif
    
    FP res=sqrt(dot(u,v,N)/dot(v,v,N));
#ifndef STATIC
    free(u);
    free(v);
#endif
    
    printf("%.9f\n", res);
}


