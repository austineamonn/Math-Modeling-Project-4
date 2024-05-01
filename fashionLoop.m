function fashionLoop(loop,salesLevel)
    switch nargin
        case 1
            salesLevel = 0;
    end 

% loop price increase
% loop velvet demand
% loop differnet scenarios: great, good, okay, bad

% loop = 1: loop over price increase
% loop = 2: loop over velvet demand (not yet implemented)
% loop = 3: loop difference scenarios (a,b,c values) (not yet implemented). 

%sales level: 0,1,2,3

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

     b=[45000;
       28000;
       9000;
       18000;
       30000;
       20000;
       30000;
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

    options = optimoptions('linprog','Algorithm','dual-simplex');

    if loop == 0

        c=[profitCalculator(ax1,bx1,cx1,300,190,0),
            profitCalculator(ax1,bx1,cx1,450,240,0),
            profitCalculator(ax1,bx1,cx1,180,119.5,0),
            profitCalculator(ax1,bx1,cx1,120,66.5,0),
            profitCalculator(ax1,bx1,cx1,270,126.75,0),
            profitCalculator(ax1,bx1,cx1,320,164.75,0),
            profitCalculator(ax1,bx7,cx7,350,214,0), %Velvet Pants
            profitCalculator(ax1,bx1,cx1,130,63.75,0),
            profitCalculator(ax1,bx1,cx1,75,41.25,0),
            profitCalculator(ax1,bx10,cx10,200,178,0), %Velvet Shirt
            profitCalculator(ax1,bx1,cx1,120,93.3750,0)
            ];

        [x, fval, exitf, lag, output] = linprog(c, A, b, [] , [] , l, u, options);
   
    elseif loop==1
        priceIncvec = linspace(-.5,0.9,100);
        profitVec = zeros(1,length(priceIncvec));
            for i=1:length(priceIncvec)

               u=[Inf;
                  4000;
                  12000*(1-priceIncvec(i));
                  15000*(1-priceIncvec(i));
                  Inf; %because no upper bound
                  Inf;
                  5500;
                  Inf;
                  Inf;
                  6000;
                  Inf];

                 c=[profitCalculator(ax1,bx1,cx1,300,190,0),
                  profitCalculator(ax1,bx1,cx1,450,240,0),
                  profitCalculator(ax1,bx1,cx1,180,119.5,priceIncvec(i)),
                  profitCalculator(ax1,bx1,cx1,120,66.5,priceIncvec(i)),
                  profitCalculator(ax1,bx1,cx1,270,126.75,0),
                  profitCalculator(ax1,bx1,cx1,320,164.75,0),
                  profitCalculator(ax1,bx7,cx7,350,214,0), 
                  profitCalculator(ax1,bx1,cx1,130,63.75,0),
                  profitCalculator(ax1,bx1,cx1,75,41.25,0),
                  profitCalculator(ax1,bx10,cx10,200,178,0), 
                  profitCalculator(ax1,bx1,cx1,120,93.3750,0)];

              [~, fval] = linprog(c, A, b, [] , [] , l, u, options);
              profitVec(i) = -1*fval;

            end

               figure;
                 hold on
                  plot(priceIncvec, profitVec, 'LineStyle','-')

    end 

   


end 


function [ans]=profitCalculator(a,b,c,price,costs,priceIncrease)

    ans=-(price*(1+priceIncrease)*(a+0.6*b+0*c)-costs);
end