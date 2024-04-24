clc, clear, close all
%% Get the Data
[FILENAME, PATHNAME] = uigetfile('./*.csv');
[~,~,Gas_Emissions]=xlsread(strcat(PATHNAME,FILENAME));
%%Gas_Emissions
X=cell2mat(Gas_Emissions(2:end,1));
Y=cell2mat(Gas_Emissions(2:end,14));
years=unique(X) ;
% line of code to plot the data till 2019 only
years = years(years <= 2019);
total_gas=zeros(length(years),1);
for i=1:length(years)
    year=(X==years(i));
    total_gas(i)=sum(Y(year))/1000;
end

%% Ploting the data
plot(years,total_gas,'bo');
xlabel('year')
ylabel('Gas (KGg)')
title('Gas emissions in Catalonia')

%% regression using data from 2014 to 2019
data=years>=2014 & years<=2019;
B = regress(total_gas(data),[years(data),ones(sum(data),1)]);
B
%% Testing the model
Gas_Emission_Predicted=B(1)*years(data)+B(2);
Gas_Emission=total_gas(data);
%% Ploting the prediction versus real
figure
plot(Gas_Emission_Predicted,Gas_Emission,'bo');
xlabel('Predicted (KGg)')
ylabel('Real (KGg)')
title('Predicted versus Real')
hold on
plot([min(Gas_Emission),max(Gas_Emission)],[min(Gas_Emission),max(Gas_Emission)])

%% Predicting the gas emission in 2020
year_predition=2020;
Prediction=B(1)*year_predition+B(2);
disp(strcat('Prediction in ',num2str(year_predition),':',num2str(Prediction)))
