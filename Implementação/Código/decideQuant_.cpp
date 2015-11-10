#include "mex.h"
#include <cmath>

/* The computational routine */
void decideQuant_(double *input, mwSize amountElementsmwSize, double *decision)
{
    double avg;
    int i;
    double sum = 0;
    double amountElements = (double) amountElementsmwSize;
    int counter = 1;
    double threshold = floor(amountElements/2);
    int nonAOI = 0;
    int isAOI = 0;

    while(counter <= amountElements && nonAOI <= threshold && isAOI < threshold) {
        if(input[counter] == 0)
            nonAOI = nonAOI + 1;
        else
            isAOI = isAOI + 1;

        counter++;
    }

    if(nonAOI <= threshold)
        *decision = 1;
    else
        *decision = 0;
}

/* The gateway function */
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
    double *input;
    double *decision;
    double amountElements;

    /* check for proper number of arguments */
    if(nrhs!=2) {
        mexErrMsgIdAndTxt("decideQuant_:nrhs", "Two inputs required.");
    }
    
    /* check that number of rows in second input argument is 1 */
    if(mxGetM(prhs[0])!=1) {
        mexErrMsgIdAndTxt("decideQuant_:notRowVector", "Input must be a row vector.");
    }
    
    amountElements = mxGetScalar(prhs[1]);

    /* create a pointer to the real data in the input matrix  */
    input = mxGetPr(prhs[0]);

    /* create the output matrix */
    plhs[0] = mxCreateDoubleScalar(0);

    /* get a pointer to the real data in the output matrix */
    decision = mxGetPr(plhs[0]);

    /* call the computational routine */
    decideQuant_(input, (mwSize)amountElements, decision);
}
