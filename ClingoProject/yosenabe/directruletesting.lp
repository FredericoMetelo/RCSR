% target(3,1,3,6). % Horizontal 1
target(1,1,1,3).
target(2,2,5,2).

arrow(Xo, Y, Xo..Xf, Y) :- target(Xo, Y, Xf, Y), Xo < Xf.
arrow(Xo, Y, Xf..Xo, Y) :- target(Xo, Y, Xf, Y), Xo > Xf.
arrow(X, Yo, X, Yo..Yf) :- target(X, Yo, X, Yf), Yo < Yf.
arrow(X, Yo, X, Yf..Yo) :- target(X, Yo, X, Yf), Yo > Yf.

fail :- arrow(X1, Y1, X, Y), arrow(X2, Y2, X, Y), X1 != X2.
fail :- arrow(X1, Y1, X, Y), arrow(X2, Y2, X, Y), Y1 != Y2.
:- fail.
% Y_min = #min{Yo, Yf}, Y_max = #max{Yo, Yf}

#show arrow/4.
#show target/4.