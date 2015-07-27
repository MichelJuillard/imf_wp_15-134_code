R{1} = load('ifb_results');
R{2} = load('tay_results');
R{3} = load('dm1_results');
R{4} = load('dm2_results');
for i=1:4
    Y{i} = R{i}.oo_.endo_simul;
    i_pie(i) = strmatch('PIE_US',R{i}.M_.endo_names);
    i_pie4(i) = strmatch('PIE4_US',R{i}.M_.endo_names);
    i_e_pie4(i) = strmatch('E_PIE4_US',R{i}.M_.endo_names);
    i_rs(i) = strmatch('RS_US',R{i}.M_.endo_names);
    i_lrr(i) = strmatch('LRR_US',R{i}.M_.endo_names);
    i_lrs(i) = strmatch('LRS_US',R{i}.M_.endo_names);
    i_y(i) = strmatch('Y_US',R{i}.M_.endo_names);
    i_drs(i) = strmatch('dRS_US',R{i}.M_.endo_names);
    i_rr_bar(i) = strmatch('RR_BAR_US',R{i}.M_.endo_names);
end
w_pie = R{3}.M_.params(strmatch('w_pie',R{3}.M_.param_names,'exact'));
w_y = R{3}.M_.params(strmatch('w_y',R{3}.M_.param_names,'exact'));
w_drs = R{3}.M_.params(strmatch('w_drs',R{3}.M_.param_names, ...
                                'exact'));
pietar = R{1}.M_.params(strmatch('pietar_ss_US',R{1}.M_.param_names));

figure('Name','Figure 4')
t = 1:25;
subplot(2,2,1)
plot(t,Y{1}(i_pie4(1),t),'b-',t, Y{2}(i_pie4(2),t),'go-',t, ...
     Y{3}(i_pie4(3),t),'mx-',t, Y{4}(i_pie4(4),t),'ks-')
axis([1,25,0.8,2.3])
as = gca;
set(as,'XTick',[1 9 17 24])
set(as,'XTickLabel',{'2014:4','2016:4','2018:4','2020:4'})
grid
title('PCE Inflation (%, YoY)')
legend('IFB','TAY','DM1','DM2','Location','SouthEast')
subplot(2,2,2)
plot(t,Y{1}(i_rs(1),t),'b-',t, Y{2}(i_rs(2),t),'go-',t, Y{3}(i_rs(3),t),'mx-',t, ...
     Y{4}(i_rs(4),t),'ks-',t,Y{1}(i_rr_bar(i),t)+pietar,'k--')
axis([1,25,0,3.7])
as = gca;
set(as,'XTick',[1 9 17 24])
set(as,'XTickLabel',{'2014:4','2016:4','2018:4','2020:4'})
grid
title('Fed Funds Rate (%, p.a.)')
legend('IFB','TAY','DM1','DM2','Neutral rate','Location','SouthEast')
subplot(2,2,3)
plot(t,Y{1}(i_y(1),t),'b-',t, Y{2}(i_y(2),t),'go-',t, Y{3}(i_y(3),t),'mx-',t, ...
     Y{4}(i_y(4),t),'ks-',[1 25],[0 0],'k-')

axis([1,25,-2.0,1.0])
as = gca;
set(as,'XTick',[1 9 17 24])
set(as,'XTickLabel',{'2014:4','2016:4','2018:4','2020:4'})
grid
title('Ouput Gap (%)')
legend('IFB','TAY','DM1','DM2','Location','SouthEast')
subplot(2,2,4)
for i=1:4
    if i == 4
        w_y = 0.5;
    end
    Loss(i,:) = w_pie*(Y{i}(i_pie4(i),:)-pietar).^2 + w_y*Y{i}(i_y(i),:).^2 ...
        + w_drs*Y{i}(i_drs(i),:).^2;
end        
plot(t,Loss(1,t),'b-',t, Loss(2,t),'go-',t, Loss(3,t),'mx-',t, Loss(4,t),'ks-')
axis([1,25,0.0,5.0])
as = gca;
set(as,'XTick',[1 9 17 24])
set(as,'XTickLabel',{'2014:4','2016:4','2018:4','2020:4'})
grid
title('Value of the Loss Function')
legend('IFB','TAY','DM1','DM2','Location','NorthEast')

figure('Name','Figure 5')
t = 1:25;
t2 = 2:25;
subplot(2,2,1)
plot(t,Y{1}(i_pie(1),t),'b-',t, Y{2}(i_pie(2),t),'go-',t, ...
     Y{3}(i_pie(3),t),'mx-',t, Y{4}(i_pie(4),t),'ks-',[1 25],[2.0 2.0],'k-')
axis([1,25,1.1,2.2])
as = gca;
set(as,'XTick',[1 9 17 24])
set(as,'XTickLabel',{'2014:4','2016:4','2018:4','2020:4'})
grid
title('PCE Inflation (%, QoQ)')
legend('IFB','TAY','DM1','DM2','Location','SouthEast')
subplot(2,2,2)
plot(t2,Y{1}(i_e_pie4(1),t2),'b-',t2, Y{2}(i_e_pie4(2),t2),'go-',t2, Y{3}(i_e_pie4(3),t2),'mx-',t2, ...
     Y{4}(i_e_pie4(4),t2),'ks-',[1 25],[2.0 2.0],'k-')
axis([1,25,1.25,2.15])
as = gca;
set(as,'XTick',[1 9 17 24])
set(as,'XTickLabel',{'2014:4','2016:4','2018:4','2020:4'})
grid
title('4Q PCE Inflation Expectations (%, YoY)')
legend('IFB','TAY','DM1','DM2','Location','SouthEast')
subplot(2,2,3)
plot(t2,Y{1}(i_lrs(1),t2),'b-',t2, Y{2}(i_lrs(2),t2),'go-',t2, Y{3}(i_lrs(3),t2),'mx-',t2, ...
     Y{4}(i_lrs(4),t2),'ks-',[1 25],[0 0],'k-')

axis([1,25,0.7,3.8])
as = gca;
set(as,'XTick',[1 9 17 24])
set(as,'XTickLabel',{'2014:4','2016:4','2018:4','2020:4'})
grid
title('Long Mrkt. Nominal Rates (%, p.a.)')
legend('IFB','TAY','DM1','DM2','Location','SouthEast')
subplot(2,2,4)
plot(t2,Y{1}(i_lrr(1),t2),'b-',t2, Y{2}(i_lrr(2),t2),'go-',t2, Y{3}(i_lrr(3),t2),'mx-',t2, ...
     Y{4}(i_lrr(4),t2),'ks-',[1 25],[0 0],'k-')
axis([1,25,-1.4,1.8])
as = gca;
set(as,'XTick',[1 9 17 24])
set(as,'XTickLabel',{'2014:4','2016:4','2018:4','2020:4'})
grid
title('Long Mrkt. Real Rates (%, p.a.)')
legend('IFB','TAY','DM1','DM2','Location','SouthEast')
