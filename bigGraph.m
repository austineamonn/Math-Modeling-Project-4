function bigGraph(salesLevel,velvet,outlets)

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
        20000; %because no upper bound
        20000;
        5500;
        20000;
        20000;
        6000;
        20000];

    l=[4200;
        0;
        0;
        0;
        2800;
        3000;
        0;
        0; %increase so some get produced
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
        profitCalculator(ax1,bx1,cx1,180,119.5,0), %
        profitCalculator(ax1,bx1,cx1,120,66.5,0),%
        profitCalculator(ax1,bx1,cx1,270,126.75,0),
        profitCalculator(ax1,bx1,cx1,320,164.75,0),
        profitCalculator(ax1,bx7,cx7,350,214,0), %Velvet Pants
        profitCalculator(ax1,bx1,cx1,130,63.75,0),
        profitCalculator(ax1,bx1,cx1,75,41.25,0),
        profitCalculator(ax1,bx10,cx10,200,178,0), %Velvet Shirt
        profitCalculator(ax1,bx1,cx1,120,93.3750,0)
        ];

    cOrg=[profitCalculator(ax1,bx1,cx1,300,190,0),
        profitCalculator(ax1,bx1,cx1,450,240,0),
        profitCalculator(ax1,bx1,cx1,180,119.5,0), %
        profitCalculator(ax1,bx1,cx1,120,66.5,0),%
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


options = optimoptions('linprog','Algorithm','dual-simplex');


    % Collecting wool data

    woolSlackCost = 190;
    CashmereSweaterCost = 240;
    silkBlouseCost = 119.5;
    silkCamiCost = 66.5;
    tailSkirtCost = 126.75;
    woolBlazerCost = 164.75;
    velvetPantsCost = 214;
    cottonSweaterCost = 63.75;
    cottonSkirtCost = 41.25;
    velvetShirtCost = 178;
    buttonBlouseCost = 93.3750;

    woolSlackVec = linspace(.75*woolSlackCost, 1.5*woolSlackCost, 100);
    CashmereSweaterVec = linspace(.75*CashmereSweaterCost, 1.5*CashmereSweaterCost, 100);
    silkBlouseVec = linspace(.75*silkBlouseCost, 1.5*silkBlouseCost, 100);
    silkCamiVec = linspace(.75*silkCamiCost, 1.5*silkCamiCost, 100);
    tailSkirtVec = linspace(.75*tailSkirtCost, 1.5*tailSkirtCost, 100);
    woolBlazerVec = linspace(.75*woolBlazerCost, 1.5*woolBlazerCost, 100);
    
    velvetPantVec = linspace(.75*velvetPantsCost, 1.5*velvetPantsCost, 100);
    cottonSweaterVec = linspace(.75*cottonSweaterCost, 1.5*cottonSweaterCost, 100);
    cottonSkirtVec = linspace(.75*cottonSkirtCost, 1.5*cottonSkirtCost, 100);
    velvetShirtVec = linspace(.75*velvetShirtCost, 1.5*velvetShirtCost, 100);
    buttonBlouseVec = linspace(.75*buttonBlouseCost, 1.5*buttonBlouseCost, 100);

    WoolProfitVec = zeros(1,100);
    acetateProfitVec = zeros(1,100);
    cashmereProfitVec = zeros(1,100);
    silkProfitVec = zeros(1,100);
    rayonProfitVec = zeros(1,100);
    velvetProfitVec = zeros(1,100);
    cottonProfitVec = zeros(1,100);

    % wool
        for i=1:100
            c(1) =  profitCalculator(ax1,bx1,cx1,300,woolSlackVec(i),0);
            c(6) = profitCalculator(ax1,bx1,cx1,320,woolBlazerVec(i),0);

            [~, fval1] = linprog(c, A, b, [] , [] , l, u, options);
            WoolProfitVec(i) = -1*fval1 - 2060000;
        end 
        c=cOrg;
    % acetate
        for i=1:100
            c(1) =  profitCalculator(ax1,bx1,cx1,300,woolSlackVec(i),0);
            c(5) = profitCalculator(ax1,bx1,cx1,320,tailSkirtVec(i),0);
            c(6) = profitCalculator(ax1,bx1,cx1,320,woolBlazerVec(i),0);
            c(7) = profitCalculator(ax1,bx1,cx1,320,velvetPantVec(i),0);

            [~, fval2] = linprog(c, A, b, [] , [] , l, u, options);
            acetateProfitVec(i) = -1*fval2 - 2060000;
        end
        c=cOrg;
     % cashmere
        for i=1:100
            c(2) =  profitCalculator(ax1,bx1,cx1,300,CashmereSweaterVec(i),0);

            [~, fval3] = linprog(c, A, b, [] , [] , l, u, options);
            cashmereProfitVec(i) = -1*fval3 - 2060000;
        end
        c=cOrg;
       
     % silk
        for i=1:100
            c(3) = profitCalculator(ax1,bx1,cx1,320,silkBlouseVec(i),0);
            c(4) = profitCalculator(ax1,bx1,cx1,320,silkCamiVec(i),0);

            [~, fval4] = linprog(c, A, b, [] , [] , l, u, options);
            silkProfitVec(i) = -1*fval4 - 2060000;
        end
       c=cOrg;
      % rayon
        for i=1:100
            c(5) = profitCalculator(ax1,bx1,cx1,320,tailSkirtVec(i),0);
            c(11) = profitCalculator(ax1,bx1,cx1,320,buttonBlouseVec(i),0);

            [~, fval5] = linprog(c, A, b, [] , [] , l, u, options);
            rayonProfitVec(i) = -1*fval5 - 2060000;
        end
        c=cOrg;
         % velvet
        for i=1:100
            c(7) = profitCalculator(ax1,bx1,cx1,320,velvetPantVec(i),0);
            c(10) = profitCalculator(ax1,bx1,cx1,320,velvetShirtVec(i),0);

            [~, fval6] = linprog(c, A, b, [] , [] , l, u, options);
            velvetProfitVec(i) = -1*fval6 - 2060000;
        end
        c=cOrg;
        % cotton
        for i=1:100
            c(8) = profitCalculator(ax1,bx1,cx1,320,cottonSweaterVec(i),0);
            c(9) = profitCalculator(ax1,bx1,cx1,320,cottonSkirtVec(i),0);

            [~, fval7] = linprog(c, A, b, [] , [] , l, u, options);
            cottonProfitVec(i) = -1*fval7 - 2060000;
        end
   
    
        xaxis = linspace (75, 150, 100);

        figure;
        hold on
        plot(xaxis, WoolProfitVec, 'LineWidth', 3.0);
        plot(xaxis, acetateProfitVec, 'LineWidth', 3.0);
        plot(xaxis, cashmereProfitVec, 'LineWidth', 3.0);
        plot(xaxis, silkProfitVec, 'LineWidth', 3.0);
        plot(xaxis, rayonProfitVec, 'LineWidth', 3.0);
        plot(xaxis, velvetProfitVec, 'LineWidth', 3.0);
        plot(xaxis, cottonProfitVec, 'LineWidth', 3.0);
        legend('Wool', 'Acetate', 'Cashmere', 'Silk', 'Rayon', 'Velvet', 'Cotton');


end 

function [ans]=profitCalculator(a,b,c,price,costs,priceIncrease)

    ans=-(price*(1+priceIncrease)*(a+0.6*b+0*c)-costs);
end
