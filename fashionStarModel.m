function [x, fval] = fashionStarModel(question, salesLevel, outlets, priceIncrease)

% question 0: optimal sales level with no changes (outlets true or false)
% question 1: increase velvet sales price
% question 2: No velvet returns, price increase of shirt option
% question 3: Wool blazer cost increase, price increase option
% question 4: acetate supply increase

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

if salesLevel==0
    ax1=1;
    bx1=0;
    cx1=0;
elseif salesLevel==1
    if ~outlets
        ax1=.95;
        bx1=0;
        cx1=.05;
    elseif outlets
        ax1=.95;
        bx1=(5/6)*(1-ax1);
        cx1=1-bx1-ax1;
    end
elseif salesLevel==2
    if ~outlets
        ax1=.89;
        bx1=0;
        cx1=.11;
    elseif outlets
        ax1=.89;
        bx1=(5/6)*(1-ax1);
        cx1=1-bx1-ax1;
    end
  elseif salesLevel==3
        bx1=.33;
        cx1=.065;
        ax1= 1-bx1-cx1;
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

b = [45000; % Wool
     28000; % Acetate
     9000;  % Cashmere
     18000; % Silk
     30000; % Rayon
     20000; % Velvet
     30000; % Cotton
     0;
     0];

% Increase velvet shirt price
    if question == 1 

        c(10) = profitCalculator(ax1,bx1,cx1,200,178,priceIncrease); % Velvet Shirt
        u(10) = 6000*(1-priceIncrease);   % Velvet shirt
   

     % No velvet returns, price increase of shirt option
    elseif question == 2

        A(6,:) = [];
        b(6,:) = [];
        Aeq = [0,0,0,0,0,0,3,0,0,1.5,0];
        beq = 20000;     

      % Wool blazer cost increase, price increase option
    elseif question == 3
        c(6) =  profitCalculator(ax1,bx1,cx1,320,244.75,priceIncrease); % Wool blazer
        u(6) = 5000*(1-priceIncrease);
        % acetate supply increase
    elseif question == 4
        b(2) = 38000; % new acetate material supply
    end 
   


options = optimoptions('linprog','Algorithm','dual-simplex');

    if question == 2
        [x, fval] = linprog(c, A, b, Aeq , beq , l, u, options);
        fval = (-1*fval) - 860000 - (3*1200000);
    else

        [x, fval] = linprog(c, A, b, [] , [] , l, u, options);
        fval = (-1*fval) - 860000 - (3*1200000);
    end 
     
end 

function [ans]=profitCalculator(a,b,c,price,costs,priceIncrease)
    ans=-(price*(1+priceIncrease)*(a+0.6*b+0*c)-costs);
end
