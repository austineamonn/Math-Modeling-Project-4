function [x, fval] = fashionStarModelOutletPercentage(salesLevel, outlets)

% question 0: optimal sales level with no changes (outlets true or false)
% question 1: increase velvet sales price
% question 2: No velvet returns, price increase of shirt option
% question 3: Wool blazer cost increase, price increase option
% question 4: acetate supply increase

%material: The place in the matrix for each material
%ex: Acetate Material == 2

if nargin<7
    ax1=.97; %fills in for salesLevel 1
    if nargin<6
        supply=38000; %fills in for exact supply from question 4
        if nargin<5
            material=2; %fills in for Wool Material
        end
    end
end
options = optimoptions('linprog','Algorithm','dual-simplex');


A = [3,0,0,0,0,2.5,0,0,0,0,0;  % Wool
    2,0,0,0,1.5,1.5,2,0,0,0,0; % Acetate
    0,1.5,0,0,0,0,0,0,0,0,0;   % Cashmere
    0,0,1.5,0.5,0,0,0,0,0,0,0; % Silk
    0,0,0,0,2,0,0,0,0,0,1.5;   % Rayon  
    0,0,0,0,0,0,3,0,0,1.5,0;   % Velvet
    0,0,0,0,0,0,0,1.5,0.5,0,0; % Cotton
    0,0,0,0,0,0,0,1,-1,0,0;    % Cotton scrap
    0,0,1,-1,0,0,0,0,0,0,0];   % Silk scrap

u = [7000; % Wool slacks --> 7,000 demand
     4000;   % Cashmere Sweater
     12000;  % Silk blouse
     15000;  % Silk camisole
     20000;  % Tailored skirt
     5000;  % Wool blazer  --> 5000 demand
     5500;   % Velvet pants
     20000;  % Cotton sweater
     20000;  % Cotton miniskirt
     6000;   % Velvet shirt
     20000]; % Button-down blouse
        
l = [4200;
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

    


b = [45000; % Wool ... material == 1
     28000; % Acetate ... material == 2
     9000;  % Cashmere ... material == 3
     18000; % Silk ... material == 4
     30000; % Rayon ... material == 5
     20000; % Velvet ... material == 6
     30000; % Cotton ... material == 7
     0; %scrap constraints
     0];

    
    outletVec = linspace (.1, 1, 100);
    profitVec = zeros(1, 100);

        for i=1:100

              if salesLevel==1
                        ax1=.95*.85;
                        bx1=(5/6)*(1-ax1) + (.95 * .15 * outletVec(i));
                        cx1=1-bx1-ax1;
                elseif salesLevel==2
                        ax1=.89 *.85;
                        bx1=(5/6)*(1-ax1) + (.89*.15 * outletVec(i));
                        cx1=1-bx1-ax1;
              end      

               c = [profitCalculator(ax1,bx1,cx1,300,190,0),      ... Wool slacks
                 profitCalculator(ax1,bx1,cx1,450,240,0),      ... Cashmere sweater
                 profitCalculator(ax1,bx1,cx1,180,119.5,0),    ... Silk blouse
                 profitCalculator(ax1,bx1,cx1,120,66.5,0),     ... Silk camisole
                 profitCalculator(ax1,bx1,cx1,270,126.75,0),   ... Tailored skirt
                 profitCalculator(ax1,bx1,cx1,320,164.75,0),   ... Wool blazer
                 profitCalculator(ax1,bx1,cx1,350,214,0),      ... Velvet Pants
                 profitCalculator(ax1,bx1,cx1,130,63.75,0),    ... Cotton sweater
                 profitCalculator(ax1,bx1,cx1,75,41.25,0),     ... Cotton miniskirt
                 profitCalculator(ax1,bx1,cx1,200,178,0),      ... Velvet Shirt
                 profitCalculator(ax1,bx1,cx1,120,93.3750,0)]; ... Button-down blouse

               [~, fval] = linprog(c, A, b, [] , [] , l, u, options);
                 profitVec(i) = (-1*fval) - 860000 - (3*1200000);
        end

       figure; % Creates a new figure window
hold on; % Allows multiple plots on the same graph

% Plotting profits against percentage of standard cotton expenses
plot(outletVec, profitVec, 'LineWidth', 3.0, 'Color', [0.6 0 1]); % Bright purple

% Adding a horizontal line representing constant profit without outlets
constantProfit = 1164200;
line([min(outletVec), max(outletVec)], [constantProfit, constantProfit], 'LineWidth', 2, 'LineStyle', '--', 'Color', 'r');

% Labeling the axes
xlabel('Outlet Percentage');
ylabel('Profit');

% Adding a title to the plot
title('Total Profits from Changing Outlet Percentage');

% Adding a legend
legend('Profits with Outlets', 'Constant Profit without Outlets');



end

function [ans1]=profitCalculator(a,b,c,price,costs,priceIncrease)
    ans1=-(price*(1+priceIncrease)*(a+0.6*b+0*c)-costs);
end