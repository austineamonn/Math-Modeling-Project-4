function [x, fval, exitf, lag, output]=LinearProgram(question,algorithm)

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

%%Set Up Linear Program

if nargin<2
    question=0; %set to 'base' algoritm
    algorithm='dual-simplex'; %set to dual simplex bc it's the default for linprog
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

    c=[profitCalculator(ax1,bx1,cx1,300,190),
        profitCalculator(ax2,bx2,cx2,450,240),
        profitCalculator(ax3,bx3,cx3,180,119.5),
        profitCalculator(ax4,bx4,cx4,120,66.5),
        profitCalculator(ax5,bx5,cx5,270,126.75),
        profitCalculator(ax6,bx6,cx6,320,164.75),
        profitCalculator(ax7,bx7,cx7,350,214),
        profitCalculator(ax8,bx8,cx8,130,63.75),
        profitCalculator(ax9,bx9,cx9,75,41.25),
        profitCalculator(ax10,bx10,cx10,200,178),
        profitCalculator(ax11,bx11,cx11,120,93.3750)
        ];

    %85,10,5 good
    %70,20,10 ok
    %35,45,20 bad
    %10,30,60 sad


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
