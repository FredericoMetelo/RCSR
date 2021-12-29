maxheight(5).
width(2).
rectangle(1, 1, 1).
rectangle(2, 1, 2). 
rectangle(3, 1, 1). 
% rectangle(4, 1, 1). 


cell(0..W, 0..H) :- width(W), maxheight(H).

{left_corner(ID, X, Y) : rectangle(ID,_,_)}:- cell(X, Y).

:- left_corner(ID1, X, Y), left_corner(ID2, X, Y), ID1 != ID2. % Possivelmente Redundate
:- left_corner(ID, X1, Y1), left_corner(ID, X2, Y2), X1 != X2.
:- left_corner(ID, X1, Y1), left_corner(ID, X2, Y2), Y1 != Y2.

:- No_Rect = #count{ID:rectangle(ID, W, H)}, No_left_corer = #count{ID1:left_corner(ID1, X, Y)}, No_left_corer != No_Rect.
fail :- left_corner(ID, X, Y), rectangle(ID, W, H), maxheight(MH), width(MW),
Y + H > MH.
fail :- left_corner(ID, X, Y), rectangle(ID, W, H), maxheight(MH), width(MW),
X + W > MW.
:- fail.


% https://www.geeksforgeeks.org/find-two-rectangles-overlap/
% R1 = L1 + W1, R2 = L2 + W2, T1 = B1 + H1, T2 = B2 + H2
:- ID1 != ID2, left_corner(ID1, L1, B1), rectangle(ID1, W1, H1), left_corner(ID2, L2, B2), rectangle(ID2, W2, H2),
R2 = L2 + W2,
L1 < R2,
R1 = L1 + W1,
R1 > L2,
T1 = B1 + H1,
T1 > B2,
T2 = B2 + H2,
B1 < T2.


% L1 = 0, R1 = 2, B1 = 0, T1 = 4
% L2 = 1, R2 = 3, B2 = 0, T2 = 4

max_row(Y) :- Y = #max{Z : left_corner(ID, _, B), rectangle(ID, _, H), Z = B + H}.

:- max_row(Y), rectangle(ID, _, B), rectangle(ID, _, H), Y < B + H. 

#minimize{Y@2:max_row(Y)}.
%#minimize{Y@1:rectangle(ID, _, H), left_corner(ID, _, B), Y= B + H}.

#show left_corner/3.
#show max_row/1.
% #show safe/3.

