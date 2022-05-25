%% real situation

clear all
dt = 0.01;
t = 1:dt:100;
figure;
for xx = -100:10:100
    for yy = -100:10:100
        
        %         xx = 10;
        %         yy= 60;
        R(1) =xx;
        J(1) =yy;
        w11 = 0.005;
        w12 = 0.003;
        w21 = -0.006;
        w22 = -0.004;
        for ii =2:length(t)
            R(ii) = R(ii-1) +dt*(w11*R(ii-1)+w12*J(ii-1));
            J(ii) = J(ii-1) +dt*(w21*R(ii-1) + w22*J(ii-1));
        end
        
        
%         subplot(121)
%         plot(t,R,'r-','linewidth',1);hold on
%         plot(t,J,'b-','linewidth',1)
%         legend({'Romeo','Juliet'});
%         legend box off
%         xlabel('Time / Days');ylabel('Feeling of Love');
%         box off
%         
%         subplot(122)
        plot(R,J,'k-')
        xlabel('Romeo')
        ylabel('Juliet')
        hold on;plot(xx,yy,'r.')
        box off
    end
    disp(num2str(xx))
end

set(gca,'tickdir','in','linewidth',1,...
    'xcolor',[0 0 0],'ycolor',[0 0 0],'layer','top','xaxislocation','origin','yaxislocation','origin')


%% complex situation
clear all
dt = 0.01;
t = 1:dt:100;


R(1) = 0.1;
J(1) = 0;
alpha = 0;
beta = 0.75;

for ii =2:length(t)
    R(ii) = R(ii-1) +dt*(alpha*R(ii-1)+beta*J(ii-1));
    J(ii) = J(ii-1) +dt*((-beta)*R(ii-1) + alpha*J(ii-1));
end


figure;
subplot(121)
plot(t,R,'r-','linewidth',1);hold on
plot(t,J,'b-','linewidth',1)
legend({'Romeo','Juliet'});
legend box off
xlabel('Time / Days');ylabel('Feeling of Love');
box off

subplot(122)
plot(R,J,'k-')
xlabel('Romeo')
ylabel('Juliet')
box off
%%

