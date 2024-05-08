function fashionLoop(loop,salesLevel,velvet,outlets, gnumb)
    
    switch nargin
        case 1
            salesLevel = 0;
    end 

% loop price increase
% loop velvet demand
% loop differnet scenarios: great, good, okay, bad

% loop = 0: no loop
% loop = 1: loop over price increase
% loop = 2: loop over lower bound for x3 and x4
% loop = 3: make outlet true and loop over how the precnese of outlets
% reflects the decreased demand in a.
% loop = 4: loop over outlet price (how much more sold in a results from no
% outlets)
% loop = 5: loop over profit increase for velvet shirts for question 1
% loop = 6: loop over material supply gnumb: (1-7)
% loop = 7: loop over increased, gnumn (1-11)


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

    b=[45000;
       28000;
       9000;
       18000;
       30000;
       20000;
       30000;
       0;
       0];


%%Running Algorithm

options = optimoptions('linprog','Algorithm','dual-simplex');

    if loop == 0

        [x, fval, exitf, lag, output] = linprog(c, A, b, [] , [] , l, u, options);
   
    elseif loop==1
        priceIncvec = linspace(-.5,0.9,100);
        profitVec = zeros(1,length(priceIncvec));
            for i=1:length(priceIncvec)

               u=[Inf;
                  4000;
                  12000*(1-priceIncvec(i));
                  15000*(1-priceIncvec(i));
                  20000; %because no upper bound
                  20000;
                  5500;
                  20000;
                  20000;
                  6000;
                  20000];

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
              profitVec(i) = -1*fval - 2060000;

            end

               figure;
                 hold on
                  plot(priceIncvec, profitVec, 'LineWidth', 3.0, 'Color', [0.6 0 1])
                


         elseif loop == 2
             lowerBoundVec = linspace(0,6000,100);
             ProfitVec = zeros(1,length(lowerBoundVec));

                for i=1:length(lowerBoundVec)

                    l=[4200;
                       0;
                       lowerBoundVec(i);
                       lowerBoundVec(i);
                       2800;
                       3000;
                       0;
                       200; %instead of 0
                       0;
                       0;
                       0];

              [~, fval] = linprog(c, A, b, [] , [] , l, u, options);
              ProfitVec(i) = -1*fval - 2060000;

                end 
                    figure;
                    hold on
                    plot(lowerBoundVec, ProfitVec, 'LineStyle','-')

    elseif loop == 3
            if salesLevel == 0
                salesLevel = 1;
            end 

      if salesLevel==1
            ax1=[.85, .83, .78, .75];
            bx1=.1;
            cx1=[.05, .07, .1, .12, .15];

    elseif salesLevel==2

            ax1=[.7,.68,.65,.62,.6];
            bx1=.2;
            cx1=[.1,.12,.15,.18,.2];

    elseif salesLevel==3

            ax1=[.35, .33, .3, .27, .25];
            bx1=.45;
            cx1=[.2, .22, .25, .28, .3];

    elseif salesLevel==4
            ax1=[.1, .08, .06, .04, .02];
            bx1=.3;
            cx1=[.6, .62, .64, .66, .68];

      end
      ProfitVec = zeros(1,length(ax1));
        for i=1:length(ax1)
            if velvet
                bx7=bx1-0.05; %Velvet Pants
                cx7=cx1(i)+0.05;
                bx10=bx1-0.05; %Velvet Shirts
                cx10=cx1(i)+0.05;
            elseif ~velvet
                bx7=bx1; %Velvet Pants
                cx7=cx1(i);
                bx10=bx1; %Velvet Shirts
                cx10=cx1(i);
            else
                error('velvet input is wrong')
            end

            c=[profitCalculator(ax1(i),bx1,cx1(i),300,190,0),
                profitCalculator(ax1(i),bx1,cx1(i),450,240,0),
                profitCalculator(ax1(i),bx1,cx1(i),180,119.5,0), %
                profitCalculator(ax1(i),bx1,cx1(i),120,66.5,0),%
                profitCalculator(ax1(i),bx1,cx1(i),270,126.75,0),
                profitCalculator(ax1(i),bx1,cx1(i),320,164.75,0),
                profitCalculator(ax1(i),bx7,cx7,350,214,0), %Velvet Pants
                profitCalculator(ax1(i),bx1,cx1(i),130,63.75,0),
                profitCalculator(ax1(i),bx1,cx1(i),75,41.25,0),
                profitCalculator(ax1(i),bx10,cx10,200,178,0), %Velvet Shirt
                profitCalculator(ax1(i),bx1,cx1(i),120,93.3750,0)];

              [~, fval] = linprog(c, A, b, [] , [] , l, u, options);
              ProfitVec(i) = -1*fval - 2060000;
        end
            figure;
            hold on
            plot(ax1, ProfitVec, 'LineWidth', 3.0, 'Color', [0.6 0 1]);
            xlabel('Proportion of garments being sold by Fashion Star');
                    ylabel('Profit');
                    title('Effects of Outlets on Fashion Star Sales');


        elseif loop == 4
            outletPriceVec = linspace(0,.75, 100);
            ProfitVec = zeros(1, length(outletPriceVec));

            for i=1:length(outletPriceVec)

                if salesLevel==1
                    ax1=.85+(0.1*outletPriceVec(i));
                    bx1=0;
                    cx1=1-ax1;

                elseif salesLevel==2
                    ax1=.7+(0.2*outletPriceVec(i));
                    bx1=0;
                    cx1=1-ax1;

                elseif salesLevel==3
                    ax1=0.35+(0.45*outletPriceVec(i));
                    bx1=0;
                    cx1=1-ax1;


                elseif salesLevel==4
                    ax1=0.1+(0.3*outletPriceVec(i));
                    bx1=0;
                    cx1=1-ax1;

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

            c = [profitCalculator(ax1,bx1,cx1,300,190,0),
                profitCalculator(ax1,bx1,cx1,450,240,0),
                profitCalculator(ax1,bx1,cx1,180,119.5,0), 
                profitCalculator(ax1,bx1,cx1,120,66.5,0),
                profitCalculator(ax1,bx1,cx1,270,126.75,0),
                profitCalculator(ax1,bx1,cx1,320,164.75,0),
                profitCalculator(ax1,bx7,cx7,350,214,0), %Velvet Pants
                profitCalculator(ax1,bx1,cx1,130,63.75,0),
                profitCalculator(ax1,bx1,cx1,75,41.25,0),
                profitCalculator(ax1,bx10,cx10,200,178,0), %Velvet Shirt
                profitCalculator(ax1,bx1,cx1,120,93.3750,0)];

            [~, fval] = linprog(c, A, b, [] , [] , l, u, options);
             ProfitVec(i) = -1*fval - 2060000;
            end 
            outletPriceVec
            ProfitVec
            figure;
            hold on
            plot(outletPriceVec, ProfitVec, 'LineWidth', 3.0, 'Color', [0.6 0 1]);
            xlabel('Outlet Percentage');
                    ylabel('Profit');
                    title('Effects of Removing Outlets on Fashion Star Sales');

        elseif loop == 5      

            priceIncreaseVec = linspace(0,.95, 100);
            ProfitVec = zeros(1,length(priceIncreaseVec));
                for i=1:length(priceIncreaseVec)

                     c=[profitCalculator(ax1,bx1,cx1,300,190,0),
                        profitCalculator(ax1,bx1,cx1,450,240,0),
                        profitCalculator(ax1,bx1,cx1,180,119.5,0), %
                        profitCalculator(ax1,bx1,cx1,120,66.5,0),%
                        profitCalculator(ax1,bx1,cx1,270,126.75,0),
                        profitCalculator(ax1,bx1,cx1,320,164.75,0),
                        profitCalculator(ax1,bx7,cx7,350,214,0), %Velvet Pants
                        profitCalculator(ax1,bx1,cx1,130,63.75,0),
                        profitCalculator(ax1,bx1,cx1,75,41.25,0),
                        profitCalculator(ax1,bx10,cx10,200,178,priceIncreaseVec(i)), %Velvet Shirt -- increase price for velvet only
                        profitCalculator(ax1,bx1,cx1,120,93.3750,0)
                        ];

                     u=[20000;
                        4000;
                        12000;
                        15000;
                        20000; %because no upper bound
                        20000;
                        5500;
                        20000;
                        20000;
                        6000*(1-priceIncreaseVec(i)); %Do not produce velvet pants
                        20000];

                     [~, fval] = linprog(c, A, b, [] , [] , l, u, options);
                       ProfitVec(i) = -1*fval - 2060000;
                end
               figure;
                hold on
                plot(priceIncreaseVec, ProfitVec, 'LineStyle', '-', 'Color', [0.6 0 1]); % Bright purple
                xlabel('Velvet shirt price increase');
                ylabel('Profit');
                title('Total Profits from Changing Velvet Shirt prices');

             
        elseif loop == 6
            matVec = linspace(.75*b(gnumb), 3.2*b(gnumb), 250);
            ProfitVec = zeros(1,length(matVec));
            ogMat = b(gnumb);

                for i=1:length(matVec)
                    b(gnumb) = matVec(i);
                    [~, fval] = linprog(c, A, b, [] , [] , l, u, options);
                    ProfitVec(i) = -1*fval - 2060000;
                end

                figure;
                hold on
                plot(matVec, ProfitVec, 'LineWidth', 3.0, 'Color', [0.6 0 1]); % Bright purple
                xline(ogMat, 'LineStyle', '--', 'Color', [0.6 0 1])
                xlabel('Acetate Supply');
                ylabel('Profit');
                title('Total Profits from Changing Acetate Supply');

        elseif loop == 7
                currentCost = -1*c(8);
                matVec = linspace(.75*-1*currentCost, 1.5*-1*currentCost, 250);
               
                currentCost2 = -1*c(9);
                matVec2 = linspace(.75*-1*currentCost2, 1.5*-1*currentCost2, 250);

               % currentCost3 = -1*c(6);
               % matVec3 = linspace(.75*-1*currentCost3, 1.5*-1*currentCost3, 250);

               % currentCost4 = -1*c(5);
               % matVec4 = linspace(.75*-1*currentCost4, 1.5*-1*currentCost4, 250);

                ProfitVec = zeros(1,length(matVec));

                    for i=1:length(matVec)
                  %  c(7) = profitCalculator(ax1,bx7,cx7,350,matVec(i),0);
                  %  c(1) =  profitCalculator(ax1,bx1,cx1,300,matVec2(i),0);
                  %  c(6) = profitCalculator(ax1,bx1,cx1,320,matVec3(i),0);
                  %  c(5) = profitCalculator(ax1,bx1,cx1,270,matVec(i),0);
                 %  c(2) = profitCalculator(ax1,bx1,cx1,450,matVec(i),0);
                % c(3) = profitCalculator(ax1,bx1,cx1,180,matVec(i),0);
                 %c(4) = profitCalculator(ax1,bx1,cx1,120,matVec2(i),0);
                % c(11) = profitCalculator(ax1,bx1,cx1,120,matVec2(i),0);
                c(8) = profitCalculator(ax1,bx1,cx1,130,matVec(i),0);
                c(9) = profitCalculator(ax1,bx1,cx1,75,matVec2(i),0);


                    [~, fval] = linprog(c, A, b, [] , [] , l, u, options);
                    ProfitVec(i) = -1*fval - 2060000;
                    end
                    % Calculate the slope
                    delta_profit = ProfitVec(end) - ProfitVec(1);
                    delta_expenses = 150 - 75;
                    slope = -(delta_profit / delta_expenses);

                  

                % Plot the graph
                figure;
                hold on;
                plot(linspace(75, 150, 250), flip(ProfitVec), 'LineWidth', 3.0, 'Color', [0.6 0 1]); % Bright purple
                xlabel('Percent of Standard Cotton Expenses');
                ylabel('Profit');
                title('Total Profits from Changing Cotton Expenses');


        slope_text = ['Slope: ', num2str(slope)];
            text(150, ProfitVec(end), slope_text, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontSize', 18);
            hold off;

     

   


    end 

end


function [ans]=profitCalculator(a,b,c,price,costs,priceIncrease)

    ans=-(price*(1+priceIncrease)*(a+0.6*b+0*c)-costs);
end
