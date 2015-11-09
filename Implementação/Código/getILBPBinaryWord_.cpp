#include "mex.h"

/* The computational routine */
void getILBPBinaryWord_(double *input, mwSize amountElementsmwSize, double *word)
{
    double avg;
    int i;
    double sum = 0;
    double amountElements = (double) amountElementsmwSize;
    
    for (i = 0; i < amountElements; i++) {
        sum += input[i];
    }
    
    avg = sum/amountElements;
    
    for (i = 0; i < amountElements; i++) {
        if (input[i] < avg)
            word[i] = 0;
        else
            word[i] = 1;
    }
}

/* The gateway function */
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
    double *input;
    size_t ncols;
    double *word;
    double amountElements;

    /* check for proper number of arguments */
    if(nrhs!=2) {
        mexErrMsgIdAndTxt("getILBPBinaryWord_:nrhs", "Two inputs required.");
    }
    
    /* check that number of rows in second input argument is 1 */
    if(mxGetM(prhs[0])!=1) {
        mexErrMsgIdAndTxt("getILBPBinaryWord_:notRowVector", "Input must be a row vector.");
    }
    
    amountElements = mxGetScalar(prhs[1]);

    /* create a pointer to the real data in the input matrix  */
    input = mxGetPr(prhs[0]);

    /* create the output matrix */
    plhs[0] = mxCreateDoubleMatrix(1, (mwSize)amountElements, mxREAL);

    /* get a pointer to the real data in the output matrix */
    word = mxGetPr(plhs[0]);

    /* call the computational routine */
    getILBPBinaryWord_(input, (mwSize)amountElements, word);
}
