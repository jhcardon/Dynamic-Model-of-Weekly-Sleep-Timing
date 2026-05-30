%%%  WeeklySleep control function, Repeated for Weeks weeks.
%%% 8/1/2024 We all agree that Original (non-Genesis) is easie> 
%%% Genesis pros/cons: 1. dKt+1/dst=1, dKt+1/dat=(1-delta). That is, Sleeping in
%%%                     Saturday morning has little effect on Sunday K, but going to bed early
%%%                     on Saturday night does. Not obvious that this is better than Original
%                      2. More intuitive treatment of Sleep (conntinous, matches
%                       data work.
%                      3. Not recursive, so no Bellman. Could not get
%                      finite horizon "SS" to settle down.
%                      4. Non-standard treatment of variables, unusual in
%                      Economics.
%   Original pros/cons 1. at and st have same effect on Kt+1. One issue: getting up really early on day t will zero effect on Kt and Ht, which is not intuitive.                    
%                      2. Exogenous timing of all variables, all match same
%                      day.
%                      3. Can use Bellman for SS, calibration.
% 
%
%   Zero out U_L term, subract .6712 (or whatever) in H to recenter sleep
%   times.
%
%===>>> Go with Original this unless forced to try Genesis by referees. <<<===
clear all
global Aeq beq delta K8 chi sigma2 N C ii  NN KK SS SS_Genesis LL HH Kstar Lstar Hstar Aastar Ssstar Sstar aa ss Weeks scale
format short
fminconoptions = optimoptions('fmincon', 'MaxFunctionEvaluations', 100000,"EnableFeasibilityMode",true)

delta=.75;
K8=8/delta;
a_alarm=6;
s_social=23.5;

Weeks=5

C=2.5;
%% Weekend Phase Shift
C=kron(ones(1,Weeks),[2.5 2.5 2.5 2.5 2.5 3.5 3.5]);

ChiSigma2=[0.010222331	1;
            0.01849954	2;
            0.025338592	3;
            0.03597953	5;
            0.043876327	7;
            0.05252198	10;
            0.05688069	12;
            0.062028314	15;
            0.068200352	20;
            0.072530582	25;
            0.075736392	30;
            0.083080623	50];

%% Selected values of sigma2
ChiSigma2=[ 0.05252198	10;
            0.062028314	15;
            0.068200352	20;
            0.072530582	25;
            0.075736392	30];
            
ChiSigma2=[ 0.05252198	10;
            0.068200352	20;
            0.075736392	30];

% Choose one set of parameters
ChiSigma2=[0.068200352	20 ]


N=40/7*ones(1,7);% every day is the same. Steady State
%N=[8 8 8 8 8 0 0]; % 5 days, 40 hours
%N=[10 10 10 10 0 0 0]; % 4-day work week
%N=[5.7 5.7 5.7 5.7 5.7 5.75 5.75  ]

% Use for N_Nurses
% N=[12 12 12 0 0 0 0]; %Nursing M-W
% %N=[12 0 12 0 12 0 0 ] %Nursing MWF
% N=[0 0 0 0 12 12 12 ] % Nursing FSatSun

% Use for varying workweek
 %Nstacked=%[40/N*ones(1,14);
    %8 8 8 8 8 0 0 8 8 8 8 8 0 0;
    %10 10 10 10 0 0 0 10 10 10 10 0 0 0]
 Nstacked=[40/7*ones(1,7*Weeks);
     %40/7*ones(1,7*Weeks); % Uncomment to run only the 7-day week twice
     kron(ones(1,Weeks),[8 8 8 8 8 0 0]);
     kron(ones(1,Weeks),[8 8 8 8 8 0 0]); 
     kron(ones(1,Weeks),[10 10 10 10 0 0 0])]; 
 


 %Nstacked=[40/7*ones(1,7);
 %   40/7*ones(1,7);
 %   40/7*ones(1,7)]


X=1-delta;


%%%%%%%%%%%%%%%%%%%%%       New Constraints  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ###################### 1 #########################################
%%%%%%%%%%%%%%%%%%%%%%      MODEL 1

% %%% Terminal constraint only
 Aeq=zeros(14*Weeks);
 Aeq(14*Weeks,14*(Weeks-1)+1:14*Weeks) = [X^6	X^5 X^4	X^3	X^2	X	1	-X^6	-X^5	-X^4	-X^3	-X^2	-X	-1];   
 beq=[zeros(1,14*Weeks-1) K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  ) ]';

Aeq=[]
beq=[]


%%% Constrain EACH WEEK to satisfy the Sleep Capital constraint
%Aeq=kron(eye(Weeks), [X^6	X^5 X^4	X^3	X^2	X  1 -X^6	-X^5	-X^4	-X^3	-X^2	-X	-1]);
%beq=[(K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1)) ]*ones(1,Weeks)';


%Aeq=[zeros(1,14*(Weeks-1)) X^6	X^5 X^4	X^3	X^2	X	1	-X^6	-X^5	-X^4	-X^3	-X^2	-X	-1];
%beq=[K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  )]

% % %% Comparative dynamics: Constraint on 1-2 days.
% % %% "Constrained" to stay up to midnight on Fri and Sat of first week.
%  Aeq=zeros(3,14*Weeks);
%  Aeq(1,12)=[1];
%  Aeq(2,13)=1;
%  Aeq(3,:)=[zeros(1,14*(Weeks-1)) X^6	X^5 X^4	X^3	X^2	X	1	-X^6	-X^5	-X^4	-X^3	-X^2	-X	-1];
% % 
%  beq= [24 24 K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  )];




% % %%%%%%%%%%%%%%%%%%%%%%%%%% #2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a_alarm=6; 
% %%%% Alarm + Terminal constraint
% ZZ=zeros(14); ZZ(1:5,1:5)=eye(5); 
%  Aeq=kron(eye(Weeks),ZZ);
%  Aeq(14*Weeks,14*(Weeks-1)+1:14*Weeks) = [X^6	X^5 X^4	X^3	X^2	X	1	-X^6	-X^5	-X^4	-X^3	-X^2	-X	-1];
% 
% 
% %aaa=[a_alarm a_alarm a_alarm a_alarm a_alarm 0 0      0 0 0 0 s_social s_social 0  ];
% aaa=[a_alarm a_alarm a_alarm a_alarm a_alarm 0 0      0 0 0 0     0        0    0  ];
% beq=kron(ones(1,Weeks),aaa);
% beq(1,14*Weeks)=[ K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  ) ];
% beq=beq';
% 
% 
% % Aeq=[]
% % beq=[]


% %   #########################3##########################
% %%%%%%%%%%%%%%%%%%%%    MODEL 3
% 
%  % 7/5/2024 Valuable. This creates the Jet lag-like shift: a and s move together on weekends.
%  %         "Social constraint" of obligations on Friday and Saturday night overcomes incentive to sleep early on those days. 
% %          Need to compare with a utility based explanation.
% % Alarm + Friday/Saturday s_social + Terminal constraint
%  ZZ=zeros(14); ZZ(1:5,1:5)=eye(5); ZZ(12:13,12:13)=eye(2);
%  Aeq=kron(eye(Weeks),ZZ);
%  aaa=[a_alarm a_alarm a_alarm a_alarm a_alarm 0 0 0 0 0 0 s_social s_social 0];
%   
%  Aeq(14*Weeks,14*(Weeks-1)+1:14*Weeks) = [X^6	X^5 X^4	X^3	X^2	X	1	-X^6	-X^5	-X^4	-X^3	-X^2	-X	-1];
%  
%  beq=kron(ones(1,Weeks),aaa);
%  beq(1,14*Weeks)=[K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  )];
%  beq=beq';


 

% %%   ######################### 3a  ##########################
%  % 7/5/2024 Valuable. This creates the Jet lag-like shift: a and s move together on weekends.
%  %         "Social constraint" of obligations on Friday and Saturday night overcomes incentive to sleep early on those days. 
% %          Need to compare with a utility based explanation.
% % Alarm + Friday/Saturday s_social + Terminal constraint + WEEKLY
% % Constraint
%  ZZ=zeros(14); ZZ(1:5,1:5)=eye(5); ZZ(12:13,12:13)=eye(2);
%  Aeq=kron(eye(Weeks),ZZ);
%  aaa=[a_alarm a_alarm a_alarm a_alarm a_alarm 0 0 0 0 0 0 s_social s_social 0];
%   
%  %Aeq(14*Weeks,14*(Weeks-1)+1:14*Weeks) = [X^6	X^5 X^4	X^3	X^2	X	1	-X^6	-X^5	-X^4	-X^3	-X^2	-X	-1];
%  Aeq(14*Weeks-(Weeks-1):14*Weeks,:)=kron(eye(Weeks), [X^6	X^5 X^4	X^3	X^2	X  1 -X^6	-X^5	-X^4	-X^3	-X^2	-X	-1]);
% 
% 
% 
%  beq=kron(ones(1,Weeks),aaa);
%  beq(1,14*Weeks-(Weeks-1):14*Weeks)=[K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  )];
%  beq=beq';




 %%% Constrain each day to be the same + Terminal constraint
%% alarm constraint for this is in the loop below
% if Weeks>1
%    Aeq=zeros(14*Weeks);
%    for i=1:(Weeks-1)*14
%        Aeq(i,i)=1;
%        Aeq(i,i+14)=-1;
%    end
% Aeq(14*Weeks,14*(Weeks-1)+1:14*Weeks) = [X^6	X^5 X^4	X^3	X^2	X	1	-X^6	-X^5	-X^4	-X^3	-X^2	-X	-1];   
% beq=[zeros(1,14*Weeks-1) K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  ) ]';
% 
% else
% Aeq=zeros(14);
%  Aeq(1,14*(Weeks-1)+1:14*Weeks) = [X^6	X^5 X^4	X^3	X^2	X	1	-X^6	-X^5	-X^4	-X^3	-X^2	-X	-1];
%  beq=[  K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  ) zeros(1,14*Weeks -1)]';
%  end


 
 
 
 
 % Varying chi and sigma
%  for ii=1:length(ChiSigma2(:,1))
%    chi=ChiSigma2(ii,1);
%    sigma2=ChiSigma2(ii,2);

% Varying days of workweek 7,5 and 4.
  for ii=1:2;
    chi=ChiSigma2(1,1);
    sigma2=ChiSigma2(1,2);
    N=Nstacked(ii,:);

% %%%%%%%%%%%%%%%%%%%%   ALARM         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Modify constraints to add alarm on weekdays only
%  Aeq(14*(Weeks-1)+1:14*(Weeks-1)+5,1:5)=eye(5)*(N(1)==8);
%  beq=zeros(1,14*Weeks);
%  beq(14*Weeks)= K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  );
%  beq(14*(Weeks-1)+1:14*(Weeks-1)+5)= a_alarm*(N(1)==8);
%  %beq=[zeros(1,14*Weeks-1) K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  ) ]';
%  beq=beq';
%   
% if N(1)==8
%     Aeq(14*(Weeks)+1:14*(Weeks)+5,1:5)=eye(5);
%     beq=zeros(1,14*Weeks);
%     beq(14*Weeks)= K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  );
%     beq(14*(Weeks)+1:14*(Weeks)+5)= a_alarm;
%     %beq=[zeros(1,14*Weeks-1) K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  ) ]';
%     beq=beq';
%   elseif N(1)<8
%     Aeq(14*(Weeks)+1:14*(Weeks)+4,1:4)=eye(4);
%       beq=zeros(1,14*Weeks);
%       beq(14*Weeks)= K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  );
%       beq(14*(Weeks)+1:14*(Weeks)+4)= a_alarm;
%       %beq=[zeros(1,14*Weeks-1) K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  ) ]';
%       beq=beq';   
% 
% end








%Nurses. MTW, MWF F
N_Nurses= [12 12  12 0  0  0  0;
           12  0  12 0 12  0  0;
            0  0   0 0 12 12 12]
chi=ChiSigma2(1,1);
 sigma2=ChiSigma2(1,2);
 
% for ii=1:3;
% N=N_Nurses(ii,:)
% ii
 
%S0=[8 8 8 8 8 8 8];   
%THETA0=[6 6 6 6 6 6 6 18 18 18 18 18 18 18 6 6 6 6 6 6 6 18 18 18 18 18 18 18];

THETA0=kron(ones(1,Weeks),[6 6 6 6 6 6 6 18 18 18 18 18 18 18]);

[THETAstar, fval, exitflag]=fmincon(@WeeklySleep_Timing_Repeated_2Process_Genesis,THETA0,[],[],Aeq,beq,[],[],[],fminconoptions)


 NN(ii,1:7*Weeks)=N;
 SS(ii,1:7*Weeks)=Sstar;
 S_Genesis(1)=8;
 S_Genesis(2:length(Sstar))=Aastar(2:length(Sstar))+24-Ssstar(1:length(Sstar)-1);
 SS_Genesis(ii,1:7*Weeks)=S_Genesis;
 %Aastar(ii,1:7)=THETAstar(1:7);
 %Ssstar(ii,1:7)=THETAstar(8:14);
 aa(ii,1:7*Weeks)=Aastar;
 ss(ii,1:7*Weeks)=Ssstar;
 KK(ii,1:7*Weeks)=Kstar;
 LL(ii,1:7*Weeks)=Lstar;
 HH(ii,1:7*Weeks)=Hstar;
  
  end;


%  NN(i,:)=N;
%  SS(i,:)=S;
%  KK(i,:)=K;
%  LL(i,:)=L;
%  HH(i,:)=H;
 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vary chi and sigma2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% subplot(3,2,1),
%  plot(NN','-o');
%  xlabel('Day of the Week')
%  title('Hours Worked, $N$')
%  axis([1 7 0 12 ])
% subplot(3,2,2),
%  plot(SS','-o');
%  xlabel('Day of the Week')
%  title('Sleep, $S$')
% subplot(3,2,3),
%  plot(LL','o-');
%  xlabel('Day of the Week')
%  title('Leisure, $L$')
% subplot(3,2,4),
%  plot(KK','-o');
%  xlabel('Day of the Week')
%  title('Sleep Stock, $K$')
% subplot(3,2,5),
%  plot(HH','-o');
%  xlabel('Day of the Week')
%  title('Sleep Pressure, $H$')
% 
% %legend('\chi=10','\chi=15','\chi=20','\chi=25','\chi=30','location','bestoutside','FontSize',14)
% legend('\sigma^2=10','\sigma^2=20','\sigma^2=30','location','bestoutside','FontSize',14)
% sgtitle('40-hour, 5-day Work Week')
% sgtitle('36-hour, 3-day Work Week, MWF')
% sgtitle('36-hour, 3-day Work Week, MTW')
% sgtitle('36-hour, 3-day Work Week, FSatSun')

%% Nurses
% subplot(3,2,1),
%  plot(NN','-o');
%  xlabel('Day of the Week')
%  title('Hours Worked, N')
%  axis([1 7 -1 14 ])
% subplot(3,2,2),
%  plot(SS','-o');
%  xlabel('Day of the Week')
%  title('Sleep, S')
% subplot(3,2,3),
%  plot(LL','o-');
%  xlabel('Day of the Week')
%  title('Leisure, L')
% subplot(3,2,4),
%  plot(KK','-o');
%  xlabel('Day of the Week')
%  title('Sleep Stock, K')
% subplot(3,2,5),
%  plot(HH','-o');
%  xlabel('Day of the Week')
%  title('Sleep Pressure, H')
% 
% %legend('\chi=10','\chi=15','\chi=20','\chi=25','\chi=30','location','bestoutside','FontSize',14)
% legend('Mon-Tue-Wed','Mon-Wed-Fri','Fri-Sat-Sun','location','bestoutside','FontSize',14)
% %sgtitle('40-hour, 5-day Work Week')
% sgtitle('36-hour, 3-day Work Week') 

subplot(6,1,1),
 plot(aa','-o');
 xlabel('Day of the Week')
 title('Wake Time, a')
 axis([0 7*Weeks+.5 5 8 ])
 yticks(5:.5:10)
 xticks(1:1:7*Weeks)
 xticklabels({'M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su'})
%axis('padded')
%sgtitle('7-day and 5-day Work Weeks (40 Hours)')
legend('7-day Workweek','5-day Workweek','4-day','location','north','FontSize',10,'Orientation','horizontal')
%legend(5-day Workweek','4-day','location','north','FontSize',10,'Orientation','horizontal')


subplot(6,1,2),
 plot(ss','-o');
 xlabel('Day of the Week')
 title('Sleep Time, s')
 axis([0 7*Weeks+.5 21 24])
 yticks(16:1:24)
xticks(1:1:7*Weeks)
 xticklabels({'M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su'})
 %axis('padded')

 subplot(6,1,3),
 plot(SS','-o');
 xlabel('Day of the Week')
 title('Sleep, S')
 xticks(1:1:7*Weeks)
 yticks(5:1:16)
 axis([0 7*Weeks+.5 6 10])
 xticklabels({'M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su'})
% axis('padded')
%axis([0 7*Weeks+1 6.5 10 ])

subplot(6,1,4),
 plot(LL','o-');
 xlabel('Day of the Week')
 title('Leisure, L')
 xticks(1:1:7*Weeks)
 yticks(0:2:16)
 axis([0 7*Weeks+.5 6 17])
% axis([1 7*Weeks 6 10 ])
 xticklabels({'M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su'})
 
% axis([0 7*Weeks+.5 8 17 ])
 %axis('padded')

 
subplot(6,1,5),
 plot(KK','-o');
 xlabel('Day of the Week')
 title('Sleep Stock, K')
 axis([0 7*Weeks+.5 8 12])
xticks(1:1:7*Weeks)
xticklabels({'M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su'})
 %axis('padded')
 %yticks(10:2:20)
%axis([0 7*Weeks+.5 4 14 ])




%%%%%%%%%%  Newer, plot Sleep time Onset-Offset

SleepOnsetW=mean(ss(2,7:11));   %use Week 2, Sunday-Thursday Work days
SleepOnsetF=mean(ss(2,12:13));  % ", Friday-Saturday Free Days
SleepOffsetW=mean(aa(2,8:12)) ;  %use Week 2, Monday-Friday
SleepOffsetF=mean(aa(2,13:14));   %use Week 2, Saturday-Sunday;
%%%% 7-day work week
SleepOnsetW_7=mean(ss(1,7:11));   %use Week 2, Sunday-Thursday Work days
SleepOnsetF_7=mean(ss(1,12:13));  % ", Friday-Saturday Free Days
SleepOffsetW_7=mean(aa(1,8:12)) ;  %use Week 2, Monday-Friday
SleepOffsetF_7=mean(aa(1,13:14));   %use Week 2, Saturday-Sunday;


DurationW=  SleepOnsetW:.0001:SleepOffsetW+24;
DurationF=  SleepOnsetF:.0001:SleepOffsetF+24;
DurationW_7=  SleepOnsetW_7:.0001:SleepOffsetW_7+24;
DurationF_7=  SleepOnsetF_7:.0001:SleepOffsetF_7+24;

subplot(6,1,6),
%plot(DurationW, 2*ones(size(DurationW)),'-k', DurationF,1*ones(size(DurationF)),'-r', 12:24:36,zeros(1,2),'.w', DurationW_7, 4*ones(size(DurationW_7)),'-b', DurationF_7,3*ones(size(DurationF_7)),'-g', 12:24:36,zeros(1,2),'.w', 'LineWidth',8)
plot( DurationW_7, 4*ones(size(DurationW_7)),'-b', DurationF_7,3*ones(size(DurationF_7)),'-g', DurationW, 2*ones(size(DurationW)),'-k', DurationF,1*ones(size(DurationF)),'-r', 'LineWidth',8)

xlabel('Time of Day')
title('Hours Asleep, Weekday and Weekend, 5- and 7-day Workweeks')
axis([20 34 0 5])
xticks([21:1:34])
xticklabels({'21','22','23','24','1','2','3','4','5','6','7','8','9','10'})
yticks([])
%yticklabels({'Weekday, 7-day','Weekend, 7-day','Weekday, 5-day','Weekend,5-day'})

legend('Weekday, 7-day','Weekend, 7-day','Weekday, 5-day','Weekend, 5-day','location','bestoutside','FontSize',10)






% subplot(6,1,6),
% %plot(DurationW, 2*ones(size(DurationW)),'-k', DurationF,1*ones(size(DurationF)),'-r', 12:24:36,zeros(1,2),'.w', DurationW_7, 4*ones(size(DurationW_7)),'-b', DurationF_7,3*ones(size(DurationF_7)),'-g', 12:24:36,zeros(1,2),'.w', 'LineWidth',8)
% plot( DurationW_7, 4*ones(size(DurationW_7)),'-b', DurationF_7,3*ones(size(DurationF_7)),'-g', DurationW, 2*ones(size(DurationW)),'-k', DurationF,1*ones(size(DurationF)),'-r', 'LineWidth',8)
% %plot(DurationW, 2*ones(size(DurationW)),'-k', DurationF,1*ones(size(DurationF)),'-r', 'LineWidth',8)
% 
% 
% xlabel('Time of Day')
% %title('Hours Asleep, Weekday and Weekend, 5- and 7-day Workweeks')
% title('Hours Asleep, Weekday and Weekend, 5-day Workweek')
% axis([19 34 0 3])
% xticks([19:1:34])
% xticklabels({'19','20','21','22','23','24','1','2','3','4','5','6','7','8','9','10','11','12'})
% yticks([])
% %yticklabels({'Weekday, 7-day','Weekend, 7-day','Weekday, 5-day','Weekend,5-day'})
% 
% legend('Weekday, 7-day','Weekend, 7-day','Weekday, 5-day','Weekend, 5-day','location','bestoutside','FontSize',10)
% %legend('Weekday, 5-day','Weekend, 5-day','location','bestoutside','FontSize',10)


% Wittman et al. SJL:
MSF=(mean(aa(2,13:14))+24-mean(ss(2,12:13)))/2 + mean(ss(2,12:13))
MSW=(mean(aa(2,8:12))+24-mean(ss(2,7:11)))/2 + mean(ss(2,7:11))
SJL=abs(MSF-MSW)

% Jankowski et al. SJL sleep corrected, from Caliandro et al. 2021
MSF_SC=mean(ss(2,12:13));
MSW_SC=mean(ss(2,7:11));
SJL_SC=abs(MSF_SC-MSW_SC)





mean_a=mean(aa(:,8:7*Weeks-7)')';
variance_a=(std(aa(:,8:length(aa))')).^2'

mean_s=mean(ss(:,8:7*Weeks-7)')';
variance_s=(std(ss(:,8:length(ss))')).^2'

mean_S=mean(SS(:,8:7*Weeks-7)')';
variance_S=(std(SS(:,8:length(SS))')).^2'

uno=ones(1,7*Weeks-7); 
%means_a=kron(uno,mean_a')
%volatility_a
%volatility_a=   mean(abs(      )                        )

for iii=8:length(aa)
    V_a(:,iii)= (aa(:,iii)-mean_a).^2 -(aa(:,iii-1)-mean_a).^2;
    V_s(:,iii)= (ss(:,iii)-mean_s).^2 -(ss(:,iii-1)-mean_s).^2;
    V_S(:,iii)= (SS(:,iii)-mean_S).^2 -(SS(:,iii-1)-mean_S).^2;

end
volatility_a=1/(length(aa)-7)*sum(abs(V_a'))
volatility_s=1/(length(ss)-7)*sum(abs(V_s'))
volatility_S=1/(length(SS)-7)*sum(abs(V_S'))

TableOutput=[SJL SJL_SC MSF MSW MSF_SC MSW_SC]
TableOutput2=[mean_a'; mean_s'; mean_S'; variance_a'; variance_s'; variance_S'; volatility_a; volatility_s; volatility_S]


stop

















%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Older 4x2 graphs. Switched to above plots for paper.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Vary work week Nstacked
subplot(4,2,1),
 plot(NN(:,1:7)','-o');
 xlabel('Day of the Week')
 title('Hours Worked, N')
 axis([1 7 -1 12 ])
xticklabels({'M','T','W','Th','F','Sa','Su'})
axis('padded')

 subplot(4,2,2),
 plot(SS','-o');
 xlabel('Day of the Week')
 title('Sleep, S')
 xticks(1:1:7*Weeks)
 %yticks(6.5:.5:10)
 xticklabels({'M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su'})
 axis('padded')
%axis([0 7*Weeks+1 6.5 10 ])

subplot(4,2,3),
 plot(LL','o-');
 xlabel('Day of the Week')
 title('Leisure, L')
 xticks(1:1:7*Weeks)
% yticks(8:17)
% axis([1 7*Weeks 6 10 ])
 xticklabels({'M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su'})
 
% axis([0 7*Weeks+.5 8 17 ])
 axis('padded')


subplot(4,2,4),
 plot(KK','-o');
 xlabel('Day of the Week')
 title('Sleep Stock, K')
xticks(1:1:7*Weeks)
xticklabels({'M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su'})
 axis('padded')
%axis([0 7*Weeks+.5 8 14 ])

% subplot(3,2,5),
%  plot(HH','-o');
%  xlabel('Day of the Week')
%  title('Sleep Pressure, H')

subplot(4,2,5),
 plot(aa','-o');
 xlabel('Day of the Week')
 title('Wake Time, a')
 axis([0 7*Weeks+.5 5 8 ])
 yticks(5:.5:8)
 xticks(1:1:7*Weeks)
 xticklabels({'M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su'})
axis('padded')

subplot(4,2,6),
 plot(ss','-o');
 xlabel('Day of the Week')
 title('Sleep Time, s')
 axis([0 7*Weeks+.5 21 24])
xticks(1:1:7*Weeks)
 xticklabels({'M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su'})
 axis('padded')

%legend('\chi=10','\chi=15','\chi=20','\chi=25','\chi=30','location','bestoutside','FontSize',14)
legend('7-day','5-day','4-day','location','bestoutside','FontSize',14)
%sgtitle('40-hour, 5-day Work Week')
%sgtitle('36-hour, 3-day Work Week, MWF')
% sgtitle('36-hour, 3-day Work Week, MTW')
% sgtitle('36-hour, 3-day Work Week, FSatSun')
% sgtitle('7-day and 5-day Work Weeks (40 Hours)')
%  

% %%%%% plotting time Awake, old
% Aw=aa(2,8);
% Sw=ss(2,8);
% Ae=aa(2,13);
% Se=ss(2,13);
% 
% D1=Aw:.00001:Sw; % Using 2nd Monday of series
% D2=Ae:.00001:Se;  % Using 2nd Saturday of Series
% 
% subplot(4,2,7),
% plot(D1, 1*ones(size(D1)),'-k', D2,2*ones(size(D2)),'-r', 1:24:24,zeros(1,2),'.w','LineWidth',15)
% xlabel('Time of Day')
% title('Hours Awake, Weekday and Weekend')
% axis([0 25 0 3])
% xticks([0:2:24])
% yticks([1 2])
% yticklabels({'Weekday','Weekend'})

%%%%%%%%%%  Newer, plot Sleep time Onset-Offset

SleepOnsetW=mean(ss(2,7:11));   %use Week 2, Sunday-Thursday Work days
SleepOnsetF=mean(ss(2,12:13));  % ", Friday-Saturday Free Days
SleepOffsetW=mean(aa(2,8:12)) ;  %use Week 2, Monday-Friday
SleepOffsetF=mean(aa(2,13:14));   %use Week 2, Saturday-Sunday;
%%%% 7-day work week
SleepOnsetW_7=mean(ss(1,7:11));   %use Week 2, Sunday-Thursday Work days
SleepOnsetF_7=mean(ss(1,12:13));  % ", Friday-Saturday Free Days
SleepOffsetW_7=mean(aa(1,8:12)) ;  %use Week 2, Monday-Friday
SleepOffsetF_7=mean(aa(1,13:14));   %use Week 2, Saturday-Sunday;


DurationW=  SleepOnsetW:.0001:SleepOffsetW+24;
DurationF=  SleepOnsetF:.0001:SleepOffsetF+24;
DurationW_7=  SleepOnsetW_7:.0001:SleepOffsetW_7+24;
DurationF_7=  SleepOnsetF_7:.0001:SleepOffsetF_7+24;

subplot(4,2,7),
plot(DurationW, 3*ones(size(DurationW)),'-k', DurationF,4*ones(size(DurationF)),'-r', 12:24:36,zeros(1,2),'.w', DurationW_7, 1*ones(size(DurationW_7)),'-b', DurationF_7,2*ones(size(DurationF_7)),'-g', 12:24:36,zeros(1,2),'.w', 'LineWidth',8)
xlabel('Time of Day')
title('Hours Asleep, Weekday and Weekend, 5- and 7-day Workweeks')
axis([18 34 0 5])
xticks([21:1:34])
xticklabels({'21','22','23','24','1','2','3','4','5','6','7','8','9','10'})
yticks([1 2 3 4])
yticklabels({'Weekday, 7-day','Weekend, 7-day','Weekday, 5-day','Weekend,5-day'})



%%%%%   Sleep Weekday Sleep Weekend K Weekday K Weekend
Means=[mean(SS(1,8:12)) mean(SS(2,8:12)') mean(SS(2,13:14)') mean(SS(2,8:14)') mean(KK(1,8:12)) mean(KK(2,8:12)') mean(KK(2,13:14)') mean(KK(2,8:14)') ]

subplot(4,2,8),
  bar(Means)
  xticklabels({'Sleep, 5-day','Sleep Weekday','Sleep Weekend','Sleep Weekly','K,5-day','K Weekday','K Weekend','K Weekly'})
  yticks(0:2:12)
  axis([.25 8.5 0 12.5])

%load handel.mat;
%load gong.mat;
%sound(y);



%%% Run the model, then run these, commenting out as needed.
%%%%%%%%%%%%%%%% Model 1, base 2-process model
aa1=aa
ss1=ss
SS1=SS
LL1=LL
KK1=KK
HH1=HH
save('Results_combined','aa1','ss1','SS1','KK1','HH1','LL1')

%%%%%%%%%%%%%%% Model 3, 2-process contrained
aa3=aa
ss3=ss
SS3=SS
LL3=LL
KK3=KK
HH3=HH
save('Results_combined','aa3','ss3','SS3','KK3','HH3','LL3', '-append')






















