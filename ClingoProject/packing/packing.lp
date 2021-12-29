% INSERT NAMES AND EMAIL ADDRESSES OF YOUR GROUP MEMBERS:
% David Pereira, 54920 : dap.pereira@campus.fct.unl.pt
% Frederico Metelo, 55099 : fc.metelo@campus.fct.unl.pt

% Generation of a grid to place the rectangles
cell(0..W, 0..H) :- width(W), maxheight(H).


% Rectangles are embedde on the grid through their left_corner, for each rectangle we generate a placing
{left_corner(ID, X, Y) : rectangle(ID,_,_)}:- cell(X, Y).

% Prevent Rectangles from either multiplying or overlapping
:- left_corner(ID1, X, Y), left_corner(ID2, X, Y), ID1 != ID2. % Possivelmente Redundate
:- left_corner(ID, X1, Y1), left_corner(ID, X2, Y2), X1 != X2.
:- left_corner(ID, X1, Y1), left_corner(ID, X2, Y2), Y1 != Y2.

%REMOVE OPTIMIZED to not use aggregates:- No_Rect = #count{ID:rectangle(ID, W, H)}, No_left_corer = #count{ID1:left_corner(ID1, X, Y)}, No_left_corer != No_Rect.

% Guarantee all rectangles are placed on the grid
:- rectangle(ID, _ , _), not left_corner(ID, _, _).


fail :- left_corner(ID, X, Y), rectangle(ID, W, H), maxheight(MH), width(MW),
Y + H > MH.
fail :- left_corner(ID, X, Y), rectangle(ID, W, H), maxheight(MH), width(MW),
X + W > MW.
:- fail.



%safe(ID1, ID2):- ID1 != ID2, left_corner(ID1, L1, B1), rectangle(ID1, W1, H1), left_corner(ID2, L2, B2), rectangle(ID2, W2, H2),
%R2 = L2 + W2,
%L1 >= R2.
%safe(ID1, ID2):- ID1 != ID2, left_corner(ID1, L1, B1), rectangle(ID1, W1, H1), left_corner(ID2, L2, B2), rectangle(ID2, W2, H2),
%R1 = L1 + W1,
%R1 <= L2.
%safe(ID1, ID2):- ID1 != ID2, left_corner(ID1, L1, B1), rectangle(ID1, W1, H1), left_corner(ID2, L2, B2), rectangle(ID2, W2, H2),
%T1 = B1 + H1,
%T1 <= B2.
%safe(ID1, ID2):- ID1 != ID2, left_corner(ID1, L1, B1), rectangle(ID1, W1, H1), left_corner(ID2, L2, B2), rectangle(ID2, W2, H2),
%T2 = B2 + H2,
%B1 >= T2.

% The following rule prevents rectangle intersection and is based on the following sources,
% which we adapted for clingo.
% https://www.geeksforgeeks.org/find-two-rectangles-overlap/ 
:- ID1 != ID2, left_corner(ID1, L1, B1), rectangle(ID1, W1, H1), left_corner(ID2, L2, B2), rectangle(ID2, W2, H2),
R2 = L2 + W2,
L1 < R2,
R1 = L1 + W1,
R1 > L2,
T1 = B1 + H1,
T1 > B2,
T2 = B2 + H2,
B1 < T2.

% In
max_row(Y) :- Y = #max{Z : left_corner(ID, _, B), rectangle(ID, _, H), Z = B + H}.

:- max_row(Y), rectangle(ID, _, B), rectangle(ID, _, H), Y < B + H. 

#minimize{Y@2:max_row(Y)}.
%#minimize{Y@1:rectangle(ID, _, H), left_corner(ID, _, B), Y= B + H}.

position(x, ID, X) :- left_corner(ID, X, _).
position(y, ID, Y) :- left_corner(ID, _, Y).

#show position/3.

