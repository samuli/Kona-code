/ fuzzy c-means


plot: { [id] 
      data: +(+points),(+clusters); 
      tofile[("plot/clusters-",$id),".out"; data] }

discard: { [x;ids] &~(+/{(x=y)}[x]/:ids) x}


n: 200; d:2
points: (n; d) # ((n*n) _draw 100)%100.0
/points: (0 0; 5 5; 1 0; 4 5; 10 10)
centroids: 0 1
clusters: (n; #centroids) # 0.0                 / point > centroid -mapping
clusters[centroids[0]]:(1.0 0.0)
clusters[centroids[1]]:(0.0 1.0)

euc: { dis:(x-y); _sqr +/(dis^2) }  / euclidean distance
closest: { [pnum] dis: points[pnum] euc/: points[centroids]; centroids[(<dis)[0]] }

m: 4; MAX_ASSIGN: 30; 
fuz: 1 /1.0%(m-1); 



assign: {[p] 
  d:1.0%(euc[points[p]]/:points[centroids])^fuz; clusters[p]:d%+/d }

step1: { 
	old: (n;d) # ,//clusters
	{assign[x]}'discard[!n;centroids]
	change: _abs+//(old-clusters) 
	if[change < 1e-10; stopi::i; i:: maxloops+1] }

updcentroid: {[c] points[c]: +/(clusters[;c]^fuz)*points % +/(clusters[;c]^fuz) }

step2: { {updcentroid[x]}'centroids }


/ # Main loop
i:0; maxloops: 30; stopi:0
while[i<maxloops; { step1[]; step2[] }[]; i+:1]
plot[1]

