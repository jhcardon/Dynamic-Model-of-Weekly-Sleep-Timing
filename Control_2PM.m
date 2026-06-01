%%%  WeeklySleep control function for base 2PM models without Leisure.
%%%  Models: 
%%%          Model 1, 2PM with terminal constraint on the capital stock,
%%%          K. Used in paper, but same results as Model 1 for weeks other
%%%          than last.
%%%          Model 3, 2PMC, 2PML with alarm and social constraints
%%%          Used Weeks=5 and fixed C=2.5.
%%%          Can change C over the week by uncommenting line 27.
%%%          Uncomment each model section to run it. 



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
%C=kron(ones(1,Weeks),[2.5 2.5 2.5 2.5 2.5 3.5 3.5]);
            
% ChiSigma2=[ 0.05252198	10;
%             0.068200352	20;
%             0.075736392	30];

% Choose one set of parameters
ChiSigma2=[0.068200352	20 ];


N=40/7*ones(1,7);% every day is the same. Steady State
Nstacked=[40/7*ones(1,7*Weeks);
          kron(ones(1,Weeks),[8 8 8 8 8 0 0])];
    
X = 1-delta;



%% ###################### 1 #########################################
%%%%%%%%%%%%%%%%%%%%%%      MODEL 1

% %%% Terminal constraint only
 Aeq=zeros(14*Weeks);
 Aeq(14*Weeks,14*(Weeks-1)+1:14*Weeks) = [X^6	X^5 X^4	X^3	X^2	X	1	-X^6	-X^5	-X^4	-X^3	-X^2	-X	-1];   
 beq=[zeros(1,14*Weeks-1) K8*(1-X^7)-24*(X^6 +X^5 + X^4+ X^3+X^2 + X +1  ) ]';


%Aeq=[]
%beq=[]


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


  for ii=1:2;
    chi=ChiSigma2(1,1);
    sigma2=ChiSigma2(1,2);
    N=Nstacked(ii,:);










chi=ChiSigma2(1,1);
sigma2=ChiSigma2(1,2);
 


THETA0=kron(ones(1,Weeks),[6 6 6 6 6 6 6 18 18 18 18 18 18 18]);

[THETAstar, fval, exitflag]=fmincon(@Model_2PM,THETA0,[],[],Aeq,beq,[],[],[],fminconoptions)


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
 
























