%%%  WeeklySleep control function, Repeated for Weeks weeks.
%%%  Models: Model 0, 2PML. 2PML with no terminal constraint
%%%          Model 11, 2PML with terminal constraint on the capital stock,
%%%          K. Used in paper, but same results as Model 1 for weeks other
%%%          than last.
%%%          Model 13, 2PMLC, 2PML with alarm and social constraints
%%%          Used Weeks=5 and fixed C=2.5.
%%%          Can change C over the week by uncommenting line 27.
%%%          Uncomment each model section to run it. 



clear all
global Aeq beq  K8 delta chi sigma2 N  ii  NN KK SS LL HH Kstar Lstar Hstar Aastar Ssstar Sstar Cstar aa ss Weeks scale a8 C
format short
fminconoptions = optimoptions('fmincon', 'MaxFunctionEvaluations', 1000000,"EnableFeasibilityMode",true,'StepTolerance',1e-8)

delta=.75;  %% Baseline is 0.75
Kbar=8/delta; % Steady state sleep stock
a_alarm=6;
s_social=23.5
K8=Kbar
Weeks=5
C=2.5; % Single, fixed chronotype
a8=6;

%% For the weekend phase shift
%C=kron(ones(1,Weeks),[2.5 2.5 2.5 2.5 2.5 3.5 3.5]);
           

% Choose one set of parameters
ChiSigma2=[0.068200352	20 ] %% Baseline parameters Chi and Sigma2

%%% Alternative parameters for sensitivity analysis.
%ChiSigma2=[0.068200352*1.5 20 ] 


N=40/7*ones(1,7);% every day is the same. Steady State

% Collect various assumptions about the work week
Nstacked=[40/7*ones(1,7*Weeks); % 7 days
          kron(ones(1,Weeks),[8 8 8 8 8 0 0]); % 5 days
          kron(ones(1,Weeks),[10 10 10 10 0 0 0])]; %% for a 4-day workweek, not used.


X = 1-delta;



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%                     Unconstrained        Model 0 2PML
% 
% Aeq=[]; 
% beq=[];
% 
% 
% 
% 
% 
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% %%%%%%%%%%%% MODEL 11, 2PML with a terminal constraint on the capital
% %%%            stock, K
%  
%   K0=Kbar;
%   K8=8/delta;
%   s0=22.5;
%   a8=6.5;
%   
% Aeq=[zeros(1, 14*(Weeks-1)) X^7  X^6	X^5 X^4	X^3	X^2	X   -X^6	-X^5	-X^4	-X^3	-X^2	-X	-1]; 
% Aeq(1,14*(Weeks-1))=-X^7;
% beq=[(K8- X^8*K0 -a8 - 24*(X^7 + X^6 +X^5 + X^4+ X^3+X^2 + X +1)) ]';
%   
% 
% 








% 
% %%%%%%%%%%%%%%%   MODEL 13, 2PMLC, 2-process model with leisure and
% %                  alarm/social constraints
% 
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
% 
% 


 
 

% Varying days of workweek 7,5 and 4. Running from ii=1:2 runs the model
% for a 7-day workweek and then the 5-day workweek. 
  for ii=1:2;
    chi=ChiSigma2(1,1);
    sigma2=ChiSigma2(1,2);
    N=Nstacked(ii,:);

%%%%%%%%%%%%%%%%%%%%%   Weekday ALARM only, not used.         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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









chi=ChiSigma2(1,1);
sigma2=ChiSigma2(1,2);
 

THETA0=kron(ones(1,Weeks),[6.5 6.5 6.5 6.5 6.5 6.5 6.5 23 23 23 23 23 23 23]);

%[THETAstar, fval, exitflag]=fmincon(@WeeklySleep_Timing_Repeated_Genesis,THETA0,[],[],Aeq,beq,[],[],[],fminconoptions)
[THETAstar, fval, exitflag]=fmincon(@Model_2PML,THETA0,[],[],Aeq,beq,[],[],[],fminconoptions)
                                        
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



Stop



% % %%% Run the model, then run these, commenting out as needed.
%% 
% % %%%%%%%%%%%%%%%% Model 11 2PML, Utility model, terminal constraint only
% aa11=aa
% ss11=ss
% SS11=SS
% LL11=LL
% KK11=KK
% HH11=HH
% save('Results_combined','aa11','ss11','SS11','KK11','HH11','LL11','-append')
% 
% %%%%%%%%%%%%%%% Model 13   2PMLC, 2-process contrained with alarm and social 
% aa13=aa
% ss13=ss
% SS13=SS
% LL13=LL
% KK13=KK
% HH13=HH
% save('Results_combined','aa13','ss13','SS13','KK13','HH13','LL13', '-append')
% 






