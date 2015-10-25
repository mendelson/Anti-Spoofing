#include "mex.h"
#include "matrix.h"
#include <math.h>
#include <stdlib.h>

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    
    unsigned int** ubuff;
    size_t col_ubuff    = mxGetN(prhs[0]);
    size_t row_ubuff    = mxGetM(prhs[0]);
    ubuff = (unsigned int **)mxCalloc(col_ubuff, sizeof(unsigned int *));
    
    for(int x = 0; x < col_ubuff; x++) {
        ubuff[x] = (unsigned int *) mxCalloc(row_ubuff, sizeof(unsigned int));
    }
    
    for (int col=0; col < col_ubuff; col++) {
        for (int row=0; row < row_ubuff; row++) {
            ubuff[col][row] = ((unsigned int *)mxGetData(prhs[0]))[row+col*row_ubuff];
        }
    }
    
    for (int col=0; col < col_ubuff; col++) {
        for (int row=0; row < row_ubuff; row++) {
            int ver = (int) ubuff[col][row];
            mexPrintf("ubuff[%d][%d]: %d\n", col, row, ver);
        }
    }
    
    return;
//     unsigned int the_pixel_i_want = ubuff[0][2*32 + 2];
//     printf ("Debug: %d\n\n", the_pixel_i_want);
//     mwSize  nsubs, x;
//     mwIndex index;
//     double  *temp;
//     mwIndex  *subs;
//     
//     /* Get the number of dimensions in array */
//     nsubs=mxGetNumberOfDimensions(prhs[0]);
//     
// //     /* Check for the correct number of indices  */
// //     if (mxGetNumberOfElements(prhs[1]) != nsubs){
// //         mexErrMsgIdAndTxt( "MATLAB:mxcalcsinglesubscript:inputMismatch",
// //                 "You must specify an index for each dimension.");
// //     }
//     
//     /* Allocate memory for the subs array on the fly */
//     subs=(mwIndex *)mxCalloc(nsubs,sizeof(mwIndex));
//     
//     /* Get the indices and account for the fact that MATLAB is 1
//      * based and C is zero based.  While doing this, check to make
//      * sure that an index was not specified that is larger than size
//      * of input array */
//     
//     temp=mxGetPr(prhs[1]);
//     
//     for (x = 0; x < nsubs; x++){
//         subs[x]=(mwIndex) temp[x] - 1;
//         if (temp[x]> ((mxGetDimensions(prhs[0]))[x]) ){
//             mxFree(subs);
//             mexErrMsgIdAndTxt( "MATLAB:mxcalcsinglesubscript:badsubscript",
//                     "You indexed above the size of the array.");
//         }
//     }
//     
//     /* Find the index of location selected.  Note, for example, that
//      * (3,4) in MATLAB corresponds to (2,3) in C. */
//     index = mxCalcSingleSubscript(prhs[0], nsubs, subs);
//     
//     /* Create the output array */
//     plhs[0] = mxCreateDoubleMatrix(1, 1, mxIsComplex(prhs[0]) ? mxCOMPLEX : mxREAL);
//     
//     /* Free allocated memory*/
//     mxFree(subs);
//     
//     /* Assign value in C based array to plhs. */
//     mxGetPr(plhs[0])[0]= mxGetPr(prhs[0])[index];
//     if (mxIsComplex(prhs[0])) {
//         mxGetPi(plhs[0])[0]= mxGetPi(prhs[0])[index];
//     }
//     
//     for (x = 0; x < nsubs; x++)
//     {
//         mexPrintf("%d: %f\n", x, plhs[x]);
//     }
//     
//     
//     
//     
//     
//     
//     
//     
//     
//     
//     
//     
//     
//     
//     
//     
//     
//     
//     #define outILBPCode plhs[0]
//     
//     if (nrhs != 2)
//     {
//         mexErrMsgTxt("\nWrong number of input arguments!\n");
//     }
// 
// //     int *originalInput = (int *) mxGetPr(prhs[0]);
// //     int *dimension = (int *) mxGetData(prhs[1]);
//     int dimension = (int) mxGetScalar(prhs[1]);
// //     mexPrintf("Dimension: %d\n", dimension);
//     int amountElements = (dimension)*(dimension);
//     int *input = (int *) malloc(sizeof(int)*amountElements);
//     int *word = (int *) malloc(sizeof(int)*amountElements);
// //     int *ILBPCode = (int *) mxGetData(plhs[0]);
//     int i, j;
//     int counter = 0;
//     float avg;
//     double *ILBPCode = NULL;
//     
//     for (i = 0; i < dimension; i++)
//     {
//         for (j = 0; j < dimension; j++)
//         {
// // 			mexPrintf("Original[%d][%d]: %d\n", i, j, originalInput[dimension*i + j]);
// //             mexPrintf("Original[%d][%d]: %d\n", i, j,   
// //                     
// //                     (int) mxGetScalar(mxGetCell(prhs[0], mxCalcSingleSubscript(prhs[0], )))
// //             );
// //             mexPrintf("Dimension: %d\n", dimension);
// //             input[dimension*i + j] = originalInput[i][j];
//         }
//     }
//     
//     //////////////////////////////////////////////////////////////
// //     mexPrintf("Dimension: %d\n", dimension);
// //     mexPrintf("prhs[0]: %d     prhs[1]: %d     prhs[2]: %d\n", (int *) mxGetData(prhs[0]), (int *) mxGetData(prhs[1]), (int *) mxGetData(prhs[2]));
// //     mexPrintf("%f\n", amountElements);
// //     mexPrintf("%f\n", *input);
// //     mexPrintf("%f\n", *ILBPCode);
// //     mexPrintf("%f\n", *ILBPCode);
//     //////////////////////////////////////////////////////////////
//     
//     for (i = 0; i < amountElements; i++)
//     {
//         counter += input[i];
//     }
// 
//     avg = (float) counter/amountElements;
//     
//     for (i = 0; i < amountElements; i++)
//     {
//         if ( (float) input[i] < avg )
//         {
//             word[i] = 0;
//         }
//         else
//         {
//             word[i] = 1;
//         }
//     }
//     
//     outILBPCode = mxCreateDoubleMatrix(1, 1, mxREAL);
//     ILBPCode = mxGetPr(outILBPCode);
//     
//     for (i = 0; i < amountElements; i++)
//     {
//             (*ILBPCode) = (*ILBPCode) + word[amountElements - 1 - i]*((int) pow((double) 2, (double) i));
// //             mexPrintf("%f\n", *ILBPCode);
//     }
//     
// //     mexPrintf("%f\n", *ILBPCode);
//     
//     free(input);
//     free(word);
// 
//     return;
}
