function [x, fval, exitf, lag, output]=LinearProgram(question,algorithm,salesLevel,velvet,priceIncrease,outlets,boundIncrease,outletPercentage,ax1,bx1,cx1)

%%Question

%0 - base algorithm
%1,2,3,4,5,6 - for each question in the problem
%note that question 2 is the base algorithm

%%Algorithm

%'dual-simplex-highs' (default)
%'dual-simplex-legacy'
%'interior-point'
%'interior-point-legacy'

%%SalesLevel

%SalesLevel==-1 no values given must fill in ax1,bx1 and cx1
%SalesLevel==0: 100,0,0 perfect (full sale) scenario
%SalesLevel==1: 85,10,5 great scenario
%SalesLevel==2: 70,20,10 good scenario
%SalesLevel==3: 35,45,20 ok scenario
%SalesLevel==4: 10,30,60 bad scenario

%%Velvet

%true = consider lower velvet relative sales
%false = keep velvet relative sales equal to other products

%%priceIncrease

%increase prices for silk garments by this percentage
%decrease upper bounds for silk garment production by this percentage

%%outlets

%true = Fashion Star uses outlets, all unsold products first go to outlets
%to be sold at 60% prices. If they are not sold there then they get thrown
%out.
%false = Fasion Star does not use outlets, all unsold products are thrown
%out.

%%boundIncrease

%increase lower bounds for silk blouse and silk camisole production by this amount

%%outletPercentage

%if outlets==false then take outletPercentage % from b and add that to a.
%The rest gets added to c.

%%ax1,bx1,cx1

%these inputs are non needed and will be filled in automatically if you
%select a salesLevel
%ax1 = amount of product sold at full price at main store
%bx1 = amount of product sold at 60% price at outlet store
%cx1 = amount of unsold product

%%Set Up Linear Program

%add in inputs in case inputs are not given
if nargin<9
    noSalesLevel=true; %no inputs for ax1,bx1, and cx1 are given
    if nargin<8
        outletPercentage=0.5; %assume half of outlets end up sold at full price
        if nargin<7
            boundIncrease=0; %don't increase bound
            if nargin<6
                outlets=true; %assume using outlets
                if nargin<5
                    priceIncrease=0; %do not increase prices
                    if nargin<4
                        velvet=false; %keep velvet equal to the other products
                        if nargin<3
                            salesLevel=0; %use best case scenario levels
                            if nargin<2
                                algorithm='dual-simplex'; %set to dual simplex bc it's the default for linprog
                                if nargin<1
                                    question=0; %set to 'base' algorithm
                                end
                            end
                        end
                    end
                end
            end
        end
    end
else
    noSalesLevel=false; %inputs for ax1,bx1, and cx1 are given
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
        0+boundIncrease;
        0+boundIncrease;
        2800;
        3000;
        0;
        0;
        0;
        0;
        0];

    if salesLevel==0

        if ~outlets

            ax1=1;
            bx1=0;
            cx1=0;

        elseif outlets

            ax1=1;
            bx1=0;
            cx1=0;

        else

            error('invalid outlet input')

        end

    elseif salesLevel==1

        if ~outlets

            ax1=.85;
            bx1=0;
            cx1=.15;

        elseif outlets

            ax1=.85;
            bx1=.1;
            cx1=.05;

        else

            error('invalid outlet input')

        end

    elseif salesLevel==2

        if ~outlets

            ax1=.7;
            bx1=0;
            cx1=.3;

        elseif outlets

            ax1=.7;
            bx1=.2;
            cx1=.1;

        else

            error('invalid outlet input')

        end

    elseif salesLevel==3

        if ~outlets

            ax1=.35;
            bx1=0;
            cx1=.65;

        elseif outlets

            ax1=.35;
            bx1=.45;
            cx1=.2;

        else

            error('invalid outlet input')

        end

    elseif salesLevel==4

        if ~outlets

            ax1=.1;
            bx1=0;
            cx1=.9;

        elseif outlets

            ax1=.1;
            bx1=.3;
            cx1=.6;

        else

            error('invalid outlet input')

        end

    else

        error('salesLevel input is wrong')

    end

    %Adjustments for Velvet Pants and Velvet Shirts

    if velvet
        bx7=bx1-0.05; %Velvet Pants
        cx7=cx1+0.05;
        bx10=bx1-0.05; %Velvet Shirts
        cx10=cx1+0.05;
    elseif ~velvet
        bx7=bx1; %Velvet Pants
        cx7=cx1;
        bx10=bx1; %Velvet Shirts
        cx10=cx1;
    else
        error('velvet input is wrong')
    end

    c=[profitCalculator(ax1,bx1,cx1,300,190,0),
        profitCalculator(ax1,bx1,cx1,450,240,0),
        profitCalculator(ax1,bx1,cx1,180,119.5,priceIncrease), %
        profitCalculator(ax1,bx1,cx1,120,66.5,priceIncrease),%
        profitCalculator(ax1,bx1,cx1,270,126.75,0),
        profitCalculator(ax1,bx1,cx1,320,164.75,0),
        profitCalculator(ax1,bx7,cx7,350,214,0), %Velvet Pants
        profitCalculator(ax1,bx1,cx1,130,63.75,0),
        profitCalculator(ax1,bx1,cx1,75,41.25,0),
        profitCalculator(ax1,bx10,cx10,200,178,0), %Velvet Shirt
        profitCalculator(ax1,bx1,cx1,120,93.3750,0)
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
        0+boundIncrease;
        0+boundIncrease;
        2800;
        3000;
        0;
        0;
        0;
        0;
        0];

    if salesLevel==0

        if ~outlets

            ax1=1;
            bx1=0;
            cx1=0;

        elseif outlets

            ax1=1;
            bx1=0;
            cx1=0;

        else

            error('invalid outlet input')

        end

    elseif salesLevel==1

        if ~outlets

            ax1=.85;
            bx1=0;
            cx1=.15;

        elseif outlets

            ax1=.85;
            bx1=.1;
            cx1=.05;

        else

            error('invalid outlet input')

        end

    elseif salesLevel==2

        if ~outlets

            ax1=.7;
            bx1=0;
            cx1=.3;

        elseif outlets

            ax1=.7;
            bx1=.2;
            cx1=.1;

        else

            error('invalid outlet input')

        end

    elseif salesLevel==3

        if ~outlets

            ax1=.35;
            bx1=0;
            cx1=.65;

        elseif outlets

            ax1=.35;
            bx1=.45;
            cx1=.2;

        else

            error('invalid outlet input')

        end

    elseif salesLevel==4

        if ~outlets

            ax1=.1;
            bx1=0;
            cx1=.9;

        elseif outlets

            ax1=.1;
            bx1=.3;
            cx1=.6;

        else

            error('invalid outlet input')

        end

    else

        error('salesLevel input is wrong')

    end

    %Adjustments for Velvet Pants and Velvet Shirts

    if velvet
        bx7=bx1-0.05; %Velvet Pants
        cx7=cx1+0.05;
        bx10=bx1-0.05; %Velvet Shirts
        cx10=cx1+0.05;
    elseif ~velvet
        bx7=bx1; %Velvet Pants
        cx7=cx1;
        bx10=bx1; %Velvet Shirts
        cx10=cx1;
    else
        error('velvet input is wrong')
    end

    c=[profitCalculator(ax1,bx1,cx1,300,190,0),
        profitCalculator(ax1,bx1,cx1,450,240,0),
        profitCalculator(ax1,bx1,cx1,180,119.5,priceIncrease), %
        profitCalculator(ax1,bx1,cx1,120,66.5,priceIncrease),%
        profitCalculator(ax1,bx1,cx1,270,126.75,0),
        profitCalculator(ax1,bx1,cx1,320,164.75,0),
        profitCalculator(ax1,bx7,cx7,350,214,0), %Velvet Pants
        profitCalculator(ax1,bx1,cx1,130,63.75,0),
        profitCalculator(ax1,bx1,cx1,75,41.25,0),
        profitCalculator(ax1,bx10,cx10,200,178,0), %Velvet Shirt
        profitCalculator(ax1,bx1,cx1,120,93.3750,0)
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
        0+boundIncrease;
        0+boundIncrease;
        2800;
        3000;
        0;
        0;
        0;
        0;
        0;
        1];

    if salesLevel==0

        if ~outlets

            ax1=1;
            bx1=0;
            cx1=0;

        elseif outlets

            ax1=1;
            bx1=0;
            cx1=0;

        else

            error('invalid outlet input')

        end

    elseif salesLevel==1

        if ~outlets

            ax1=.85;
            bx1=0;
            cx1=.15;

        elseif outlets

            ax1=.85;
            bx1=.1;
            cx1=.05;

        else

            error('invalid outlet input')

        end

    elseif salesLevel==2

        if ~outlets

            ax1=.7;
            bx1=0;
            cx1=.3;

        elseif outlets

            ax1=.7;
            bx1=.2;
            cx1=.1;

        else

            error('invalid outlet input')

        end

    elseif salesLevel==3

        if ~outlets

            ax1=.35;
            bx1=0;
            cx1=.65;

        elseif outlets

            ax1=.35;
            bx1=.45;
            cx1=.2;

        else

            error('invalid outlet input')

        end

    elseif salesLevel==4

        if ~outlets

            ax1=.1;
            bx1=0;
            cx1=.9;

        elseif outlets

            ax1=.1;
            bx1=.3;
            cx1=.6;

        else

            error('invalid outlet input')

        end

    else

        error('salesLevel input is wrong')

    end

    %Adjustments for Velvet Pants and Velvet Shirts

    if velvet
        bx7=bx1-0.05; %Velvet Pants
        cx7=cx1+0.05;
        bx10=bx1-0.05; %Velvet Shirts
        cx10=cx1+0.05;
    elseif ~velvet
        bx7=bx1; %Velvet Pants
        cx7=cx1;
        bx10=bx1; %Velvet Shirts
        cx10=cx1;
    else
        error('velvet input is wrong')
    end

    c=[profitCalculator(ax1,bx1,cx1,300,190,0),
        profitCalculator(ax1,bx1,cx1,450,240,0),
        profitCalculator(ax1,bx1,cx1,180,119.5,priceIncrease), %
        profitCalculator(ax1,bx1,cx1,120,66.5,priceIncrease),%
        profitCalculator(ax1,bx1,cx1,270,126.75,0),
        profitCalculator(ax1,bx1,cx1,320,164.75,0),
        profitCalculator(ax1,bx7,cx7,350,178,0), %Velvet Pants
        profitCalculator(ax1,bx1,cx1,130,63.75,0),
        profitCalculator(ax1,bx1,cx1,75,41.25,0),
        profitCalculator(ax1,bx10,cx10,200,160,0), %Velvet Shirt
        profitCalculator(ax1,bx1,cx1,120,93.3750,0),
        240000 %full cost of fabric always since you cannot return any
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
        0+boundIncrease;
        0+boundIncrease;
        2800;
        3000;
        0;
        0;
        0;
        0;
        0];

    if salesLevel==0

        if ~outlets

            ax1=1;
            bx1=0;
            cx1=0;

        elseif outlets

            ax1=1;
            bx1=0;
            cx1=0;

        else

            error('invalid outlet input')

        end

    elseif salesLevel==1

        if ~outlets

            ax1=.85;
            bx1=0;
            cx1=.15;

        elseif outlets

            ax1=.85;
            bx1=.1;
            cx1=.05;

        else

            error('invalid outlet input')

        end

    elseif salesLevel==2

        if ~outlets

            ax1=.7;
            bx1=0;
            cx1=.3;

        elseif outlets

            ax1=.7;
            bx1=.2;
            cx1=.1;

        else

            error('invalid outlet input')

        end

    elseif salesLevel==3

        if ~outlets

            ax1=.35;
            bx1=0;
            cx1=.65;

        elseif outlets

            ax1=.35;
            bx1=.45;
            cx1=.2;

        else

            error('invalid outlet input')

        end

    elseif salesLevel==4

        if ~outlets

            ax1=.1;
            bx1=0;
            cx1=.9;

        elseif outlets

            ax1=.1;
            bx1=.3;
            cx1=.6;

        else

            error('invalid outlet input')

        end

    else

        error('salesLevel input is wrong')

    end

    %Adjustments for Velvet Pants and Velvet Shirts

    if velvet
        bx7=bx1-0.05; %Velvet Pants
        cx7=cx1+0.05;
        bx10=bx1-0.05; %Velvet Shirts
        cx10=cx1+0.05;
    elseif ~velvet
        bx7=bx1; %Velvet Pants
        cx7=cx1;
        bx10=bx1; %Velvet Shirts
        cx10=cx1;
    else
        error('velvet input is wrong')
    end

    c=[profitCalculator(ax1,bx1,cx1,300,190,0),
        profitCalculator(ax1,bx1,cx1,450,240,0),
        profitCalculator(ax1,bx1,cx1,180,119.5,priceIncrease), %
        profitCalculator(ax1,bx1,cx1,120,66.5,priceIncrease),%
        profitCalculator(ax1,bx1,cx1,270,126.75,0),
        profitCalculator(ax1,bx1,cx1,320,244.75,0),
        profitCalculator(ax1,bx7,cx7,350,214,0), %Velvet Pants
        profitCalculator(ax1,bx1,cx1,130,63.75,0),
        profitCalculator(ax1,bx1,cx1,75,41.25,0),
        profitCalculator(ax1,bx10,cx10,200,178,0), %Velvet Shirt
        profitCalculator(ax1,bx1,cx1,120,93.3750,0)
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
        0+boundIncrease;
        0+boundIncrease;
        2800;
        3000;
        0;
        0;
        0;
        0;
        0];

    if salesLevel==0

        if ~outlets

            ax1=1;
            bx1=0;
            cx1=0;

        elseif outlets

            ax1=1;
            bx1=0;
            cx1=0;

        else

            error('invalid outlet input')

        end

    elseif salesLevel==1

        if ~outlets

            ax1=.85;
            bx1=0;
            cx1=.15;

        elseif outlets

            ax1=.85;
            bx1=.1;
            cx1=.05;

        else

            error('invalid outlet input')

        end

    elseif salesLevel==2

        if ~outlets

            ax1=.7;
            bx1=0;
            cx1=.3;

        elseif outlets

            ax1=.7;
            bx1=.2;
            cx1=.1;

        else

            error('invalid outlet input')

        end

    elseif salesLevel==3

        if ~outlets

            ax1=.35;
            bx1=0;
            cx1=.65;

        elseif outlets

            ax1=.35;
            bx1=.45;
            cx1=.2;

        else

            error('invalid outlet input')

        end

    elseif salesLevel==4

        if ~outlets

            ax1=.15;
            bx1=0;
            cx1=.85;

        elseif outlets

            ax1=.1;
            bx1=.3;
            cx1=.6;

        else

            error('invalid outlet input')

        end

    else

        error('salesLevel input is wrong')

    end

    %Adjustments for Velvet Pants and Velvet Shirts

    if velvet
        bx7=bx1-0.05; %Velvet Pants
        cx7=cx1+0.05;
        bx10=bx1-0.05; %Velvet Shirts
        cx10=cx1+0.05;
    elseif ~velvet
        bx7=bx1; %Velvet Pants
        cx7=cx1;
        bx10=bx1; %Velvet Shirts
        cx10=cx1;
    else
        error('velvet input is wrong')
    end

    c=[profitCalculator(ax1,bx1,cx1,300,190,0),
        profitCalculator(ax1,bx1,cx1,450,240,0),
        profitCalculator(ax1,bx1,cx1,180,119.5,priceIncrease), %
        profitCalculator(ax1,bx1,cx1,120,66.5,priceIncrease),%
        profitCalculator(ax1,bx1,cx1,270,126.75,0),
        profitCalculator(ax1,bx1,cx1,320,164.75,0),
        profitCalculator(ax1,bx7,cx7,350,214,0), %Velvet Pants
        profitCalculator(ax1,bx1,cx1,130,63.75,0),
        profitCalculator(ax1,bx1,cx1,75,41.25,0),
        profitCalculator(ax1,bx10,cx10,200,178,0), %Velvet Shirt
        profitCalculator(ax1,bx1,cx1,120,93.3750,0)
        ];

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
        12000*(1-priceIncrease);
        15000*(1-priceIncrease);
        Inf; %because no upper bound
        Inf;
        5500;
        Inf;
        Inf;
        6000;
        Inf];

    l=[4200;
        0;
        0+boundIncrease;
        0+boundIncrease;
        2800;
        3000;
        0;
        200; %increase so some get produced
        0;
        0;
        0];

    if salesLevel==-1

        %use ax1,bx1,cx1 that were assigned

        if ~outlets

            ax1=ax1+(bx1*outletPercentage);
            bx1=0;
            cx1=1-ax1;

        end

        if noSalesLevel

            error('You did not input ax1, bx1 or cx1. Use a different salesLevel or input these values.')

        end

    elseif salesLevel==0

        ax1=1; %there is no no outlet scenario since all products are assumed to be sold at full price
        bx1=0;
        cx1=0;

    elseif salesLevel==1

        ax1=.85;
        bx1=.1;
        cx1=.05;

        if ~outlets

            ax1=ax1+(bx1*outletPercentage);
            bx1=0;
            cx1=1-ax1;

        end

    elseif salesLevel==2

        ax1=.7;
        bx1=.2;
        cx1=.1;

        if ~outlets

            ax1=ax1+(bx1*outletPercentage);
            bx1=0;
            cx1=1-ax1;

        end

    elseif salesLevel==3

        ax1=.35;
        bx1=.45;
        cx1=.2;

        if ~outlets

            ax1=ax1+(bx1*outletPercentage);
            bx1=0;
            cx1=1-ax1;

        end

    elseif salesLevel==4

        ax1=.1;
        bx1=.3;
        cx1=.6;

        if ~outlets

            ax1=ax1+(bx1*outletPercentage);
            bx1=0;
            cx1=1-ax1;

        end

    else

        error('salesLevel input is wrong')

    end

    %Adjustments for Velvet Pants and Velvet Shirts

    if velvet
        bx7=bx1-0.05; %Velvet Pants
        cx7=cx1+0.05;
        bx10=bx1-0.05; %Velvet Shirts
        cx10=cx1+0.05;
    elseif ~velvet
        bx7=bx1; %Velvet Pants
        cx7=cx1;
        bx10=bx1; %Velvet Shirts
        cx10=cx1;
    else
        error('velvet input is wrong')
    end

    c=[profitCalculator(ax1,bx1,cx1,300,190,0),
        profitCalculator(ax1,bx1,cx1,450,240,0),
        profitCalculator(ax1,bx1,cx1,180,119.5,priceIncrease), 
        profitCalculator(ax1,bx1,cx1,120,66.5,priceIncrease),
        profitCalculator(ax1,bx1,cx1,270,126.75,0),
        profitCalculator(ax1,bx1,cx1,320,164.75,0),
        profitCalculator(ax1,bx7,cx7,350,214,0), %Velvet Pants
        profitCalculator(ax1,bx1,cx1,130,63.75,0),
        profitCalculator(ax1,bx1,cx1,75,41.25,0),
        profitCalculator(ax1,bx10,cx10,200,178,0), %Velvet Shirt
        profitCalculator(ax1,bx1,cx1,120,93.3750,0)
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
