% 10/9/2024
%% Plot several runs on one graph: aa, ss, SS, LL, KK
%% USE FOR FINAL VERSIONS as it  compares 2-process with full economic model.
%% Need to create Results_all from final versions.

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




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Resubmission:  graphs by outcome 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Older Plots Commented Below
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  variable, add Midsleep




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

figure
t1=tiledlayout(3,2);
%t1.Title.String = 'Unconstrained Model Comparison';

% Tile 1
nexttile
plot([1:7],aa2PMPS(8:14),'bo-', [1:7],aa11(2,8:14),'k^-', [1:7],aa(2,8:14),'rs-','LineWidth',1, 'MarkerSize',5)

%plot(Yaa','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
 axis([1 7 5 8])
 xticks(1:1:7)
 yticks(5:.5:8)
 

xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Offset, a')
axis('padded')


% Tile 2
nexttile
plot([1:7],ss2PMPS(8:14),'bo-', [1:7],ss11(2,8:14),'k^-',  [1:7],ss(2,8:14),'rs-','LineWidth',1, 'MarkerSize',5 )
%plot(Yss','o-')
%legend('2-Process','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Onset, s')
axis('padded')


% Tile 3
nexttile
plot([1:7],SS2PMPS(8:14),'bo-', [1:7],SS11(2,8:14),'k^-', [1:7],SS(2,8:14),'rs-','LineWidth',1, 'MarkerSize',5  )
%plot(YSS','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Total Sleep, S')
axis('padded')

% Tile 4
nexttile
plot([1:7],LL2PMPS(8:14),'bo-', [1:7],LL11(2,8:14),'k^-', [1:7], LL(2,8:14),'rs-' ,'LineWidth',1, 'MarkerSize',5 )
%plot(YLL','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Leisure, L')
axis('padded')

% Tile 5
nexttile
plot([1:7],KK2PMPS(8:14),'bo-',[1:7],KK11(2,8:14),'k^-', [1:7],KK(2,8:14),'rs-','LineWidth',1, 'MarkerSize',5  )
%plot(YKK','o-')
%title(lgd,'Model')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Stock, K')
axis('padded')

% Tile 6
nexttile
plot([1:7],Midsleep_2PMPS(8:14),'bo-', [1:7],Midsleep11(8:14),'k^-', [1:7],Midsleep_2PMLPS(8:14),'rs-','LineWidth',1, 'MarkerSize',5  )
%plot(YKK','o-')
%title(lgd,'Model')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Midsleep')
axis('padded')


lgd=legend('2PM, Phase Shift','2PML','2PML, Phase Shift','Location','best','FontSize',9)
% %lgd = legend('2-Process','2-Process with U(L)','Location','best','FontSize',9);
lgd.Layout.Tile = 'south';





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















%%%%%%%%%%%% Older plots from original submission below




% FreeOffset1;
% FreeOffset11;
% FreeOffset3;
% FreeOffset13;
% 
% FreeOnset1;
% FreeOnset11;
% FreeOnset3;
% FreeOnset13;
% 
% SJL1= ;
% SJL11= ;
% SJL3= ;
% SJL13= ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%    Unconstrained Models

figure
t1=tiledlayout(3,2);
%t1.Title.String = 'Unconstrained Model Comparison';

% Tile 1
nexttile
plot([1:7],aa1(2,8:14),'bo-', [1:7],aa11(2,8:14),'r^-')

%plot(Yaa','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
 axis([1 7 5 8])
 xticks(1:1:7)
 yticks(5:.5:8)

xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Offset, a')
axis('padded')


% Tile 2
nexttile
plot([1:7],ss1(2,8:14),'bo-',  [1:7],ss11(2,8:14),'r^-' )
%plot(Yss','o-')
%legend('2-Process','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Onset, s')
axis('padded')


% Tile 3
nexttile
plot([1:7],SS1(2,8:14),'bo-', [1:7],SS11(2,8:14),'r^-'  )
%plot(YSS','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Total Sleep, S')
axis('padded')

% Tile 4
nexttile
plot([1:7],LL1(2,8:14),'bo-', [1:7], LL11(2,8:14),'r^-'  )
%plot(YLL','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Leisure, L')
axis('padded')

% Tile 5
nexttile
plot([1:7],KK1(2,8:14),'bo-', [1:7],KK11(2,8:14),'r^-'  )
%plot(YKK','o-')
%title(lgd,'Model')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Stock, K')
axis('padded')

lgd=legend('2-Process','2-Process with U(L)','Location','SouthEastOutside','FontSize',9)
%lgd = legend('2-Process','2-Process with U(L)','Location','best','FontSize',9);
lgd.Layout.Tile = 6;



% % Tile 6
% nexttile
%  plot( DurationW_1, 5*ones(size(DurationW_1)),'b', DurationF_1, 4.25*ones(size(DurationF_1)),'-g',DurationW_11, 3*ones(size(DurationW_11)),'r-',  DurationF_11, 2.25*ones(size(DurationF_11)),'c-',  'LineWidth',12)
% 
% 
% xlabel('Time of Day')
% title('Hours Asleep by Model')
% axis([22 34 1 6])
% xticks([21:1:34])
% xticklabels({'21','22','23','24','1','2','3','4','5','6','7','8','9','10'})
% yticks([])
% 
% lgd_duration=legend('2-Process, Workday', '2-Process, Free', '2-Process with U(L), Workday'  ,'2-Process with U(L), Free','Location','best')
% lgd.Layout.Tile = 7;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                     Models with Constraints
figure

t2=tiledlayout(3,2);
%t2.Title.String = 'Models with Alarm and Social Constraints';

nexttile
plot([1:7],aa1(2,8:14),'bo-', [1:7],aa3(2,8:14),'gs-', [1:7],aa13(2,8:14),'r^-')

%plot(Yaa','o-')
%legend('2-Process with Constraints','2-Process with U(L)')
axis([1 7 5 8])
 xticks(1:1:7)
 yticks(5:.5:8)

xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Offset, a')
axis('padded')

nexttile
plot([1:7],ss1(2,8:14),'bo-', [1:7],ss3(2,8:14),'gs-',  [1:7],ss13(2,8:14),'r^-' )
%plot(Yss','o-')
%legend('2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Onset, s')
axis('padded')


nexttile
plot([1:7],SS1(2,8:14),'bo-', [1:7],SS3(2,8:14),'gs-', [1:7],SS13(2,8:14),'r^-'  )
%plot(YSS','o-')
%legend('2-Process with Constraints','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Total Sleep, S')
axis('padded')


nexttile
plot([1:7],LL1(2,8:14),'bo-', [1:7],LL3(2,8:14),'gs-', [1:7], LL13(2,8:14),'r^-'  )
%plot(YLL','o-')
%legend('2-Process with Constraints','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Leisure, L')
axis('padded')


nexttile
plot(1:7,KK1(2,8:14),'bo-',  [1:7],KK3(2,8:14),'gs-', [1:7],KK13(2,8:14),'r^-'  )
%plot(YKK','o-')
%title(lgd,'Model')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Stock, K')
axis('padded')

lgdC=legend( '2-Process','2-Process with Constraints ','2-Process with U(L) and Constraints','Location','best', 'FontSize',9)
lgdC.Layout.Tile = 6;



% % Tile 5
% nexttile
% plot([1:7],KK1(2,8:14),'bo-', [1:7],KK11(2,8:14),'r^-'  )
% %plot(YKK','o-')
% %title(lgd,'Model')
% xticks(1:1:8)
% xticklabels({'M','T','W','Th','F','Sa','Su'})
% title('Sleep Stock, K')
% axis('padded')
%  %lgd=legend('2-Process','2-Process with U(L)','Location','SouthEastOutside','FontSize',9)
% lgd = legend('2-Process','2-Process with U(L)','Location','best','FontSize',9)
% lgd.Layout.Tile = 6;

















% subplot(3,2,6),
% plot([1:7],HH3(2,8:14),'ko-', [1:7],HH13(2,8:14),'r^-'  )
% %plot(YKK','o-')
% lgd=legend('2-Process with Constraints ','2-Process with U(L) and Constraints','Location','SouthEastOutside','FontSize',9)
% %title(lgd,'Model')
% xticks(1:1:8)
% xticklabels({'M','T','W','Th','F','Sa','Su'})
% title('Sleep Pressure, H')
% axis('padded')
% 

%graycolor=[.2 .2 .2];

% plot( DurationW_1, 5*ones(size(DurationW_1)),'k',        DurationW_3, 4*ones(size(DurationW_3)),'g-',  DurationF_3, 3.25*ones(size(DurationF_3)),'c-', DurationW_13, 2*ones(size(DurationW_13)),'m-',  DurationF_13, 1.25*ones(size(DurationF_13)),'y-', 'LineWidth',12)
% xlabel('Time of Day')
% title('Hours Asleep by Model')
% axis([22 34 -1 6])
% xticks([21:1:34])
% xticklabels({'21','22','23','24','1','2','3','4','5','6','7','8','9','10'})
% yticks([])
% %yticklabels({'Weekday, 7-day','Weekend, 7-day','Weekday, 5-day','Weekend,5-day'})
% %lgd_duration=legend('2-Process, Workday/Free',   '2-Process with Constraints, Workday','2-Process with Constraints, Free','2-Process with U(L), Free','Location','SouthEastOutside')
% %lgd_duration=legend('2-Process, Workday', '2-Process, Free', '2-Process with U(L), Workday'  ,'2-Process with U(L), Free','Location','SouthEastOutside')
% lgd_duration=legend('2-Process, Workday', '2-Process, Free', '2-Process with Constraints, Workday'  ,'2-Process with Constraints, Free', '2-Process with U(L) and Constraints, Workday','2-Process with U(L) and Constraints, Free','Location','')




%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%    Duration plots, older version
% figure
% 
% t3=tiledlayout(2,1);
% %t3.Title.String = 'Sleep Duration and Social Jet Lag';
% 
% nexttile
% plot( DurationW_1, 6.3*ones(size(DurationW_1)),'-k', DurationW_11, 5*ones(size(DurationW_11)), '-',  DurationF_11, 4.1*ones(size(DurationF_11)),'-', DurationW_3, 3*ones(size(DurationW_3)),'-',  DurationF_3, 2.1*ones(size(DurationF_3)),'-', DurationW_13, 1*ones(size(DurationW_13)),'-',  DurationF_13, .1*ones(size(DurationF_13)),'-', 'LineWidth',11)
% xlabel('Time of Day')
% %title('Hours Asleep by Model')
% axis([22 32 -1 7 ])
% xticks([21:1:34])
% xticklabels({'21','22','23','24','1','2','3','4','5','6','7','8'})
% yticks([])
% %yticklabels({'Weekday, 7-day','Weekend, 7-day','Weekday, 5-day','Weekend,5-day'})
% %lgd_duration=legend('2-Process, Workday/Free',   '2-Process with Constraints, Workday','2-Process with Constraints, Free','2-Process with U(L), Free','Location','SouthEastOutside')
% %lgd_duration=legend('2-Process, Workday', '2-Process, Free', '2-Process with U(L), Workday'  ,'2-Process with U(L), Free','Location','SouthEastOutside')
% %lgd_duration=legend('2-Process, Workday', '2-Process, Free', '2-Process with Constraints, Workday'  ,'2-Process with Constraints, Free', '2-Process with U(L) and Constraints, Workday','2-Process with U(L) and Constraints, Free','Location','')
% 
% 
% lgdduration=legend('2-Process, Workday and Free', '2-Process with U(L), Workday', '2-Process with U(L),Free', '2-Process with Constraints, Workday'  ,'2-Process with Constraints, Free', '2-Process with U(L) and Constraints, Workday','2-Process with U(L) and Constraints, Free')
% lgdduration.Layout.Tile = 2;




%%%%%%%%  As used in submission %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure

t3=tiledlayout(2,1);
%t3.Title.String = 'Sleep Duration and Social Jet Lag';

nexttile
plot( DurationW_1, 6.3*ones(size(DurationW_1)),'-k', 'LineWidth',8)   
hold on

  

plot( DurationW_11, 5*ones(size(DurationW_11)), '-', 'LineWidth',8)   
hold on

plot( DurationF_11, 4.1*ones(size(DurationF_11)),'-', 'LineWidth',8) 
hold on

 

plot( DurationW_3, 2.8*ones(size(DurationW_3)),'-', 'LineWidth',8)
hold on

plot(  DurationF_3, 1.9*ones(size(DurationF_3)),'-',  'LineWidth',8)
hold on

  


plot( DurationW_13, .6*ones(size(DurationW_13)),'-', 'LineWidth',8) 
hold on

plot( DurationF_13, -.3*ones(size(DurationF_13)),'-', 'LineWidth',8)
hold on

%%% Dividing lines
 plot(22:39, 5.7*ones(size(22:39)),'-k','Linewidth', 0.8)
  hold on

 plot(22:39, 3.5*ones(size(22:39)),'-k','Linewidth', 0.8)
  hold on

  plot(22:39, 1.3*ones(size(22:39)),'-k','Linewidth', 0.8)
  hold on



xlabel('Time of Day')
%title('Hours Asleep by Model')
axis([22 32 -1 7 ])
xticks([21:1:34])
xticklabels({'21','22','23','24','1','2','3','4','5','6','7','8'})
yticks([])
%yticklabels({'Weekday, 7-day','Weekend, 7-day','Weekday, 5-day','Weekend,5-day'})
%lgd_duration=legend('2-Process, Workday/Free',   '2-Process with Constraints, Workday','2-Process with Constraints, Free','2-Process with U(L), Free','Location','SouthEastOutside')
%lgd_duration=legend('2-Process, Workday', '2-Process, Free', '2-Process with U(L), Workday'  ,'2-Process with U(L), Free','Location','SouthEastOutside')
%lgd_duration=legend('2-Process, Workday', '2-Process, Free', '2-Process with Constraints, Workday'  ,'2-Process with Constraints, Free', '2-Process with U(L) and Constraints, Workday','2-Process with U(L) and Constraints, Free','Location','')



lgddurationtest = legend({'2-Process (2PM), Workday and Free', '2-Process with U(L) (2PML), Workday', '2-Process with U(L) (2PML),Free', '2-Process with Constraints (2PMC), Workday'  ,'2-Process with Constraints (2PMC), Free', '2-Process with U(L) and Constraints (2PMLC), Workday','2-Process with U(L) and Constraints (2PMLC), Free'})
lgddurationtest.Layout.Tile = 2;


%lgddurationtest = legend([DurationW_1 DurationW_11 DurationF_11 DurationW_3 DurationF_3 DurationW_13 DurationF_13] ,{'2-Process, Workday and Free', '2-Process with U(L), Workday', '2-Process with U(L),Free', '2-Process with Constraints, Workday'  ,'2-Process with Constraints, Free', '2-Process with U(L) and Constraints, Workday','2-Process with U(L) and Constraints, Free'})
%lgddurationtest.Layout.Tile = 2;






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%















%%%%%%%%%%%%%%%  Matlab version of Dutch Sleep data, for consistency
%%%%%  Cut and paste from Time_correction.do (using edit).
figure

D=[ 1	7.493867	23.04394	8.293983	11.06847	11.26082;
    2	7.347917	23.0643	    8.340436	10.91504	11.00076;
    3	7.426657	23.09817	8.240673	10.92471	11.34602;
    4	7.368434	23.15883	8.294135	10.83922	11.19544;
    5	7.467905	23.61833	8.908917	10.86814	11.88874;
    6	8.538116	24.01824	9.063218	11.46896	14.1064;
    7	9.081724	23.03603	8.486482	11.73187	14.4976]


t4=tiledlayout(3,2);
%t1.Title.String = 'Unconstrained Model Comparison';

% Tile 1
nexttile
plot([1:7], D(1:7,2) ,'bo-')

%plot(Yaa','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
 axis([1 7 6 10])
 xticks(1:1:7)
 yticks(5:.5:9)

xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Offset, a')
axis('padded')


% Tile 2
nexttile
plot([1:7],D(1:7,3),'bo-')
%plot(Yss','o-')
%legend('2-Process','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Onset, s')
axis('padded')


% Tile 3
nexttile
plot([1:7],D(1:7,4),'bo-')
%plot(YSS','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Total Sleep, S')
axis('padded')

% Tile 4
nexttile
plot([1:7],D(1:7,6),'bo-')
%plot(YLL','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Leisure, L')
axis('padded')

% Tile 5
nexttile
plot([1:7],D(1:7,5),'bo-')
%plot(YKK','o-')
%title(lgd,'Model')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Stock, K')
axis('padded')

%lgd=legend('2-Process','2-Process with U(L)','Location','SouthEastOutside','FontSize',9)
%lgd = legend('2-Process','2-Process with U(L)','Location','best','FontSize',9);
lgd.Layout.Tile = 6;







STOP





%t3=tiledlayout(2,1);

%graycolor=[.2 .2 .2];

 plot( DurationW_1, 5*ones(size(DurationW_1)),'b', DurationF_1, 4.25*ones(size(DurationF_1)),'-g',DurationW_11, 3*ones(size(DurationW_11)),'r-',  DurationF_11, 2.25*ones(size(DurationF_11)),'c-',  'LineWidth',12)


xlabel('Time of Day')
title('Hours Asleep by Model')
axis([22 34 1 6])
xticks([21:1:34])
xticklabels({'21','22','23','24','1','2','3','4','5','6','7','8','9','10'})
yticks([])
%yticklabels({'Weekday, 7-day','Weekend, 7-day','Weekday, 5-day','Weekend,5-day'})
%lgd_duration=legend('2-Process, Workday/Free',   '2-Process with Constraints, Workday','2-Process with Constraints, Free','2-Process with U(L), Free','Location','SouthEastOutside')
%lgd_duration=legend('2-Process, Workday', '2-Process, Free', '2-Process with U(L), Workday'  ,'2-Process with U(L), Free','Location','SouthEastOutside')
lgd_duration=legend('2-Process, Workday', '2-Process, Free', '2-Process with U(L), Workday'  ,'2-Process with U(L), Free','Location','best')


subplot(3,2,6) ,
plot( DurationW_1, 5*ones(size(DurationW_1)),'k',        DurationW_3, 4*ones(size(DurationW_3)),'g-',  DurationF_3, 3.25*ones(size(DurationF_3)),'c-', DurationW_13, 2*ones(size(DurationW_13)),'m-',  DurationF_13, 1.25*ones(size(DurationF_13)),'y-', 'LineWidth',12)


xlabel('Time of Day')
title('Hours Asleep by Model')
axis([22 34 -1 6])
xticks([21:1:34])
xticklabels({'21','22','23','24','1','2','3','4','5','6','7','8','9','10'})
yticks([])
%yticklabels({'Weekday, 7-day','Weekend, 7-day','Weekday, 5-day','Weekend,5-day'})
%lgd_duration=legend('2-Process, Workday/Free',   '2-Process with Constraints, Workday','2-Process with Constraints, Free','2-Process with U(L), Free','Location','SouthEastOutside')
%lgd_duration=legend('2-Process, Workday', '2-Process, Free', '2-Process with U(L), Workday'  ,'2-Process with U(L), Free','Location','SouthEastOutside')
lgd_duration=legend('2-Process, Workday', '2-Process, Free', '2-Process with Constraints, Workday'  ,'2-Process with Constraints, Free', '2-Process with U(L) and Constraints, Workday','2-Process with U(L) and Constraints, Free','Location','')













Stop



figure

subplot(3,2,1),
plot([1:7],aa1(2,8:14),'bo-', [1:7],aa11(2,8:14),'r^-')

%plot(Yaa','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Offset, a')
axis('padded')

subplot(3,2,2),
plot([1:7],ss1(2,8:14),'bo-',  [1:7],ss11(2,8:14),'r^-' )
%plot(Yss','o-')
%legend('2-Process','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Onset, s')
axis('padded')


subplot(3,2,3),
plot([1:7],SS1(2,8:14),'bo-', [1:7],SS11(2,8:14),'r^-'  )
%plot(YSS','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Total Sleep, S')
axis('padded')


subplot(3,2,4),
plot([1:7],LL1(2,8:14),'bo-', [1:7], LL11(2,8:14),'r^-'  )
%plot(YLL','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Leisure, L')
axis('padded')


subplot(3,2,5),
plot([1:7],KK1(2,8:14),'bo-', [1:7],KK11(2,8:14),'r^-'  )
%plot(YKK','o-')
%title(lgd,'Model')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Stock, K')
axis('padded')
 %lgd=legend('2-Process','2-Process with U(L)','Location','SouthEastOutside','FontSize',9)
 lgd=legend('2-Process','2-Process with U(L)','Location','best','FontSize',9)

% subplot(3,2,6),
% plot([1:7],HH1(2,8:14),'ko-', [1:7],HH11(2,8:14),'r^-'  )
% %plot(YKK','o-')
% lgd=legend('2-Process','2-Process with U(L)','Location','SouthEastOutside','FontSize',9)
% %title(lgd,'Model')
% xticks(1:1:8)
% xticklabels({'M','T','W','Th','F','Sa','Su'})
% title('Sleep Pressure, H')
% axis('padded')
% 

%graycolor=[.2 .2 .2];
subplot(3,2,6) ,
 plot( DurationW_1, 5*ones(size(DurationW_1)),'b', DurationF_1, 4.25*ones(size(DurationF_1)),'-g',DurationW_11, 3*ones(size(DurationW_11)),'r-',  DurationF_11, 2.25*ones(size(DurationF_11)),'c-',  'LineWidth',12)


xlabel('Time of Day')
title('Hours Asleep by Model')
axis([22 34 1 6])
xticks([21:1:34])
xticklabels({'21','22','23','24','1','2','3','4','5','6','7','8','9','10'})
yticks([])
%yticklabels({'Weekday, 7-day','Weekend, 7-day','Weekday, 5-day','Weekend,5-day'})
%lgd_duration=legend('2-Process, Workday/Free',   '2-Process with Constraints, Workday','2-Process with Constraints, Free','2-Process with U(L), Free','Location','SouthEastOutside')
%lgd_duration=legend('2-Process, Workday', '2-Process, Free', '2-Process with U(L), Workday'  ,'2-Process with U(L), Free','Location','SouthEastOutside')
lgd_duration=legend('2-Process, Workday', '2-Process, Free', '2-Process with U(L), Workday'  ,'2-Process with U(L), Free','Location','best')




%%%%%%%%%%%%%%  New figure, models with constraints
figure

subplot(3,2,1),
plot([1:7],aa1(2,8:14),'ko-', [1:7],aa3(2,8:14),'bo-', [1:7],aa13(2,8:14),'r^-')

%plot(Yaa','o-')
%legend('2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Offset, a')
axis('padded')

subplot(3,2,2),
plot([1:7],ss1(2,8:14),'ko-', [1:7],ss3(2,8:14),'bo-',  [1:7],ss13(2,8:14),'r^-' )
%plot(Yss','o-')
%legend('2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Onset, s')
axis('padded')


subplot(3,2,3),
plot([1:7],SS1(2,8:14),'ko-', [1:7],SS3(2,8:14),'bo-', [1:7],SS13(2,8:14),'r^-'  )
%plot(YSS','o-')
%legend('2-Process with Constraints','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Total Sleep, S')
axis('padded')


subplot(3,2,4),
plot([1:7],LL1(2,8:14),'ko-', [1:7],LL3(2,8:14),'bo-', [1:7], LL13(2,8:14),'r^-'  )
%plot(YLL','o-')
%legend('2-Process with Constraints','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Leisure, L')
axis('padded')


subplot(3,2,5),
plot([1:7],KK1(2,8:14),'ko-',  [1:7],KK3(2,8:14),'bo-', [1:7],KK13(2,8:14),'r^-'  )
%plot(YKK','o-')
%title(lgd,'Model')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su'})
title('Sleep Stock, K')
axis('padded')

% subplot(3,2,6),
% plot([1:7],HH3(2,8:14),'ko-', [1:7],HH13(2,8:14),'r^-'  )
% %plot(YKK','o-')
% lgd=legend('2-Process with Constraints ','2-Process with U(L) and Constraints','Location','SouthEastOutside','FontSize',9)
% %title(lgd,'Model')
% xticks(1:1:8)
% xticklabels({'M','T','W','Th','F','Sa','Su'})
% title('Sleep Pressure, H')
% axis('padded')
% 




%graycolor=[.2 .2 .2];
subplot(3,2,6) ,
plot( DurationW_1, 5*ones(size(DurationW_1)),'k',        DurationW_3, 4*ones(size(DurationW_3)),'g-',  DurationF_3, 3.25*ones(size(DurationF_3)),'c-', DurationW_13, 2*ones(size(DurationW_13)),'m-',  DurationF_13, 1.25*ones(size(DurationF_13)),'y-', 'LineWidth',12)


xlabel('Time of Day')
title('Hours Asleep by Model')
axis([22 34 -1 6])
xticks([21:1:34])
xticklabels({'21','22','23','24','1','2','3','4','5','6','7','8','9','10'})
yticks([])
%yticklabels({'Weekday, 7-day','Weekend, 7-day','Weekday, 5-day','Weekend,5-day'})
%lgd_duration=legend('2-Process, Workday/Free',   '2-Process with Constraints, Workday','2-Process with Constraints, Free','2-Process with U(L), Free','Location','SouthEastOutside')
%lgd_duration=legend('2-Process, Workday', '2-Process, Free', '2-Process with U(L), Workday'  ,'2-Process with U(L), Free','Location','SouthEastOutside')
lgd_duration=legend('2-Process, Workday', '2-Process, Free', '2-Process with Constraints, Workday'  ,'2-Process with Constraints, Free', '2-Process with U(L) and Constraints, Workday','2-Process with U(L) and Constraints, Free','Location','')















stop














% %%%%%%%%%%  Newer, plot Sleep time Onset-Offset
% 
% SleepOnsetW=mean(ss1(2,7:11));   %use Week 2, Sunday-Thursday Work days
% SleepOnsetF=mean(ss1(2,12:13));  % ", Friday-Saturday Free Days
% SleepOffsetW=mean(aa1(2,8:12)) ;  %use Week 2, Monday-Friday
% SleepOffsetF=mean(aa1(2,13:14));   %use Week 2, Saturday-Sunday;
% DurationW_1  = SleepOnsetW:.0001:SleepOffsetW+24;
% DurationF_1 = SleepOnsetF:.0001:SleepOffsetF+24;
% 
% %%%%%%%%%%%%%  Alarm only
% SleepOnsetW=mean(ss(2,7:11));   %use Week 2, Sunday-Thursday Work days
% SleepOnsetF=mean(ss(2,12:13));  % ", Friday-Saturday Free Days
% SleepOffsetW=mean(aa(2,8:12)) ;  %use Week 2, Monday-Friday
% SleepOffsetF=mean(aa(2,13:14));   %use Week 2, Saturday-Sunday;
% DurationW_Alarm=  SleepOnsetW:.0001:SleepOffsetW+24;
% DurationF_Alarm=  SleepOnsetF:.0001:SleepOffsetF+24;
% 
% 
% %%%%%%%%%%% Alarm + Social constraint
% SleepOnsetW=mean(ss_2P_CKbar(2,7:11));   %use Week 2, Sunday-Thursday Work days
% SleepOnsetF=mean(ss_2P_CKbar(2,12:13));  % ", Friday-Saturday Free Days
% SleepOffsetW=mean(aa_2P_CKbar(2,8:12)) ;  %use Week 2, Monday-Friday
% SleepOffsetF=mean(aa_2P_CKbar(2,13:14));   %use Week 2, Saturday-Sunday;
% DurationW_2P_CKbar=  SleepOnsetW:.0001:SleepOffsetW+24;
% DurationF_2P_CKbar=  SleepOnsetF:.0001:SleepOffsetF+24;








% 
%   %%%%%%% 
% SleepOnsetW=mean(ss3(2,7:11));   %use Week 2, Sunday-Thursday Work days
% SleepOnsetF=mean(ss3(2,12:13));  % ", Friday-Saturday Free Days
% SleepOffsetW=mean(aa3(2,8:12)) ;  %use Week 2, Monday-Friday
% SleepOffsetF=mean(aa3(2,13:14));   %use Week 2, Saturday-Sunday;
% DurationW_3=  SleepOnsetW:.0001:SleepOffsetW+24;
% DurationF_3=  SleepOnsetF:.0001:SleepOffsetF+24;
% 
% 
% %%%%      SJL calculations
% 
% % Wittman et al. SJL:
% %% Midsleep on F(ree) and W(ork) days
% MSF=(mean(aa3(2,13:14))+24-mean(ss3(2,12:13)))/2 + mean(ss3(2,12:13));
% MSW=(mean(aa3(2,8:12))+24-mean(ss3(2,7:11)))/2 + mean(ss3(2,7:11));
% SJL=abs(MSF-MSW);
% 
% % Jankowski et al. SJL sleep corrected, from Caliandro et al. 2021
% MSF_SC=mean(ss3(2,12:13));
% MSW_SC=mean(ss3(2,7:11));
% SJL_SC=abs(MSF_SC-MSW_SC);
% 
% 
% 
% 
% %% Try using only week 2
% 
% Yaa=[aa1(2,15:21); aa_2P_CKbar(2,15:21); aa3(2,15:21)];
% Yss=[ss1(2,15:21); ss_2P_CKbar(2,15:21); ss3(2,15:21)];
% YSS=[SS1(2,15:21); SS_2P_CKbar(2,15:21); SS3(2,15:21)];
% YLL=[LL1(2,15:21); LL_2P_CKbar(2,15:21); LL3(2,15:21)];
% YKK=[KK1(2,15:21); KK_2P_CKbar(2,15:21); KK3(2,15:21)];








subplot(3,3,1),
plot([1:7],aa1(2,8:14),'ko-',  [1:7],aa(2,8:14),'gx-', [1:7],aa_2P_CKbar(2,8:14),'bd-', [1:7],aa3(2,8:14),'rs-', [1:7],aa_con(2,8:14),'c^-')

%plot(Yaa','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su','M'})
title('Sleep Offset, a')
axis('padded')

subplot(3,3,2),
plot([1:7],ss1(2,8:14),'ko-', [1:7], ss(2,8:14),'gx-', [1:7],ss_2P_CKbar(2,8:14),'bd-', [1:7],ss3(2,8:14),'rs-', [1:7],ss_con(2,8:14),'c^-'  )
%plot(Yss','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su','M'})
title('Sleep Onset, s')
axis('padded')


subplot(3,3,3),
plot([1:7],SS1(2,8:14),'ko-', [1:7], SS(2,8:14),'gx-',  [1:7],SS_2P_CKbar(2,8:14),'bd-',  [1:7],SS3(2,8:14),'rs-', [1:7],SS_con(2,8:14),'c^-'  )
%plot(YSS','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su','M'})
title('Total Sleep, S')
axis('padded')


subplot(3,3,4),
plot([1:7],LL1(2,8:14),'ko-', [1:7], LL(2,8:14),'gx-', [1:7],LL_2P_CKbar(2,8:14),'bd-', [1:7],LL3(2,8:14),'rs-', [1:7],LL_con(2,8:14),'c^-'  )
%plot(YLL','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su','M'})
title('Leisure, L')
axis('padded')


subplot(3,3,5),
plot([1:7],KK1(2,8:14),'ko-', [1:7],KK(2,8:14),'gx-', [1:7],KK_2P_CKbar(2,8:14),'bd-',  [1:7], KK3(2,8:14),'rs-', [1:7],KK_con(2,8:14),'c^-'  )
%plot(YKK','o-')
lgd=legend('2-Process','2-Process with Alarm'  , '2-Process with Constraints','2-Process with U(L)', '2-Process with U(L) and Constraints' ,'Location','SouthEastOutside','FontSize',9)
title(lgd,'Model')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su','M'})
title('Sleep Stock, K')
axis('padded')




graycolor=[.2 .2 .2];
subplot(3,3,6),
%plot(DurationW, 2*ones(size(DurationW)),'-k', DurationF,1*ones(size(DurationF)),'-r', 12:24:36,zeros(1,2),'.w', DurationW_7, 4*ones(size(DurationW_7)),'-b', DurationF_7,3*ones(size(DurationF_7)),'-g', 12:24:36,zeros(1,2),'.w', 'LineWidth',8)
%plot( DurationW_1, 6*ones(size(DurationW_1)),'-k',  DurationF_1, 5*ones(size(DurationF_1)),'m-', DurationW_Alarm, 6*ones(size(DurationW_Alarm)),'-m',  DurationF_Alarm, 5*ones(size(DurationF_Alarm)),'y-',  DurationW_2P_CKbar,4*ones(size(DurationW_2P_CKbar)),'-b', DurationF_2P_CKbar,3*ones(size(DurationF_2P_CKbar)),'-c', DurationW_3, 2*ones(size(DurationW_3)),'-r', DurationF_3, 1*ones(size(DurationF_3)),'-g',  'LineWidth',6)
 plot( DurationW_1, 7*ones(size(DurationW_1)),'-k'                                              ,DurationW_Alarm, 5.7*ones(size(DurationW_Alarm)),'-m',  DurationF_Alarm, 5*ones(size(DurationF_Alarm)),'y-',  DurationW_2P_CKbar,3.7*ones(size(DurationW_2P_CKbar)),'-b', DurationF_2P_CKbar,3*ones(size(DurationF_2P_CKbar)),'-c', DurationW_3, 1.7*ones(size(DurationW_3)),'-r', DurationF_3, 1*ones(size(DurationF_3)),'-g',  'LineWidth',12)


xlabel('Time of Day')
title('Hours Asleep by Model')
axis([22 34 0 8])
xticks([21:1:34])
xticklabels({'21','22','23','24','1','2','3','4','5','6','7','8','9','10'})
yticks([])
%yticklabels({'Weekday, 7-day','Weekend, 7-day','Weekday, 5-day','Weekend,5-day'})
lgd_duration=legend('2-Process, Workday/Free', '2-Process with Alarm, Workday', '2-Process with Alarm, Free', '2-Process with Constraints, Workday','2-Process with Constraints, Free','2-Process with U(L), Workday','2-Process with U(L), Free','Location','SouthEastOutside')




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Restricted: Fewer variables on the plots
newplot

subplot(3,3,1),
plot([1:7],aa1(2,8:14),'ko-', [1:7],aa_2P_CKbar(2,8:14),'bd-',  [1:7],aa_con(2,8:14),'c^-')

%plot(Yaa','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su','M'})
title('Sleep Offset, a')
axis('padded')

subplot(3,3,2),
plot([1:7],ss1(2,8:14),'ko-',  [1:7],ss_2P_CKbar(2,8:14),'bd-',  [1:7],ss_con(2,8:14),'c^-'  )
%plot(Yss','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su','M'})
title('Sleep Onset, s')
axis('padded')


subplot(3,3,3),
plot([1:7],SS1(2,8:14),'ko-', [1:7],SS_2P_CKbar(2,8:14),'bd-',  [1:7],SS_con(2,8:14),'c^-'  )
%plot(YSS','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su','M'})
title('Total Sleep, S')
axis('padded')


subplot(3,3,4),
plot([1:7],LL1(2,8:14),'ko-', [1:7],LL_2P_CKbar(2,8:14),'bd-', [1:7], LL_con(2,8:14),'c^-'  )
%plot(YLL','o-')
%legend('2-Process','2-Process with Constraints','2-Process with U(L)')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su','M'})
title('Leisure, L')
axis('padded')


subplot(3,3,5),
plot([1:7],KK1(2,8:14),'ko-', [1:7],KK_2P_CKbar(2,8:14),'bd-',   [1:7],KK_con(2,8:14),'c^-'  )
%plot(YKK','o-')
lgd=legend('2-Process','2-Process with Alarm'  , '2-Process with Constraints','2-Process with U(L)', '2-Process with U(L) and Constraints' ,'Location','SouthEastOutside','FontSize',9)
title(lgd,'Model')
xticks(1:1:8)
xticklabels({'M','T','W','Th','F','Sa','Su','M'})
title('Sleep Stock, K')
axis('padded')




graycolor=[.2 .2 .2];
subplot(3,3,6),
%plot(DurationW, 2*ones(size(DurationW)),'-k', DurationF,1*ones(size(DurationF)),'-r', 12:24:36,zeros(1,2),'.w', DurationW_7, 4*ones(size(DurationW_7)),'-b', DurationF_7,3*ones(size(DurationF_7)),'-g', 12:24:36,zeros(1,2),'.w', 'LineWidth',8)
%plot( DurationW_1, 6*ones(size(DurationW_1)),'-k',  DurationF_1, 5*ones(size(DurationF_1)),'m-', DurationW_Alarm, 6*ones(size(DurationW_Alarm)),'-m',  DurationF_Alarm, 5*ones(size(DurationF_Alarm)),'y-',  DurationW_2P_CKbar,4*ones(size(DurationW_2P_CKbar)),'-b', DurationF_2P_CKbar,3*ones(size(DurationF_2P_CKbar)),'-c', DurationW_3, 2*ones(size(DurationW_3)),'-r', DurationF_3, 1*ones(size(DurationF_3)),'-g',  'LineWidth',6)
 plot( DurationW_1, 7*ones(size(DurationW_1)),'-k'                                              ,DurationW_Alarm, 5.7*ones(size(DurationW_Alarm)),'-m',  DurationF_Alarm, 5*ones(size(DurationF_Alarm)),'y-',  DurationW_2P_CKbar,3.7*ones(size(DurationW_2P_CKbar)),'-b', DurationF_2P_CKbar,3*ones(size(DurationF_2P_CKbar)),'-c', DurationW_3, 1.7*ones(size(DurationW_3)),'-r', DurationF_3, 1*ones(size(DurationF_3)),'-g',  'LineWidth',12)


xlabel('Time of Day')
title('Hours Asleep by Model')
axis([22 34 0 8])
xticks([21:1:34])
xticklabels({'21','22','23','24','1','2','3','4','5','6','7','8','9','10'})
yticks([])
%yticklabels({'Weekday, 7-day','Weekend, 7-day','Weekday, 5-day','Weekend,5-day'})
lgd_duration=legend('2-Process, Workday/Free',   '2-Process with Constraints, Workday','2-Process with Constraints, Free','2-Process with U(L), Free','Location','SouthEastOutside')





