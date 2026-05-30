%%%  WeeklySleep control function, Repeated for Weeks weeks.
clear all
global Aeq beq  K8 delta chi sigma2 N  ii  NN KK SS LL HH Kstar Lstar Hstar Aastar Ssstar Sstar Cstar aa ss Weeks scale a8 C
format short
fminconoptions = optimoptions('fmincon', 'MaxFunctionEvaluations', 1000000,"EnableFeasibilityMode",true,'StepTolerance',1e-8)

delta=.75;  %% Baseline is 0.75
Kbar=8/delta;
a_alarm=6;
s_social=23.5
K8=Kbar


Weeks=5
C=2.5;
%% weekend phase shift
%C=kron(ones(1,Weeks),[2.5 2.5 2.5 2.5 2.5 3.5 3.5]);
            
ChiSigma2=[ 0.05252198	10;
            0.068200352	20;
            0.075736392	50];

% Choose one set of parameters
ChiSigma2=[0.068200352	20 ] %% Baseline parameters Chi and Sigma2

%%% For sensitivity analysis. 
%ChiSigma2=[0.068200352*1.5 20 ] %% sim1


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
          %[0*ones(1,7*Weeks)                   ];
   %40/7*ones(1,7*Weeks); %Uncomment to run 7-day workweek twice
    kron(ones(1,Weeks),[8 8 8 8 8 0 0]);
    kron(ones(1,Weeks),[10 10 10 10 0 0 0])];


 %Nstacked=[40/7*ones(1,7);
 %   40/7*ones(1,7);
 %   40/7*ones(1,7)]


X=1-delta;


%%%%%%%%%%%%%%%%%%%%%       New Constraints  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%                     Unconstrained        Model 1
% Aeq(14*Weeks,14*(Weeks-1)+1:14*Weeks) = [1  X^6	X^5 X^4	X^3	X^2	X   -X^6	-X^5	-X^4	-X^3	-X^2	-X	-1];   
%   beq=[zeros(1,14*Weeks-1) (K8*(1-X^7)-0-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  )) ]';
Aeq=[];
beq=[];



% %%% Terminal constraint only Non-Genesis Version
% Aeq=zeros(14*Weeks);
% Aeq(14*Weeks,14*(Weeks-1)+1:14*Weeks) = [X^6	X^5 X^4	X^3	X^2	X	1	-X^6	-X^5	-X^4	-X^3	-X^2	-X	-1];   
% beq=[zeros(1,14*Weeks-1) K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  ) ]';


% % %%% Terminal constraint only GENESIS. Note that a1 doesn't matter and
% % that a8 is pre-determined. Let's try setting a8=a1 for now
%  Aeq=zeros(14*Weeks);
% 
  a8=6
%  %%%% strictly correct: a8 predetermined. 
%    Aeq(14*Weeks,14*(Weeks-1)+1:14*Weeks) = [0  X^6	X^5 X^4	X^3	X^2	X   -X^6	-X^5	-X^4	-X^3	-X^2	-X	-1];   
%    beq=[zeros(1,14*Weeks-1) (K8*(1-X^7)- a8 -24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1)) ]';
% 
%   % Simplified to remove rows of zeros from Aeq and beq
%   Aeq=[zeros(1, 14*(Weeks-1)) 0  X^6	X^5 X^4	X^3	X^2	X   -X^6	-X^5	-X^4	-X^3	-X^2	-X	-1];   
%   beq=[(K8*(1-X^7)- a8 -24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1)) ]';




    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% %%%%%%%%%%%% MODEL 11
%   %%%%%%%%%%%%%%%%%%%%%%%% 1/2/2025 rework
%   %%%%%%%%%%%%%%   Genesis, Terminal constraint only
%   K0=Kbar;
%   K8=8/delta;
%   s0=22.5;
%   a8=6.5;
%   
% Aeq=[zeros(1, 14*(Weeks-1)) X^7  X^6	X^5 X^4	X^3	X^2	X   -X^6	-X^5	-X^4	-X^3	-X^2	-X	-1]; 
% Aeq(1,14*(Weeks-1))=-X^7;
% beq=[(K8- X^8*K0 -a8 - 24*(X^7 + X^6 +X^5 + X^4+ X^3+X^2 + X +1)) ]';
%   
% % % %%%%%%%%%%%%%%%%%%%%%%%%  1/16/2025
% % % %%%%%%% Weekly Constraint
% %      
% %    %%%% For Middle weeks
% %    Aeq=kron(eye(Weeks), [X^7 X^6	X^5 X^4	X^3	X^2	X  -X^6	-X^5	-X^4	-X^3	-X^2	-X	-1]);
% %    %Aeq(1,15)=1; %% here adjusting for actual a(8), using s(7) (THETAstar(15)) is fine.
% %    beq=[[(K8- X^8*K0   - 24*(X^7 + X^6 +X^5 + X^4+ X^3+X^2 + X +1)) ]*ones(1,Weeks)]';
% %    %% corrections:
% %    for j=2:(Weeks-1)
% %        Aeq(j,14*(j)+1)=1;
% %        Aeq(j,14*(j-1))=-X^7;
% %    end;
% 
%  %%% for week=1. Here using actual a(8) and initial s0.
% %   Aeq(1,1:14)= [X^7 X^6	X^5 X^4	X^3	X^2	X  -X^6	-X^5	-X^4	-X^3	-X^2	-X	-1];
%    Aeq(1,15)=1; %%(a(8))
%    beq(1,1)= (K8- X^8*K0   - 24*(X^7 + X^6 +X^5 + X^4+ X^3+X^2 + X +1))+s0*X^7;
% % 
% 
% %  %%%% for week=Weeks. Here using fixed terminal a8 (a_T+1), actual s(7)
% %   Aeq(Weeks,14*(Weeks-1)+1:14*Weeks)= [X^7 X^6	X^5 X^4	X^3	X^2	X  -X^6	-X^5	-X^4	-X^3	-X^2	-X	-1];
%    Aeq(Weeks, (Weeks-1)*14)=-X^7; % Replace zero with 1 to capture "s0"
%    beq(Weeks,1)=(K8- X^8*K0   - 24*(X^7 + X^6 +X^5 + X^4+ X^3+X^2 + X +1)) - a8;
% 
%  
% Aeq=[]
% beq=[]

% %%% 1/9/25 Constraints vary by Week.
%  K0=Kbar;
%   K8=8/.75
%   s0=22.5;
%   a8=6.5;
% 
%   Aeq()



%  %%%% Constrain EACH WEEK to satisfy the Sleep Capital constraint
%  Aeq=kron(eye(Weeks), [0  X^6	X^5 X^4	X^3	X^2	X   -X^6	-X^5	-X^4	-X^3	-X^2	-X	-1]);
%  beq=[(K8*(1-X^7)- a8 -24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1)) ]*ones(1,Weeks)';
%  
% %%% 11/15/24 Test
% %%%% Constrain EACH WEEK to satisfy the Sleep Capital constraint
%  Aeq=kron(eye(Weeks), [X^6	X^5 X^4	X^3	X^2	X  1 -X^6	-X^5	-X^4	-X^3	-X^2	-X	-1]);
%  beq=[(K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1)) ]*ones(1,Weeks)';
%  beq(1,1)= (K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1));
% 


% %%%% Going back many periods from period T
% %% Two weeks instead of 1
% Aeq=[zeros(1, 14*(Weeks-2)) 0  X^13	X^12 X^11	X^10	X^9	X^8   -X^13	-X^12	-X^11	-X^10	-X^9	-X^8	-X^7  X^7  X^6	X^5 X^4	X^3	X^2	X   -X^6	-X^5	-X^4	-X^3	-X^2	-X	-1];
% beq=[(K8*(1-X^14)- a8 -24*(X^13 +X^12 + X^11+ X^10+X^9 + X^8 +X^7 + X^6 +X^5 + X^4+ X^3+X^2 + X +1)) ]';
 
 
%  %% Cheating: use a8=a1 in the constraint, so 1 as first term in last line of Aeq and no a8 in beq.
%    Aeq(14*Weeks,14*(Weeks-1)+1:14*Weeks) = [1  X^6	X^5 X^4	X^3	X^2	X   -X^6	-X^5	-X^4	-X^3	-X^2	-X	-1];   
%    beq=[zeros(1,14*Weeks-1) (K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  )) ]';





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




% %%%% Alarm + Terminal constraint
% ZZ=zeros(14); ZZ(1:5,1:5)=eye(5); 
%  Aeq=kron(eye(Weeks),ZZ);
%  Aeq(14*Weeks,14*(Weeks-1)+1:14*Weeks) = [X^6	X^5 X^4	X^3	X^2	X	1	-X^6	-X^5	-X^4	-X^3	-X^2	-X	-1];
% 
% aaa=[a_alarm a_alarm a_alarm a_alarm a_alarm 0 0 0 0 0 0 0 0 0];
% beq=kron(ones(1,Weeks),aaa);
% beq(1,14*Weeks)=[ K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  ) ];
% beq=beq';







% %%%%%%%%%%%%%%%   MODEL 13
% %  7/5/2024 Valuable. This creates the Jet lag-like shift: a and s move together on weekends.
% %           "Social constraint" of obligations on Friday and Saturday night overcomes incentive to sleep early on those days. 
% %           Need to compare with a utility based explanation.
% %% Alarm + Friday/Saturday s_social + Terminal constraint
%  
%  ZZ=zeros(14); ZZ(1:5,1:5)=eye(5); ZZ(12:13,12:13)=eye(2);
%  Aeq=kron(eye(Weeks),ZZ);
%  aaa=[a_alarm a_alarm a_alarm a_alarm a_alarm 0 0 0 0 0 0 s_social s_social 0];
%   
%  Aeq(14*Weeks,14*(Weeks-1)+1:14*Weeks) = [X^6	X^5 X^4	X^3	X^2	X	1	-X^6	-X^5	-X^4	-X^3	-X^2	-X	-1];
%  
%  beq=kron(ones(1,Weeks),aaa);
%  beq(1,14*Weeks)=[K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  )];
%  beq=beq';



%  %%% Constrain each day to be the same + Terminal constraint
% % alarm constraint for this is in the loop below
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
% 

 
 
 
 
 % Varying chi and sigma
%  for ii=1:length(ChiSigma2(:,1))
%    chi=ChiSigma2(ii,1);
%    sigma2=ChiSigma2(ii,2);

% Varying days of workweek 7,5 and 4.
  for ii=1:2;
    chi=ChiSigma2(1,1);
    sigma2=ChiSigma2(1,2);
    N=Nstacked(ii,:);

%%%%%%%%%%%%%%%%%%%%%   ALARM         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Modify constraints to add alarm on weekdays only
%  Aeq(14*(Weeks-1)+1:14*(Weeks-1)+5,1:5)=eye(5)*(N(1)==8);
%  beq=zeros(1,14*Weeks);
%  beq(14*Weeks)= K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  );
%  beq(14*(Weeks-1)+1:14*(Weeks-1)+5)= a_alarm*(N(1)==8);
%  %beq=[zeros(1,14*Weeks-1) K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  ) ]';
%  beq=beq';
  
% if N(1)==8
%     Aeq(14*(Weeks)+1:14*(Weeks)+5,1:5)=eye(5);
%     beq=zeros(1,14*Weeks);
%     beq(14*Weeks)= K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  );
%     beq(14*(Weeks)+1:14*(Weeks)+5)= a_alarm;
%     %beq=[zeros(1,14*Weeks-1) K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  ) ]';
%     beq=beq';
%   elseif N(1)==10
%     Aeq(14*(Weeks)+1:14*(Weeks)+4,1:4)=eye(4);
%       beq=zeros(1,14*Weeks);
%       beq(14*Weeks)= K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  );
%       beq(14*(Weeks)+1:14*(Weeks)+4)= a_alarm;
%       %beq=[zeros(1,14*Weeks-1) K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  ) ]';
%       beq=beq';   

%end








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

THETA0=kron(ones(1,Weeks),[6.5 6.5 6.5 6.5 6.5 6.5 6.5 23 23 23 23 23 23 23]);

%[THETAstar, fval, exitflag]=fmincon(@WeeklySleep_Timing_Repeated_Genesis,THETA0,[],[],Aeq,beq,[],[],[],fminconoptions)
[THETAstar, fval, exitflag]=fmincon(@WeeklySleep_Timing_Repeated_Genesis,THETA0,[],[],Aeq,beq,[],[],[],fminconoptions)
                                        
 NN(ii,1:7*Weeks)=N;
 SS(ii,1:7*Weeks)=Sstar;
 %Aastar(ii,1:7)=THETAstar(1:7);
 %Ssstar(ii,1:7)=THETAstar(8:14);
 aa(ii,1:7*Weeks)=Aastar;
 ss(ii,1:7*Weeks)=Ssstar;
 KK(ii,1:7*Weeks)=Kstar;
 LL(ii,1:7*Weeks)=Lstar;
 HH(ii,1:7*Weeks)=Hstar;
 C=Cstar;

  
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
figure
subplot(7,1,1),
 plot(aa','-o') % plot all
  %plot(aa(:,  7*(Weeks-8)/2:7*Weeks/2)','-o')          % plot 4 weeks in middle of range
 xlabel('Day of the Week')
 title('Wake Time, a')
 axis([0 7*Weeks+.5 5 8 ])
  %axis([0 7*4+.5 5 8 ])
 yticks(5:.5:8)
 xticks(1:1:7*Weeks)
  %xticks(1:1:7*4)
 xticklabels({'M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su'})
axis('padded')

subplot(7,1,2),
 plot(ss','-o');
  %plot(ss(:,  7*(Weeks-8)/2:7*Weeks/2)','-o')          % plot 4 weeks in middle of range
 xlabel('Day of the Week')
 title('Sleep Time, s')
 axis([0 7*Weeks+.5 21 24])
  %axis([0 7*4+.5 21 24])
xticks(1:1:7*Weeks)
 %xticks(1:1:7*4)
 xticklabels({'M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su'})
 axis('padded')

 subplot(7,1,3),
 plot(SS','-o');
 %plot(SS(:,  7*(Weeks-8)/2:7*Weeks/2)','-o')
 xlabel('Day of the Week')
 title('Sleep, S')
 xticks(1:1:7*Weeks)
 %xticks(1:1:7*4)
 %yticks(6.5:.5:10)
 xticklabels({'M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su'})
 axis('padded')
%axis([0 7*Weeks+1 6.5 10 ])

subplot(7,1,4),
 plot(LL','o-');
  %plot(LL(:,  7*(Weeks-8)/2:7*Weeks/2)','-o')
 xlabel('Day of the Week')
 title('Leisure, L')
 xticks(1:1:7*Weeks)
  %xticks(1:1:7*4)
% yticks(8:17)
% axis([1 7*Weeks 6 10 ])
 xticklabels({'M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su'})
 
% axis([0 7*Weeks+.5 8 17 ])
 axis('padded')


 
subplot(7,1,5),
 plot(KK','-o');
  %plot(KK(:,  7*(Weeks-8)/2:7*Weeks/2)','-o')
 xlabel('Day of the Week')
 title('Sleep Stock, K')
xticks(1:1:7*Weeks)
 %xticks(1:1:7*4)
xticklabels({'M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su'})
 axis('padded')
%axis([0 7*Weeks+.5 4 14 ])

sgtitle('7-day and 5-day Work Weeks (40 Hours)')
%legend('7-day','5-day','4-day','location','south','FontSize',10,'Orientation','horizontal')

subplot(7,1,6),
 plot(HH','-o');
  %plot(HH(:,  7*(Weeks-8)/2:7*Weeks/2)','-o')
 xlabel('Day of the Week')
 title('Sleep Pressure, H')
xticks(1:1:7*Weeks)
 %xticks(1:1:7*4)
xticklabels({'M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su'})
 axis('padded')
%axis([0 7*Weeks+.5 4 14 ])

% subplot(7,1,7),
%  plot(Cstar','-o');
%    %plot(Cstar(:,  7*(Weeks-8)/2:7*Weeks/2)','-o')
%  xlabel('Day of the Week')
%  title('Phase Shift, C')
% xticks(1:1:7*Weeks)
%   %xticks(1:1:7*4)
% xticklabels({'M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su','M','T','W','Th','F','Sa','Su'})
%  axis('padded')
% %axis([0 7*Weeks+.5 4 14 ])


sgtitle('7-day and 5-day Work Weeks (40 Hours)')
%legend('7-day','5-day','4-day','location','south','FontSize',10,'Orientation','horizontal')


% 
% %%%%%%%%%%%%%%%%%%%  RESTORE LATER (replaced with H for model selection
% %%%%%%%%%%  Newer, plot Sleep time Onset-Offset
% 
% SleepOnsetW=mean(ss(2,7:11));   %use Week 2, Sunday-Thursday Work days
% SleepOnsetF=mean(ss(2,12:13));  % ", Friday-Saturday Free Days
% SleepOffsetW=mean(aa(2,8:12)) ;  %use Week 2, Monday-Friday
% SleepOffsetF=mean(aa(2,13:14));   %use Week 2, Saturday-Sunday;
% %%%% 7-day work week
% SleepOnsetW_7=mean(ss(1,7:11));   %use Week 2, Sunday-Thursday Work days
% SleepOnsetF_7=mean(ss(1,12:13));  % ", Friday-Saturday Free Days
% SleepOffsetW_7=mean(aa(1,8:12)) ;  %use Week 2, Monday-Friday
% SleepOffsetF_7=mean(aa(1,13:14));   %use Week 2, Saturday-Sunday;
% 
% 
% DurationW=  SleepOnsetW:.0001:SleepOffsetW+24;
% DurationF=  SleepOnsetF:.0001:SleepOffsetF+24;
% DurationW_7=  SleepOnsetW_7:.0001:SleepOffsetW_7+24;
% DurationF_7=  SleepOnsetF_7:.0001:SleepOffsetF_7+24;
% 
% subplot(6,1,6),
% %plot(DurationW, 2*ones(size(DurationW)),'-k', DurationF,1*ones(size(DurationF)),'-r', 12:24:36,zeros(1,2),'.w', DurationW_7, 4*ones(size(DurationW_7)),'-b', DurationF_7,3*ones(size(DurationF_7)),'-g', 12:24:36,zeros(1,2),'.w', 'LineWidth',8)
% plot( DurationW_7, 4*ones(size(DurationW_7)),'-b', DurationF_7,3*ones(size(DurationF_7)),'-g', DurationW, 2*ones(size(DurationW)),'-k', DurationF,1*ones(size(DurationF)),'-r', 'LineWidth',8)
% 
% xlabel('Time of Day')
% title('Hours Asleep, Weekday and Weekend, 5- and 7-day Workweeks')
% axis([22 34 0 5])
% xticks([22:1:34])
% xticklabels({'21','22','23','24','1','2','3','4','5','6','7','8','9','10'})
% yticks([])
% %yticklabels({'Weekday, 7-day','Weekend, 7-day','Weekday, 5-day','Weekend,5-day'})

%legend('Weekday, 7-day','Weekend, 7-day','Weekday, 5-day','Weekend, 5-day','location','bestoutside','FontSize',10)


stop

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Older 4x2 graphs. Switched to above plots for paper.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%% Vary work week Nstacked
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


%legend('7-day','5-day','4-day','location','bestoutside','FontSize',14)

%sgtitle('40-hour, 5-day Work Week')
%sgtitle('36-hour, 3-day Work Week, MWF')
% sgtitle('36-hour, 3-day Work Week, MTW')
% sgtitle('36-hour, 3-day Work Week, FSatSun')
 sgtitle('7-day and 5-day Work Weeks (40 Hours)')
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
axis([21 34 0 5])
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

% Wittman et al. SJL:
MSF=(mean(aa(2,13:14))+24-mean(ss(2,12:13)))/2 + mean(ss(2,12:13))
MSW=(mean(aa(2,8:12))+24-mean(ss(2,7:11)))/2 + mean(ss(2,7:11))
SJL=abs(MSF-MSW)

% Jankowski et al. SJL sleep corrected, from Caliandro et al. 2021
MSF_SC=mean(ss(2,12:13));
MSW_SC=mean(ss(2,7:11));
SJL_SC=abs(MSF_SC-MSW_SC)



Stop



% %%% Run the model, then run these, commenting out as needed.
% %%%%%%%%%%%%%%%% Model 11, Utility model, terminal constraint only
aa11=aa
ss11=ss
SS11=SS
LL11=LL
KK11=KK
HH11=HH
save('Results_combined','aa11','ss11','SS11','KK11','HH11','LL11','-append')

%%%%%%%%%%%%%%% Model 3, 2-process contrained with alarm and social 
aa13=aa
ss13=ss
SS13=SS
LL13=LL
KK13=KK
HH13=HH
save('Results_combined','aa13','ss13','SS13','KK13','HH13','LL13', '-append')







