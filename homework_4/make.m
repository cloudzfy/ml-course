unzip libsvm-3.20.zip
try
    mex CFLAGS="\$CFLAGS -std=c99" -largeArrayDims libsvm-3.20/matlab/svmtrain.c libsvm-3.20/svm.cpp libsvm-3.20/matlab/svm_model_matlab.c
    mex CFLAGS="\$CFLAGS -std=c99" -largeArrayDims libsvm-3.20/matlab/svmpredict.c libsvm-3.20/svm.cpp libsvm-3.20/matlab/svm_model_matlab.c
catch
    disp('If make.m fails, please check README about detailed instructions.\n');
end