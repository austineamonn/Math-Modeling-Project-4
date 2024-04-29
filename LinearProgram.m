%%

A=[3,0,0,0,0,2.5,0,0,0,0,0;
    2,0,0,1.5,1.5,2,0,0,0,0,0;
    0,1.5,0,0,0,0,0,0,0,0,0;
    0,0,1.5,0.5,0,0,0,0,0,0,0;
    0,0,0,0,2,0,0,0,0,0,1.5;
    0,0,0,0,0,0,3,0,0,1.5,0;
    0,0,0,0,0,0,0,1.5,0.5,0,0;
    0,0,0,0,0,0,0,1,-1,0,0;
    0,0,1,-1,0,0,0,0,0,0,0
    ]

u=[7000;
    4000;
    12000;
    15000;
    99999999; %because no upper bound
    5000;
    5500;
    99999999;
    99999999;
    6000;
    99999999
    ]

l=[4200;
    2400;
    7200;
    9000;
    2800;
    3000;
    3300;
    0;
    0;
    0; %3600;
    0
    ]

c=[110,210,60.5,53.5,143.25,155.25,136,66.25,33.75,22,26.625]

b=[45000;
    28000;
    9000;
    18000;
    30000;
    20000;
    30000;
    0;
    0
    ]

options = optimoptions('linprog','Algorithm','interior-point')

[x, fval, exitf lag, output] = linprog(-c, A, b, [] , [] , l, [], options)
