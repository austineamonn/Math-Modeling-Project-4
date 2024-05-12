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

%%Note for Reference
%Wool 45,000
%Acetate 38,000 ... Increased Level, base is 28000
%Cashmere 9,000
%Silk 18,000
%Rayon 30,000
%Velvet 20,000
%Cotton 30,000

ResultMatrix=zeros(7,2);

%WS,CS1,SB,SC,TS,WB,VP,CS2,CM,VS,BB

Wool=3*WS+2.5*WB;
Acetate=2*WS+1.5*TS+1.5*WB+2*VP;
Cashmere=1.5*CS1;
Silk=1.5*SB+0.5*SC;
Rayon=2*TS+1.5*BB;
Velvet=3*VP+1.5*VS;
Cotton=1.5*CS2+0.5*CM;

%Wool
ResultMatrix(1,1)=Wool;
ResultMatrix(1,2)=Wool/45000;

%Acetate
ResultMatrix(2,1)=Acetate;
ResultMatrix(2,2)=Acetate/38000;

%Cashmere
ResultMatrix(3,1)=Cashmere;
ResultMatrix(3,2)=Cashmere/9000;

%Silk
ResultMatrix(4,1)=Silk;
ResultMatrix(4,2)=Silk/18000;

%Rayon
ResultMatrix(5,1)=Rayon;
ResultMatrix(5,2)=Rayon/30000;

%Velvet
ResultMatrix(6,1)=Velvet;
ResultMatrix(6,2)=Velvet/20000;

%Cotton
ResultMatrix(7,1)=Cotton;
ResultMatrix(7,2)=Cotton/30000;




