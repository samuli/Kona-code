/ regression

ls: { a: mmul[ (_inv( mmul[+x; x] )); +x]; a dot\: y }  / least suqares


/ model data
model: { (4*x^2) + (2*x) - 4 + (10*(norm[*(1 _draw 100)%100.0; 0; 1])) }
design: { {x^2,x,1.0}'x }

n: 1000
x: (n _draw 100)%100.0
y: model'x
tofile["data.out"; {x,y}'[x;y]]

/ least squares solution
train: design[x]
beta: ls[train; y]
yhat: dot[beta]/:train
errtrain: mse[yhat;y]

/ test with new data
x: (n _draw 100)%100.0
x: x[<x]
y: model'x
test: design[x]
yhat: dot[beta]/:test

err: mse[yhat;y]
tofile["model.out"; {x,y}'[x; yhat]]

