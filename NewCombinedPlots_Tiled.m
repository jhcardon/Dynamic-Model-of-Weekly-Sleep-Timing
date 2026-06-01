%% Plots

clear
load Results_combined


 SleepOnsetW_1=mean(ss1(2,7:11));   %use Week 2, Sunday-Thursday Work days
 SleepOnsetF_1=mean(ss1(2,12:13));  % ", Friday-Saturday Free Days
 SleepOffsetW_1=mean(aa1(2,8:12)) ;  %use Week 2, Monday-Friday
 SleepOffsetF_1=mean(aa1(2,13:14));   %use Week 2, Saturday-Sunday;
 %DurationW_1  = SleepOnsetW_1:.0001:SleepOffsetW_1+24;
 %DurationF_1  = SleepOnsetF_1:.0001:SleepOffsetF_1+24;
 DurationW_1  = linspace(SleepOnsetW_1,SleepOffsetW_1+24,1000);
 DurationF_1  = linspace(SleepOnsetF_1,SleepOffsetF_1+24,1000);
 
 SleepOnsetW_11=mean(ss11(2,7:11));   %use Week 2, Sunday-Thursday Work days
 SleepOnsetF_11=mean(ss11(2,12:13));  % ", Friday-Saturday Free Days
 SleepOffsetW_11=mean(aa11(2,8:12)) ;  %use Week 2, Monday-Friday
 SleepOffsetF_11=mean(aa11(2,13:14));   %use Week 2, Saturday-Sunday;
 %DurationW_11  = SleepOnsetW_11:.0001:SleepOffsetW_11 +24;
 %DurationF_11 =  SleepOnsetF_11:.0001:SleepOffsetF_11 +24;
 DurationW_11  = linspace(SleepOnsetW_11,SleepOffsetW_11 +24,1000);
 DurationF_11 =  linspace(SleepOnsetF_11,SleepOffsetF_11 +24,1000);

 SleepOnsetW_3=mean(ss3(2,7:11));   %use Week 2, Sunday-Thursday Work days
 SleepOnsetF_3=mean(ss3(2,12:13));  % ", Friday-Saturday Free Days
 SleepOffsetW_3=mean(aa3(2,8:12)) ;  %use Week 2, Monday-Friday
 SleepOffsetF_3=mean(aa3(2,13:14));   %use Week 2, Saturday-Sunday;
 %DurationW_3  = SleepOnsetW_3:.0001:SleepOffsetW_3 +24;
 %DurationF_3 =  SleepOnsetF_3:.0001:SleepOffsetF_3 +24;
 DurationW_3  = linspace(SleepOnsetW_3,SleepOffsetW_3 +24,1000);
 DurationF_3 =  linspace(SleepOnsetF_3,SleepOffsetF_3 +24,1000);

 SleepOnsetW_13 = mean(ss13(2,7:11));   %use Week 2, Sunday-Thursday Work days
 SleepOnsetF_13 = mean(ss13(2,12:13));  % ", Friday-Saturday Free Days
 SleepOffsetW_13= mean(aa13(2,8:12)) ;  %use Week 2, Monday-Friday
 SleepOffsetF_13= mean(aa13(2,13:14));   %use Week 2, Saturday-Sunday;
 %DurationW_13  = SleepOnsetW_13:.0001:SleepOffsetW_13 +24;
 %DurationF_13 =  SleepOnsetF_13:.0001:SleepOffsetF_13 +24;
 DurationW_13  = linspace(SleepOnsetW_13, SleepOffsetW_13 +24,1000);
 DurationF_13 =  linspace(SleepOnsetF_13, SleepOffsetF_13 +24,1000);

Midsleep1=SS1(2,:)/2 + ss1(2,:)-24;
Midsleep11=SS11(2,:)/2 + ss11(2,:)-24;
Midsleep3=SS3(2,:)/2 + ss3(2,:)-24;
Midsleep13=SS13(2,:)/2 + ss13(2,:)-24;


%% Comparison Table
[SleepOffsetW_1 SleepOffsetW_11 SleepOffsetW_3 SleepOffsetW_13;
 SleepOffsetF_1 SleepOffsetF_11 SleepOffsetF_3 SleepOffsetF_13;
 SleepOnsetW_1 SleepOnsetW_11 SleepOnsetW_3 SleepOnsetW_13;
 SleepOnsetF_1 SleepOnsetF_11 SleepOnsetF_3 SleepOnsetF_13;
 mean(SS1(2,7:11 )) mean(SS11(2,7:11)) mean(SS3(2,7:11)) mean(SS13(2,13:17)); %Weekday Sleep
 mean(SS1(2,12:13 )) mean(SS11(2,12:13)) mean(SS3(2,12:13)) mean(SS13(2,12:13)); %Free Sleep
 mean(Midsleep1(12:13 ))-mean(Midsleep1(7:11 )) mean(Midsleep11(12:13))-mean(Midsleep11(7:11 )) mean(Midsleep3(12:13))-mean(Midsleep3(7:11 )) mean(Midsleep13(12:13))-mean(Midsleep13(7:11 ))   % SJL MSF-MSW
 ]                                          %



figure

plot([1:7],aa1(2,8:14),'bo-', [1:7],aa11(2,8:14),'k^-',           [1:7],aa3(2,8:14),'gv-', [1:7],aa13(2,8:14),'rs-', 'LineWidth',1, 'MarkerSize',7)
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Offset, a')
axis('padded')
%lgdC=legend('2-Process','2-Process with U(L)' ,'2-Process with Constraints ','2-Process with U(L) and Constraints','Location','NorthWest', 'FontSize',9) ;
lgdC=legend('2PM','2PML' ,'2PMC ','2PMLC','Location','NorthWest', 'FontSize',9) ;
ylabel('Hours')


figure
plot([1:7],ss1(2,8:14),'bo-', [1:7],ss11(2,8:14),'k^-',           [1:7],ss3(2,8:14),'gv-', [1:7],ss13(2,8:14), 'rs-', 'LineWidth',1, 'MarkerSize',7)
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Onset, s')
axis('padded')
lgdC=legend('2PM','2PML' ,'2PMC ','2PMLC','Location','NorthWest', 'FontSize',9) ;
ylabel('Hours')

figure
plot([1:7],SS1(2,8:14),'bo-', [1:7],SS11(2,8:14),'k^-',           [1:7],SS3(2,8:14),'gv-', [1:7],SS13(2,8:14),'rs-','LineWidth',1, 'MarkerSize',7)
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Total Sleep, S')
axis('padded')
lgdC=legend('2PM','2PML' ,'2PMC ','2PMLC','Location','NorthWest', 'FontSize',9) ;
ylabel('Hours')

figure
plot([1:7],LL1(2,8:14),'bo-', [1:7],LL11(2,8:14),'k^-',           [1:7],LL3(2,8:14),'gv-', [1:7],LL13(2,8:14),'rs-', 'LineWidth',1, 'MarkerSize',7)
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Leisure, L')
axis('padded')
lgdC=legend('2PM','2PML' ,'2PMC ','2PMLC','Location','NorthWest', 'FontSize',9) ;
ylabel('Hours')

figure
plot([1:7],KK1(2,8:14),'bo-', [1:7],KK11(2,8:14),'k^-',           [1:7],KK3(2,8:14),'gv-', [1:7],KK13(2,8:14),'rs-', 'LineWidth',1, 'MarkerSize',7)
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Stock, K')
axis('padded')
lgdC=legend('2PM','2PML' ,'2PMC ','2PMLC','Location','NorthWest', 'FontSize',9) ;
ylabel('K')

figure

plot([1:7],Midsleep1(8:14),'bo-', [1:7],Midsleep11(8:14),'k^-',           [1:7],Midsleep3(8:14),'gv-', [1:7],Midsleep13(8:14),'rs-', 'LineWidth',1, 'MarkerSize',7)
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Midsleep')
axis('padded')
lgdC=legend('2PM','2PML' ,'2PMC ','2PMLC','Location','NorthWest', 'FontSize',9) ;
ylabel('Hours')

%%%%%%%%%%%%%%%%% More resubmission plots
%% Load results from base model (2PML) with a 1-hour Sat-Sun phase shift

load WeekendPhaseShift
%% Results from 2PM with phase shift
load 2PM_PhaseShift

Midsleep_2PMPS=SS2PMPS/2 + ss2PMPS-24;
Midsleep_2PMLPS=SS(2,:)/2 + ss(2,:)-24; 






%%%%%%%%%%%%%%%%%%%   Leave out 2PML with phase shift, emphasize phase
%%%%%%%%%%%%%%%%%%%   shift vs. 2PML

figure
t1=tiledlayout(3,2);
%t1.Title.String = 'Unconstrained Model Comparison';

% Tile 1
nexttile
plot([1:7],aa2PMPS(8:14),'bo-', [1:7],aa11(2,8:14),'k^-', 'LineWidth',1, 'MarkerSize',5)

%plot(Yaa','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
 axis([1 7 5 8])
 xticks(1:1:7)
 yticks(5:.5:8)
ylabel('Hours')
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Offset, a')
axis('padded')


% Tile 2
nexttile
plot([1:7],ss2PMPS(8:14),'bo-', [1:7],ss11(2,8:14),'k^-', 'LineWidth',1, 'MarkerSize',5 )
%plot(Yss','o-')
%legend('2-Process','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Onset, s')
axis('padded')
ylabel('Hours')

% Tile 3
nexttile
plot([1:7],SS2PMPS(8:14),'bo-', [1:7],SS11(2,8:14),'k^-','LineWidth',1, 'MarkerSize',5  )
%plot(YSS','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Total Sleep, S')
axis('padded')
ylabel('Hours')

% Tile 4
nexttile
plot([1:7],LL2PMPS(8:14),'bo-', [1:7],LL11(2,8:14),'k^-', 'LineWidth',1, 'MarkerSize',5 )
%plot(YLL','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Leisure, L')
axis('padded')
ylabel('Hours')

% Tile 5
nexttile
plot([1:7],KK2PMPS(8:14),'bo-',[1:7],KK11(2,8:14),'k^-','LineWidth',1, 'MarkerSize',5  )
%plot(YKK','o-')
%title(lgd,'Model')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Stock, K')
axis('padded')
ylabel('K')

% Tile 6
nexttile
plot([1:7],Midsleep_2PMPS(8:14),'bo-', [1:7],Midsleep11(8:14),'k^-', 'LineWidth',1, 'MarkerSize',5  )
%plot(YKK','o-')
%title(lgd,'Model')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Midsleep')
axis('padded')
ylabel('Hours')

lgd=legend('2PM, Phase Shift','2PML','Location','best','FontSize',9)
% %lgd = legend('2-Process','2-Process with U(L)','Location','best','FontSize',9);
lgd.Layout.Tile = 'south';
















