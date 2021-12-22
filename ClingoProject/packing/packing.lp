% INSERT NAMES AND EMAIL ADDRESSES OF YOUR GROUP MEMBERS:
% David Pereira, 54920 : dap.pereira@campus.fct.unl.pt
% Frederico Metelo, 55099 : fc.metelo@campus.fct.unl.pt


% Your implementation please...

%Generator x
1{position(x, ID, X) : X < W}W :- rectangle(ID, _, _), width(W), X >= 0. 

% Generator y
1{position(y, ID, Y) : Y < H}H :- rectangle(ID, _, _), maxheight(H), Y >= 0.

% Overlap on x-axis




% Overlap on y-axis






#show position/3.
