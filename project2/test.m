res = zeros(3,4);

[ NN1eval, net6eval, net12eval, treeeval ] = RunTestPCA('train0.05.mat','test0.05.mat',false);
resPCA(1,:) = [ NN1eval, net6eval, net12eval, treeeval ]
[ NN1eval, net6eval, net12eval, treeeval ] = RunTestPCA('train0.1.mat','test0.1.mat',false);
resPCA(2,:) = [ NN1eval, net6eval, net12eval, treeeval ]
[ NN1eval, net6eval, net12eval, treeeval ] = RunTestPCA('train0.15.mat','test0.15.mat',false);
resPCA(3,:) = [ NN1eval, net6eval, net12eval, treeeval ]

%%
[ NN1eval, net6eval, net12eval, treeeval ] = RunTest2('train0.05.mat','test0.05.mat',false);
res(1,:) = [ NN1eval, net6eval, net12eval, treeeval ]
[ NN1eval, net6eval, net12eval, treeeval ] = RunTest2('train0.1.mat','test0.1.mat',false);
res(2,:) = [ NN1eval, net6eval, net12eval, treeeval ]
[ NN1eval, net6eval, net12eval, treeeval ] = RunTest2('train0.15.mat','test0.15.mat',false);
res(3,:) = [ NN1eval, net6eval, net12eval, treeeval ]

[ NN1eval, net6eval, net12eval, treeeval ] = RunTest('train0.05.mat','test0.05.mat',false);
resOld(1,:) = [ NN1eval, net6eval, net12eval, treeeval ]
[ NN1eval, net6eval, net12eval, treeeval ] = RunTest('train0.1.mat','test0.1.mat',false);
resOld(2,:) = [ NN1eval, net6eval, net12eval, treeeval ]
[ NN1eval, net6eval, net12eval, treeeval ] = RunTest('train0.15.mat','test0.15.mat',false);
resOld(3,:) = [ NN1eval, net6eval, net12eval, treeeval ]

%%
x=[0.05 0.1 0.15]
y=res';
yOld = resOld';
yPCA = resPCA';
figure;c
plot(x,y(1,:),'-+',x,y(2,:),'--*',x,y(3,:),':or', x,y(4,:), '-.d', x,yOld(3,:), '-s', x, yOld(4,:), '--x');
legend('1-NN (12 features)','BP-6 (12 features)','BP-12 (12 features)','DTree (12 features)', ...,
    'BP-12 (original features)','DTree (original features)');

xlabel('Probabiliy of faulty in display');  
ylabel('Precision');
set(gca,'XTick',x);

%%
