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



% Stop arrow crossing: Diferentes targets, que se movem em eixos diferentes, então distãncia entre o inicio e fim da seta tem que ser menor á distância até ao eixo do movimento do outro.
% https://www.geeksforgeeks.org/check-if-two-given-line-segments-intersect/

% Testa Colinearidade dos pontos.
on_segment(Px, Py, Qx, Qy, Rx, Ry):- target(Px, Py, Qx, Qy), target(Rx, Ry, _, _),
 Max_p_r_x = #max{Px, Rx}, Qx <= Max_p_r_x, Min_p_r_x = #min{Px, Rx}, Qx >= Min_p_r_x,
 Max_p_r_y = #max{Py, Ry}, Qy <= Max_p_r_y, Min_p_r_y = #min{Px, Rx}, Qx >= Min_p_r_y.

% Sigo os 3 valores de orientacao do tutorial 0,1,2
% coolinear
orientation(Px, Py, Qx, Qy, Rx, Ry, 0):- Val = (Qy - Py) * (Rx - Qx) - (Qx - Px) * (Ry - Qy), Val == 0.
% clock-wise
orientation(Px, Py, Qx, Qy, Rx, Ry, 1):- Val = (Qy - Py) * (Rx - Qx) - (Qx - Px) * (Ry - Qy), Val >= 0.
% counterclock-wise
orientation(Px, Py, Qx, Qy, Rx, Ry, 2):- Val = (Qy - Py) * (Rx - Qx) - (Qx - Px) * (Ry - Qy), Val <= 0.


% Guarantee the threshold on goals
{additor(N, Xo, Yo, V) : number( Xo, Yo, V)} :- goal(N, _), area(X, Y, N), target(Xo, Yo, X, Y).
g(N, Aux, T) :-  goal(N, T), Aux = #sum{ V:additor(N, Xo, Yo, V)}, Aux == T.
:- goal(N, T), Aux = #sum{ V : additor(N, Xo, Yo, V) }, Aux != T.

%#show fail_x/2.
%#show fail_y/2.
#show additor/4.
#show g/3.
#show target/4.
