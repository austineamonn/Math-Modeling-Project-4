function [ans]=profitCalculator(a,b,c,price,costs,priceIncrease)

ans=-(price*(1+priceIncrease)*(a+0.6*b+0*c)-costs);
