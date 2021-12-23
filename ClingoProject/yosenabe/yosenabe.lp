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

% Stop arrow crossing: Diferentes targets, que se movem em eixos diferentes, então distãncia entre o inicio e fim da seta tem que ser menor á distância até ao eixo do movimento do outro.
:- target(Px1, Py1, Qx1, Qy1), target(Px2, Py2, Qx2, Qy2),
Py1 == Qy1, Px2 == Qx2,
V_T_dist = |Py2 - Qy2|, V_B_dist = |Py2 - Py1|, V_U_dist = |Qy2 - Py1|, V_T_dist == V_U_dist + V_B_dist,
H_T_dist = |Px1 - Qx1|, H_L_dist = |Px1 - Qx2|, H_R_dist = |Qx1 - Qx2|, H_T_dist == H_L_dist + H_R_dist.

% Lidar com intersecao de coolineares: https://eli.thegreenplace.net/2008/08/15/intersection-of-1d-segments
:- target(Px1, Py1, Qx1, Qy1), target(Px2, Py2, Qx2, Qy2),
Py1 == Py2, Qy1 == Py1, Qy2 == Py2, Qy1 == Qy2, Qx1 != Qx2, Px2 != Px1,
Z1 = #min{Px1, Qx1}, Z2 = #max{Qx1, Px1}, W1 = #min{Qx2, Px2}, W2 = #max{Qx2, Px2},
Z2 >= W1, W2 >= Z1.


:- target(Px1, Py1, Qx1, Qy1), target(Px2, Py2, Qx2, Qy2),
Px1 == Px2, Qx1 == Px1, Qx2 == Px2, Qx1 == Qx2, Qy1 != Qy2, Py2 != Py1,
Z1 = #min{Py1, Qy1}, Z2 = #max{Qy1, Py1}, W1 = #min{Qy2, Py2}, W2 = #max{Qy2, Py2},
Z2 >= W1, W2 >= Z1.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Guarantee the threshold on goals
additor(N, Xo, Yo, V) :- target(Xo, Yo, Xf, Yf), number(Xo, Yo, V), goal(N, _), area(Xf, Yf, N).

g(N, Aux, T) :-  goal(N, T), Aux = #sum{ V:additor(N, Xo, Yo, V)}, Aux == T.
%:- goal(N, T), Aux = #sum{ V : additor(N, Xo, Yo, V) }, Aux != T.


#show additor/4.
#show g/3.
%#show info_x/4.
%#show info_y/4.
%#show target/4.
