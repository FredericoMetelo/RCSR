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
{target(Xo, Yo, Xf, Yf):number(Xo, Yo, _ )} :- cell(Xf, Yf).

% Code movement:
% Only Horizontal or Vertical Movements: x inicial = x f
:- target( Xo, Yo, Xf, Yf), Xo != Xf, Yo != Yf.

% Only to areas:
:- target( Xo, Yo, Xf, Yf), not area(Xf, Yf, _).

% No multiplication  of circles
:- number(X, Y, _), target(X, Y, Xf1, Yf1), target(X, Y, Xf2, Yf2), Xf1 != Xf2.
:- number(X, Y, _), target(X, Y, Xf1, Yf1), target(X, Y, Xf2, Yf2), Yf1 != Yf2.

% No overlap of circles
:- number(X1, Y1, _), number(X2, Y2, _), target(X1, Y1, X, Y), target(X2, Y2, X, Y), X1 != X2.
:- number(X1, Y1, _), number(X2, Y2, _), target(X1, Y1, X, Y), target(X2, Y2, X, Y), Y1 != Y2.

% All Circles move
:- number(X, Y, _), not target(X, Y, _, _).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

grey_clear(N) :- target(Xo, Yo, Xf, Yf), area(Xf, Yf, N).
:- not grey_clear(N), area( _, _, N).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate arrows arrow(x_number, Y_number, X_path, Y_path):
% Horizontal gen
arrow(Xo, Y, Xo..Xf, Y) :- target(Xo, Y, Xf, Y), Xo < Xf.
arrow(Xo, Y, Xf..Xo, Y) :- target(Xo, Y, Xf, Y), Xo > Xf.
arrow(X, Yo, X, Yo..Yf) :- target(X, Yo, X, Yf), Yo < Yf.
arrow(X, Yo, X, Yf..Yo) :- target(X, Yo, X, Yf), Yo > Yf.

fail :- arrow(X1, Y1, X, Y), arrow(X2, Y2, X, Y), X1 != X2.
fail :- arrow(X1, Y1, X, Y), arrow(X2, Y2, X, Y), Y1 != Y2.
:- fail.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Guarantee the threshold on goals
additor(N, Xo, Yo, V) :- target(Xo, Yo, Xf, Yf), number(Xo, Yo, V), goal(N, _), area(Xf, Yf, N).

g(N, Aux, T) :-  goal(N, T), Aux = #sum{ V:additor(N, Xo, Yo, V)}, Aux == T.
:- goal(N, T), Aux = #sum{ V : additor(N, Xo, Yo, V) }, Aux != T.


%#show additor/4.
%#show g/3.
%#show arrow/4.
#show target/4.

