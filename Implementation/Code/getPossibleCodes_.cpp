#include "mex.h"
#include <algorithm>
#include <vector>
#include <cmath>

/* The computational routine */
void getPossibleCodes_(double *word, mwSize amountElements, double *codes)
{
    mwSize i;
    mwSize j;
    mwSize k;
    std::vector<double> wordVector;
    
    for (i = 0; i < amountElements; i++) {
        wordVector.push_back(word[i]);
    }
    
    for (i = 0; i < amountElements; i++) {
        for (j = 0; j < amountElements; j++) {
            codes[i] += wordVector.at(amountElements - 1 - j)*pow(2.0, j);
        }
        
        std::rotate(wordVector.begin(), wordVector.begin() + 1, wordVector.end());
    }
}

/* The gateway function */
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
    size_t ncols;
    double *word;
    double amountElements;
    double *codes;

    /* check for proper number of arguments */
    if(nrhs!=2) {
        mexErrMsgIdAndTxt("getPossibleCodes_:nrhs", "Two inputs required.");
    }
    
    /* check that number of rows in second input argument is 1 */
    if(mxGetM(prhs[0])!=1) {
        mexErrMsgIdAndTxt("getPossibleCodes_:notRowVector", "Input must be a row vector.");
    }
    
    amountElements = mxGetScalar(prhs[1]);

    /* create a pointer to the real data in the input matrix  */
    word = mxGetPr(prhs[0]);

    /* create the output matrix */
    plhs[0] = mxCreateDoubleMatrix(1, (mwSize)amountElements, mxREAL);

    /* get a pointer to the real data in the output matrix */
    codes = mxGetPr(plhs[0]);

    /* call the computational routine */
    getPossibleCodes_(word, (mwSize)amountElements, codes);
}
