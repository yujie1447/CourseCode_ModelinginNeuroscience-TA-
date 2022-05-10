% Data Analysis and Modeling in Neuroscience (Lesson 4)
% written by yujie, 2022.3.14

%% Simulation Data
x = 1:20;
NoiseStrength = 1;
error = NoiseStrength*randn(1,20);
y = x + error;

figure;
plot(x,y,'o');
xlabel('Luminance');ylabel('Firing Rate');box off

%% Fitting linear regression

coefs = polyfit(x,y,1);
yhat = coefs(1)*x + coefs(2); %yhat = polyval(coefs,x);

figure;

plot(x,y,'o');hold on;
plot(x,yhat,'-','color',[1 0.5 0],'linewidth',2);

xlabel('Luminance');
ylabel('Firing Rate');
box off
%% labeling error
plot(repmat(x,2,1),[y;yhat],'k-','linewidth',1)

%% Loading Homework Data
load('/Users/wuyujie/OneDrive/TA/2022DataAnalysisAndModeling/lecture04/AllData2022.mat')
% AllData2022.RespData(AllData2022.RespData(:,:,1:14)==1)=0;
% AllData2022.RespData(AllData2022.RespData(:,:,1:14)==2)=1;
% save('/Users/wuyujie/OneDrive/TA/2022DataAnalysisAndModeling/lecture04/AllData2022.mat')

%% check Data
figure;
for ss = 1:size(AllData2022.RespData,3)    
    subplot(3,5,ss);
    plot(AllData2022.OriBias,squeeze(mean(AllData2022.RespData(:,:,ss),2)),'ko-');
    if ss==1
        xlabel('Orientation Bias');
        ylabel('Rate (Right)');
    end
    box off
end

figure;
for ss = 1:size(AllData2022.RespData,3)    
    subplot(3,5,ss);
    plot(AllData2022.OriBias,squeeze(mean(AllData2022.RTData(:,:,ss),2)),'ko-');
    if ss==1
        xlabel('Orientation Bias');
        ylabel('RT');
    end
    box off
end
%% Fitting 
% funstring = '0.5 * ( 1 + erf( (x-p(1)) / (p(2)*sqrt(2)) ) )';
% myfun = inline(funstring, 'p', 'x');
% 
x = AllData2022.OriBias;
y = squeeze(mean(AllData2022.RespData(:,:,1),2));
myfun = @(p,x)(0.5 * ( 1 + erf( (x-p(1)) / (p(2)*sqrt(2)) ) ));
p = nlinfit(x, y, myfun, [0 0.5]);
% p = lsqcurvefit(myfun,[0 0.5],x,y);

yhat = myfun(p,x(1):0.01:x(end));

figure
plot(x,y,'ko','markerfacecolor','k');hold on
plot(x(1):0.01:x(end),yhat,'r-','linewidth',2)
xlabel('Orientation Bias');
ylabel('Rate (Right)');
title('Student 1')
box off
%% Fitting for all 
x = AllData2022.OriBias;
xinterp = x(1):0.01:x(end);
myfun = @(p,x)(0.5 * ( 1 + erf( (x-p(1)) / (p(2)*sqrt(2)) ) ));
allp = zeros(15,2);

figure
for ss = 1:15
    y = squeeze(mean(AllData2022.RespData(:,:,ss),2));
    allp(ss,:) = nlinfit(x, y, myfun, [0 0.5]);
    yhat = myfun(allp(ss,:),xinterp);
    
    subplot(3,5,ss)
    plot(x,y,'ko','markerfacecolor','k');hold on
    plot(xinterp,yhat,'r-','linewidth',2)
    text(1,0.3,['u = ' num2str(allp(ss,1))]);
    text(1,0.1,['std = ' num2str(allp(ss,2))])
    if ss ==1
        xlabel('Orientation Bias');
        ylabel('Rate (Right)');
    end
    title(['Student ' num2str(ss)]);
    box off
end
%% Naka Rushton
x = AllData2022.OriBias;
y = squeeze(mean(AllData2022.RespData(:,:,3),2));
xinterp = x(1):0.01:x(end);

myNRfun = @(p, x)(p(1)*x.^(p(2))./(x.^(p(2))+p(3)^p(2))+p(4));
pNR = nlinfit(x,y,myNRfun,[0.1 0.5 0.5 0.1]);

yhat = myfun(p,x(1):0.01:x(end));

figure
plot(x,y,'ko','markerfacecolor','k');hold on
plot(x(1):0.01:x(end),yhat,'r-','linewidth',2)
xlabel('Orientation Bias');
ylabel('Rate (Right)');
title('Student 1')
box off