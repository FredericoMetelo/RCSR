% INSERT NAMES AND EMAIL ADDRESSES OF YOUR GROUP MEMBERS:
% David Pereira, 54920 : dap.pereira@campus.fct.unl.pt
% Frederico Metelo, 55099 : fc.metelo@campus.fct.unl.pt


% Your implementation please...

% Generate grid

1{grid(W, H)}1 :- width(W), maxheight(H).



%1{position(x,_,X) : rectangle()}

% Generate rectangles

1{left_corner(ID, X, Y) : rectangle(ID, _, _)}1 :- grid(X, Y).

%left_corner(1..ID, X, Y) :- 

%Generator x
%1{position(x, ID, X) : X < W}W :- rectangle(ID, _, _), width(W), X >= 0. 

% Generator y
%1{position(y, ID, Y) : Y < H}H :- rectangle(ID, _, _), maxheight(H), Y >= 0.

% Overlap on x-axis




% Overlap on y-axis





#show grid/2.
%#show left_corner/3.
%#show position/3.
