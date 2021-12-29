cost(train,50).
cost(bus,50).
cost(plane,90).
duration(train,150).
duration(bus,180).
duration(plane,30).
1{travelBy(X):cost(X, _)}1.
#minimize {C@2:travelBy(X),cost(X,C)}.
#minimize {C@1:travelBy(X),duration(X,C)}.
#show travelBy/1.

