load('/Users/wuyujie/OneDrive/TA/2022DataAnalysisAndModeling/lecture04/AllData2022.mat')

%% Bootstrap
x = AllData2022.OriBias;
MyData = squeeze(AllData2022.RespData(:,:,1));
Nboot = 1000;
Nbsam = 20;
BootMean = zeros(size(MyData,1),Nboot);
for ii = 1:Nboot
    currtrials = randi(Nbsam,1,Nbsam);
    BootMean(:,ii) = mean(MyData(:,currtrials),2);    
end

SE = std(BootMean,[],2);

figure;
errorbar(x,mean(MyData,2),SE,'ko-','markerfacecolor','k');
xlabel('Orientation Bias')
ylabel('Rate (Right)')
title('Bootstrap of Student 1')
box off
%% fitting and plot distribution
myfun = @(p,x)(0.5 * ( 1 + erf( (x-p(1)) / (p(2)*sqrt(2)) ) ));
BootParam = zeros(Nboot,2);

for ii = 1:Nboot
    curry = BootMean(:,ii);
    BootParam(ii,:) = nlinfit(x, curry, myfun, [0 0.5]);
end

y = squeeze(mean(mean(AllData2022.RespData(:,:,2:end),3),2));
p = nlinfit(x, y, myfun, [0 0.5]);

%[NuminBin,centers] = hist(BootParam(:,1),[0:0.05:1]);

figure
hist(BootParam(:,1));
xlabel('Parameter \mu')
ylabel('Frequency')
title('1000 fitting results of Student 1')
box off

hold on;plot([1 1].*p(1),[0,300],'r-','linewidth',1.5)
text(0.06,250,'\mu of the others','Color','r','FontSize',12)
%% CI
CI = prctile(BootParam(:,1),[2.5 97.5]);

figure
hist(BootParam(:,1))
hold on;plot([1 1].*allp(1),[0,300],'r-','linewidth',1.5)
text(0.01,250,'\mu of the others','Color','r','FontSize',12,'FontWeight','bold')
hold on;plot([1 1].*CI(1),[0 300],'k--','linewidth',1.5)
hold on;plot([1 1].*CI(2),[0 300],'k--','linewidth',1.5)


xlabel('Parameter \mu')
ylabel('Frequency')
title('1000 fitting results of Student 1')
box off

