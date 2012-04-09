/ k-means

/ NOTE: uses util.k, include by:
/   cat inc.k 2.k > temp.k; rlwrap ../k temp.k


plot: { [id] 
      data: {x,y}'[points; clusters]; 
      tofile[("plot/clusters-",$id),".out"; data] }

discard: {[x;ids] a: ids ?/: !#x; ((#ids) _ <a) }  / discard ids from x

n: 500
points: (n; 2) # ((n*n) _draw 100)%100.0
centroids: 0 1 2 3 4 5
clusters: n # 0                     / point > centroid -mapping
clusters[centroids]:centroids       / 0=not assigned, 1-n=centroid
others: discard[points; centroids]  / centroids discarded


plot[0]

euc: { dis:(x-y); _sqr +/(dis^2) }  / euclidean distance
closest: { [pnum] dis: points[pnum] euc/: points[centroids]; centroids[(<dis)[0]] }

/ # Step 1: assign points to closest centroids
assign: { [pnum] clusters[pnum]: closest[pnum]  }
step1: { assign'others }

/ # Step 2: move centroids to average of assigned points
centroidpos: { [ps] :[(#ps) > 1; avg[points[ps]]; points[ps] ] }
updatecentroid: { [ps; id] pos:centroidpos[ps]; dif: _abs +/ pos-points[id]; points[id]: pos; dif }
step2: { 
	 ps: {(>x)[!+/x]}'(clusters =/: centroids); 
	 change:(),{updatecentroid[x; y]}'[ps; centroids];
	 if[((*change[>change]) < 1e-10); stopi::i; i:: maxloops+1] }

/ # Main loop
i:0; maxloops: 30; stopi:0
while[i<maxloops; { step1[]; step2[] }[]; i+:1]
plot[1]

