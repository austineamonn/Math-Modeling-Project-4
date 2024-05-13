READ ME:

Fasion Star Model:

the main code.

[x, fval] = fashionStarModel(question, salesLevel, outlets, priceIncrease, material, supply, ax1)

%%Inputs

% question 0: optimal sales level with no changes (outlets true or false)
% question 1: increase velvet sales price
% question 2: No velvet returns, price increase of shirt option
% question 3: Wool blazer cost increase, price increase option
% question 4: acetate supply increase

% sales Level: 1,2,3 are the same as in the report

% outlets: boolean for whether or not there are outlets

% priceIncrease: % increase in price

% material: The place in the matrix for each material
% ex: Acetate Material == 2

% supply: the material supply for the material

% ax1: the value of the 'a' parameter from the tech report.

%%Outputs

%x, fval are the same as in LinProg.

How Much Material Was Used:

Calculate how much material was used up based on production levels.

function [ResultMatrix]=HowMuchMaterialUsed(WS,CS1,SB,SC,TS,WB,VP,CS2,CM,VS,BB)

%%Inputs

%WS = Number of Wool Slacks Produced
%CS1 = Number of Cashmere Sweaters Produced
%SB = Number of Silk Blouses Produced
%SC = Number of Silk Camisoles Produced
%TS = Number of Tailored Skirts Produced
%WB = Number of Wool Blazers Produced
%VP = Number of Velvet Pants Produced
%CS2 = Number of Cotton Sweaters Produced
%CM = Number of Cotton Miniskirts Produced
%VS = Number of Velvet Shirts Produced
%BB = Number of Button-Down Blouses Produced

%%Outputs

%ResultMatrix:
%Each row corresponds to each Material
%First column is How Much of the Material was Used
%Second Column is the Fraction of total available Material Used


Graphing Functions:

all these functions were used to graph the outputs from Fashion Star Model

function bigGraph(salesLevel,velvet,outlets)

function fashionLoop(loop,salesLevel,velvet,outlets, gnumb)

function [WoolSlope,AcetateSlope,CashmereSlope,SilkSlope,RayonSlope,VelvetSlope,CottonSlope]=supplyGraph(lower,upper,points,outlets,ax1)

function supplySlopeGraph(lower,upper,points,num,outlets)

Additional Code:

Extra functions that get called automatically by other functions

function [ans]=profitCalculator(a,b,c,price,costs,priceIncrease)

