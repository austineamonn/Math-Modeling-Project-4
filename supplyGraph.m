function supplyGraph(lower,upper,points,outlets,ax1)

%%Inputs

if nargin<5
    ax1=0.97; %assume Sales Level 1
    if nargin<4
        outlets=false; %assume no Outlets
        if nargin<3
            points=1000; %assume 1,000 points
            if nargin<2
                upper=1.5; %assume an upper bound of 150%
                lower=0.5; %assume a lower bound of 50%
            end
        end
    end
end

%%Initialization

WoolSuppVec=linspace(lower,upper,points);
AcetateSuppVec=linspace(lower,upper,points);
CashmereSuppVec=linspace(lower,upper,points);
SilkSuppVec=linspace(lower,upper,points);
RayonSuppVec=linspace(lower,upper,points);
VelvetSuppVec=linspace(lower,upper,points);
CottonSuppVec=linspace(lower,upper,points);

WoolProfVec=zeros(1,points);
AcetateProfVec=zeros(1,points);
CashmereProfVec=zeros(1,points);
SilkProfVec=zeros(1,points);
RayonProfVec=zeros(1,points);
VelvetProfVec=zeros(1,points);
CottonProfVec=zeros(1,points);

%%Given Supply Levels for Reference
%45000 Wool
%28000 Acetate
%9000 Cashmere
%18000 Silk
%30000 Rayon
%20000 Velvet
%30000 Cotton

%%Given Sales Levels for Reference
%0.97 Sales Level 1
%0.93 Sales Level 2
%0.91 Sales Level 3
%0.89 Sales Level 4
%0.605 Sales Level 5 ... Realistic Scenario

%%Main Algorithm

for i=1:points
    %Wool
    [~, x]=fashionStarModel(4, -1, outlets, 0, 1, WoolSuppVec(i)*45000, ax1);
    WoolProfVec(i)=x;
    %Acetate
    [~, x]=fashionStarModel(4, -1, outlets, 0, 2, AcetateSuppVec(i)*28000, ax1);
    AcetateProfVec(i)=x;
    %Cashmere
    [~, x]=fashionStarModel(4, -1, outlets, 0, 3, CashmereSuppVec(i)*9000, ax1);
    CashmereProfVec(i)=x;
    %Silk
    [~, x]=fashionStarModel(4, -1, outlets, 0, 4, SilkSuppVec(i)*18000, ax1);
    SilkProfVec(i)=x;
    %Rayon
    [~, x]=fashionStarModel(4, -1, outlets, 0, 5, RayonSuppVec(i)*30000, ax1);
    RayonProfVec(i)=x;
    %Velvet
    [~, x]=fashionStarModel(4, -1, outlets, 0, 6, VelvetSuppVec(i)*20000, ax1);
    VelvetProfVec(i)=x;
    %Cotton
    [~, x]=fashionStarModel(4, -1, outlets, 0, 7, CottonSuppVec(i)*30000, ax1);
    CottonProfVec(i)=x;
end

%%Graphing

xaxis = linspace (lower, upper, points);

figure;
hold on
plot(xaxis, WoolProfVec, 'LineWidth', 3.0);
plot(xaxis, AcetateProfVec, 'LineWidth', 3.0);
plot(xaxis, CashmereProfVec, 'LineWidth', 3.0);
plot(xaxis, SilkProfVec, 'LineWidth', 3.0);
plot(xaxis, RayonProfVec, 'LineWidth', 3.0);
plot(xaxis, VelvetProfVec, 'LineWidth', 3.0);
plot(xaxis, CottonProfVec, 'LineWidth', 3.0);
xlabel('Material Supply Relative to Given Values');
ylabel('Profit');
title('Total Profits from Changing Material Supplies');
legend('Wool', 'Acetate', 'Cashmere', 'Silk', 'Rayon', 'Velvet', 'Cotton');
fontsize(14,"points");
xlim([lower upper]);
ylim([-2000000 3500000]); %if relative material level is low/high enough
%this will need to be changed to see the lines in the graph

%%Slope Calculations

step=(upper-lower)/points; %step size calculation
x1=floor((0.99-lower)/step); %number of steps to 0.99
x2=floor((1.01-lower)/step); %number of steps to 1.01

WoolSlope=(WoolProfVec(x2)-WoolProfVec(x1))/(2) %divide by 2 so that the
%slope is in percentage
AcetateSlope=(AcetateProfVec(x2)-AcetateProfVec(x1))/(2)
CashmereSlope=(CashmereProfVec(x2)-CashmereProfVec(x1))/(2)
SilkSlope=(SilkProfVec(x2)-SilkProfVec(x1))/(2)
RayonSlope=(RayonProfVec(x2)-RayonProfVec(x1))/(2)
VelvetSlope=(VelvetProfVec(x2)-VelvetProfVec(x1))/(2)
CottonSlope=(VelvetProfVec(x2)-VelvetProfVec(x1))/(2)


