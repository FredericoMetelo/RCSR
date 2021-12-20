% INSERT NAMES AND EMAIL ADDRESSES OF YOUR GROUP MEMBERS:
% Frederico Metelo, 55099 : fc.metelo@campus.fct.unl.pt
% David Pereira, 54920 : dap.pereira@campus.fct.unl.pt

% Your implementation please...
% data:
% number(X, Y, v)
% cell(X, Y)
% area(X, Y, group)
% goal(group, totalV)
% target


% Gerador:
0{target(Xo, Yo, Xf, Yf):number(Xo, Yo, _ )} :- cell(Xf, Yf).

% Code movement:
% Only Horizontal or Vertical Movements: x inicial = x f
:- target( Xo, Yo, Xf, Yf), Xo != Xf, Yo != Yf.
% Only Vertical: -> y inicial = y f
:- target( Xo, Yo, Xf, Yf), not area(Xf, Yf, _).

% No multiplication  of circles
:- number(X, Y, _), target(X, Y, Xf1, Yf1), target(X, Y, Xf2, Yf2), Xf1 != Xf2.
:- number(X, Y, _), target(X, Y, Xf1, Yf1), target(X, Y, Xf2, Yf2), Yf1 != Yf2.

% No overlap of circles
:- number(X1, Y1, _), number(X2, Y2, _), target(X1, Y1, X, Y), target(X2, Y2, X, Y), X1 != X2.
:- number(X1, Y1, _), number(X2, Y2, _), target(X1, Y1, X, Y), target(X2, Y2, X, Y), Y1 != Y2.


% All Circles move
:- number(X, Y, _), not target(X, Y, _, _).

% Guarantee the threshold on goals
a(Aux, N, T):- goal(N, T), Aux = #sum{ V : number(Xo, Yo, V), target(Xo, Yo, X, Y), area(X, Y, N) }, Aux != T.

%#show target/4.
#show a/3.
