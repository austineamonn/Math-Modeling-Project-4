A=[3,0,0,0,0,2.5,0,0,0,0,0;
    2,0,0,1.5,1.5,2,0,0,0,0,0;
    0,1.5,0,0,0,0,0,0,0,0,0;
    0,0,1.5,0.5,0,0,0,0,0,0,0;
    0,0,0,0,2,0,0,0,0,0,1.5;
    0,0,0,0,0,0,3,0,0,1.5,0;
    0,0,0,0,0,0,0,1.5,0.5,0,0;
    0,0,0,0,0,0,0,1,-1,0,0;
    0,0,1,-1,0,0,0,0,0,0,0];

% for question 3, add extra column with zeros
%A=[3,0,0,0,0,2.5,0,0,0,0,0, 0;
%    2,0,0,1.5,1.5,2,0,0,0,0,0, 0;
%    0,1.5,0,0,0,0,0,0,0,0,0, 0;
%    0,0,1.5,0.5,0,0,0,0,0,0,0, 0;
%    0,0,0,0,2,0,0,0,0,0,1.5, 0;
%    0,0,0,0,0,0,3,0,0,1.5,0, 0;
%    0,0,0,0,0,0,0,1.5,0.5,0,0, 0;
%    0,0,0,0,0,0,0,1,-1,0,0, 0;
%    0,0,1,-1,0,0,0,0,0,0,0, 0];

% for question 3, we added the last row as a 1 for u and l
u=[Inf;
    4000;
    12000;
    15000;
    Inf; %because no upper bound
    Inf;
    5500;
    Inf;
    Inf;
    6000;
    Inf];

l=[4200;
    0;
    0;
    0;
    2800;
    3000;
    0;
    0;
    0;
    0; %3600;
    0];

%c=[-110,-210,-60.5,-53.5,-143.25,-155.25,-136,-66.25,-33.75,-22,-26.625];

% function for question 3
%c=[-110,-210,-60.5,-53.5,-143.25,-155.25,-172,-66.25,-33.75,-40,-26.625, 240000];

% function for question 4

c=[-110,-210,-60.5,-53.5,-143.25,-75.25,-172,-66.25,-33.75,-40,-26.625];

%b=[45000;
%    28000;
%    9000;
%    18000;
%    30000;
%    20000;
%    30000;
%    0;
%    0;
%    ];

% material bound for question 5

b=[45000;
    38000;
    9000;
    18000;
    30000;
    20000;
    30000;
    0;
    0;
    ];


options = optimoptions('linprog','Algorithm','dual-simplex');

[x, fval, exitf, lag, output] = linprog(c, A, b, [] , [] , l, u, options);
x
fval