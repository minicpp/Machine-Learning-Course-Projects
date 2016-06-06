load('pix5000');
matDataSet = mat(:,4:end-1);
matDataSet = zscore(matDataSet);
[coeff, score, latent] = princomp(B);
matPCA = [mat(:,1:3),score,mat(:,end)];
%ColorSpacePlotPCA(matPCA);