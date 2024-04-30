function [x, fval, exitf, lag, output]=LinearProgram(question,algorithm,salesLevel)

%%Question

%0 - base algorithm
%1,2,3,4,5 - for each question in the problem
%note that question 2 is the base algorithm
%note that there is nothing for question 6 yet

%%Algorithm

%'dual-simplex-highs' (default)
%'dual-simplex-legacy'
%'interior-point'
%'interior-point-legacy'

%%ax1,bx1,cx1

%85,10,5 good
%70,20,10 ok
%35,45,20 bad
%10,30,60 sad

%%Set Up Linear Program

if nargin<5
    salesLevel=0; %use best case scenario levels
    if nargin<2
        question=0; %set to 'base' algoritm
        algorithm='dual-simplex'; %set to dual simplex bc it's the default for linprog
    end
end

if question==0 || question==2

    A=[3,0,0,0,0,2.5,0,0,0,0,0;
        2,0,0,1.5,1.5,2,0,0,0,0,0;
        0,1.5,0,0,0,0,0,0,0,0,0;
        0,0,1.5,0.5,0,0,0,0,0,0,0;
        0,0,0,0,2,0,0,0,0,0,1.5;
        0,0,0,0,0,0,3,0,0,1.5,0;
        0,0,0,0,0,0,0,1.5,0.5,0,0;
        0,0,0,0,0,0,0,1,-1,0,0;
        0,0,1,-1,0,0,0,0,0,0,0];

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
        0;
        0];

    c=[-110,-210,-60.5,-53.5,-143.25,-155.25,-136,-66.25,-33.75,-22,-26.625];

    b=[45000;
       28000;
       9000;
       18000;
       30000;
       20000;
       30000;
       0;
       0];

elseif question==1

    A=[3,0,0,0,0,2.5,0,0,0,0,0;
        2,0,0,1.5,1.5,2,0,0,0,0,0;
        0,1.5,0,0,0,0,0,0,0,0,0;
        0,0,1.5,0.5,0,0,0,0,0,0,0;
        0,0,0,0,2,0,0,0,0,0,1.5;
        0,0,0,0,0,0,3,0,0,1.5,0;
        0,0,0,0,0,0,0,1.5,0.5,0,0;
        0,0,0,0,0,0,0,1,-1,0,0;
        0,0,1,-1,0,0,0,0,0,0,0];

    u=[Inf;
        4000;
        12000;
        15000;
        Inf; %because no upper bound
        Inf;
        5500;
        Inf;
        Inf;
        0; %Do not produce velvet pants
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
        0;
        0];

    c=[-110,-210,-60.5,-53.5,-143.25,-155.25,-136,-66.25,-33.75,-22,-26.625];

    b=[45000;
       28000;
       9000;
       18000;
       30000;
       20000;
       30000;
       0;
       0];

elseif question==3

    A=[3,0,0,0,0,2.5,0,0,0,0,0,0;
       2,0,0,1.5,1.5,2,0,0,0,0,0,0;
       0,1.5,0,0,0,0,0,0,0,0,0,0;
       0,0,1.5,0.5,0,0,0,0,0,0,0,0;
       0,0,0,0,2,0,0,0,0,0,1.5,0;
       0,0,0,0,0,0,3,0,0,1.5,0,0;
       0,0,0,0,0,0,0,1.5,0.5,0,0,0;
       0,0,0,0,0,0,0,1,-1,0,0,0;
       0,0,1,-1,0,0,0,0,0,0,0,0];

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
        Inf;
        1]; %we added the last row as a 1 for u and l

    l=[4200;
        0;
        0;
        0;
        2800;
        3000;
        0;
        0;
        0;
        0;
        0;
        1];

    c=[-110,-210,-60.5,-53.5,-143.25,-155.25,-172,-66.25,-33.75,-40,-26.625, 240000];

    b=[45000;
       28000;
       9000;
       18000;
       30000;
       20000;
       30000;
       0;
       0];

elseif question==4

    A=[3,0,0,0,0,2.5,0,0,0,0,0;
        2,0,0,1.5,1.5,2,0,0,0,0,0;
        0,1.5,0,0,0,0,0,0,0,0,0;
        0,0,1.5,0.5,0,0,0,0,0,0,0;
        0,0,0,0,2,0,0,0,0,0,1.5;
        0,0,0,0,0,0,3,0,0,1.5,0;
        0,0,0,0,0,0,0,1.5,0.5,0,0;
        0,0,0,0,0,0,0,1,-1,0,0;
        0,0,1,-1,0,0,0,0,0,0,0];

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
        0;
        0];

    c=[-110,-210,-60.5,-53.5,-143.25,-75.25,-172,-66.25,-33.75,-40,-26.625];

    b=[45000;
       28000;
       9000;
       18000;
       30000;
       20000;
       30000;
       0;
       0];

elseif question==5

    A=[3,0,0,0,0,2.5,0,0,0,0,0;
        2,0,0,1.5,1.5,2,0,0,0,0,0;
        0,1.5,0,0,0,0,0,0,0,0,0;
        0,0,1.5,0.5,0,0,0,0,0,0,0;
        0,0,0,0,2,0,0,0,0,0,1.5;
        0,0,0,0,0,0,3,0,0,1.5,0;
        0,0,0,0,0,0,0,1.5,0.5,0,0;
        0,0,0,0,0,0,0,1,-1,0,0;
        0,0,1,-1,0,0,0,0,0,0,0];

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
        0;
        0];

    c=[-110,-210,-60.5,-53.5,-143.25,-155.25,-136,-66.25,-33.75,-22,-26.625];

    b=[45000;
       38000;
       9000;
       18000;
       30000;
       20000;
       30000;
       0;
       0];

elseif question==6

    A=[3,0,0,0,0,2.5,0,0,0,0,0;
        2,0,0,1.5,1.5,2,0,0,0,0,0;
        0,1.5,0,0,0,0,0,0,0,0,0;
        0,0,1.5,0.5,0,0,0,0,0,0,0;
        0,0,0,0,2,0,0,0,0,0,1.5;
        0,0,0,0,0,0,3,0,0,1.5,0;
        0,0,0,0,0,0,0,1.5,0.5,0,0;
        0,0,0,0,0,0,0,1,-1,0,0;
        0,0,1,-1,0,0,0,0,0,0,0];

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
        0;
        0];

    if salesLevel==0

        ax1=.85;
        bx1=.1;
        cx1=.05;

    elseif salesLevel==1

        ax1=.7;
        bx1=.2;
        cx1=.1;

    elseif salesLevel==2

        ax1=.35;
        bx1=.45;
        cx1=.2;

    elseif salesLevel==3

        ax1=.1;
        bx1=.3;
        cx1=.6;

    else

        error('salesLevel input is wrong')

    end

    %Adjustments for Velvet Pants and Velvet Shirts

    bx7=bx1-0.05; %Velvet Pants
    cx7=cx1+0.05;
    bx10=bx1-0.05; %Velvet Shirts
    cx10=cx1+0.05;

    c=[profitCalculator(ax1,bx1,cx1,300,190),
        profitCalculator(ax1,bx1,cx1,450,240),
        profitCalculator(ax1,bx1,cx1,180,119.5),
        profitCalculator(ax1,bx1,cx1,120,66.5),
        profitCalculator(ax1,bx1,cx1,270,126.75),
        profitCalculator(ax1,bx1,cx1,320,164.75),
        profitCalculator(ax1,bx7,cx7,350,214), %Velvet Pants
        profitCalculator(ax1,bx1,cx1,130,63.75),
        profitCalculator(ax1,bx1,cx1,75,41.25),
        profitCalculator(ax1,bx10,cx10,200,178), %Velvet Shirt
        profitCalculator(ax1,bx1,cx1,120,93.3750)
        ];

    b=[45000;
       28000;
       9000;
       18000;
       30000;
       20000;
       30000;
       0;
       0];

else

    error('Invalid input for question')

end

%%Running Algorithm

options = optimoptions('linprog','Algorithm',algorithm);

[x, fval, exitf, lag, output] = linprog(c, A, b, [] , [] , l, u, options);
