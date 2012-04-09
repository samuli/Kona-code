/ util
line:{ ,/" ",/:$x } / vector to str, separated by ' ' 
tofile: { [name; mat] (name) 0: line/:mat }

/ linear algebra
dot: { +/ x*y }
mmul: {x dot/:\: +y}   / matrix*matrix, matrix*vector

/ stats
avg:{(+/x)% #x}
var:{avg[x*x]-a*a:avg x }
dev:{_sqr var x}

mse: {avg (x-y)^2 }
rmse: {_sqr mse[x;y] }

pi:3.14159265358979323846
norm: {[x; mu; sd] (1%(sd*_sqr((2*pi)))) * _exp( -((x-mu)^2)%(2*sd^2)) }

