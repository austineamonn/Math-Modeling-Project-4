function [ans]=profitCalculator(a,b,c,price,costs)

ans=-(price*(a+0.6*b+0*c)-costs);
