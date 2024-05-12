function supplySlopeGraph(lower,upper,points,num,outlets)

%%Initialization

if nargin<5
    outlets=false; %assume no outlets
    if nargin<4
        num=41;
        if nargin<3
            points=1000;
            upper=2.6;
            lower=0.7;
        end
    end
end

iter=linspace(.6,1,num);

%outlets
WoolVec=zeros(1,num);
AcetateVec=zeros(1,num);
CashmereVec=zeros(1,num);
SilkVec=zeros(1,num);
RayonVec=zeros(1,num);
VelvetVec=zeros(1,num);
CottonVec=zeros(1,num);

%%Iterating Through the supplyGraph Function

if outlets
    for i=1:num
        %outlets
        [WoolSlope,AcetateSlope,CashmereSlope,SilkSlope,RayonSlope,VelvetSlope,CottonSlope]=supplyGraph(lower,upper,points,true,iter(i));
        WoolVec(i)=WoolSlope;
        AcetateVec(i)=AcetateSlope;
        CashmereVec(i)=CashmereSlope;
        SilkVec(i)=SilkSlope;
        RayonVec(i)=RayonSlope;
        VelvetVec(i)=VelvetSlope;
        CottonVec(i)=CottonSlope;
    end
else
    for i=1:num
        %no outlets
        [WoolSlope,AcetateSlope,CashmereSlope,SilkSlope,RayonSlope,VelvetSlope,CottonSlope]=supplyGraph(lower,upper,points,false,iter(i));
        WoolVec(i)=WoolSlope;
        AcetateVec(i)=AcetateSlope;
        CashmereVec(i)=CashmereSlope;
        SilkVec(i)=SilkSlope;
        RayonVec(i)=RayonSlope;
        VelvetVec(i)=VelvetSlope;
        CottonVec(i)=CottonSlope;
    end
end

%%Graphing

figure;
hold on
plot(iter, WoolVec, 'LineWidth', 3.0);
plot(iter, AcetateVec, 'LineWidth', 3.0);
plot(iter, CashmereVec, 'LineWidth', 3.0);
plot(iter, SilkVec, 'LineWidth', 3.0);
plot(iter, RayonVec, 'LineWidth', 3.0);
plot(iter, VelvetVec, 'LineWidth', 3.0);
plot(iter, CottonVec, 'LineWidth', 3.0);
xlabel('Percent of Products sold at Main Stores');
ylabel('Slope at Base Material Supply');
title('Slope at Base Material Supply with Different Percent of Products sold at Main Stores');
legend('Wool', 'Acetate', 'Cashmere', 'Silk', 'Rayon', 'Velvet', 'Cotton');
fontsize(14,"points");
xlim([0.6 1]);
ylim([0 30000]); %if slope is low/high enough
%this will need to be changed to see the lines in the graph
