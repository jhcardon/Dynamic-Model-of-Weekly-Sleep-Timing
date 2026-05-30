%% Weekly sleep simulation. Genesis uses S_t= a_t+(24-s_{t-1})
%% This removes leisure utility term.
%% Zero out U_L term, subract .6712 (or whatever) in H to recenter sleep
%   times.
function F=WeeklySleep_Timing_Genesis(THETA)
global delta chi beta mu sigma2  chi  mu Kbar a8 Aeq beq b N ii KK Nstar Kstar Lstar Hstar Sstar Ssstar Aastar aa ss Weeks scale C

options=optimset('Tolfun',1e-15,'TolX',1e-15,'TolCon',1e-15);
%Aeq=[0 0 0 0 0 0 -1+(1-delta)*K(7)-K(1)];
%Beq=[0 0 0 0 0 (1-delta)*K(7) -1*K(1)];
%Beq=[0 0 0 0 0 0 0]

% Calibrated 5/17/24
delta=.75;

beta=0;
%phi=.5;m
Kbar=8/delta;
K1=Kbar;
%K8=Kbar;
%S0= a0+ 24-s0;
T=7*Weeks;
% sigma2=10;
mu=0;

%a1=THETA(1:7);
%s1=THETA(8:14);
%a2=THETA(15:21);
%s2=THETA(22:28);

for i=1:Weeks
a((i-1)*7+1: i*7)=THETA((2*i-2)*7+1:(2*i-1)*7);
s((i-1)*7+1: i*7)=THETA((2*i-2)*7+8:(2*i-1)*7+7);   
%S=a+24-s;  %Correct? Old definition, St depends on at and st only
end




% old
S=zeros(size(a));
for j=1:(length(a)-1)
    S(j)=a(j+1)+ 24-s(j);
end;
%S(length(a))=a8+ 24-s(length(a));

 S(length(a))= 6.5+24-s(length(a));
  
% Corrected St=at + 24 - st-1
% S=zeros(size(a));

% %S(1)=a(2)+24-s(1);
% % Test version
% S(1)=a(1)+24-22.5;
% 
% for j=2:length(a)-1
%     S(j)=a(j)+ 24-s(j-1);
% end

% aTplus1=6.5;
% %aTplus1=a(length(a-7)); Use previous Monday's offset
% S(length(a))= aTplus1  + 24-s(length(a)); % Fix aTplus1
% %%   TEST version: S(Saturday)=a(Sat)+ 24-s(Friday)
% S(length(a))= aTplus1  + 24-s(length(a)); % Fix aTplus1
% 





% S(1)=a(1)+24-22.5; %% Need to fix this later
% for j=2:length(a)
%   S(j)=a(j)+ 24-s(j-1);
% end;






% for jj=1:7
%     S(jj)=a1(jj)+ 24-s1(jj);
% end
% 
% for jj=1:7
%     S(jj+7)=a2(jj)+ 24-s2(jj);
% end

%a=[a1 a2];
%s=[s1 s2];




%S=[S(1) S(2) S(3) S(4) S(5) S(6)]';

%K=zeros(1,T-1);

%% or K(1)=
K(1)=Kbar*(1-delta) +a(1)+24-22.5;

  for i=2:T
      K(i)=(1-delta)*K(i-1) + S(i-1);
  end




% K(8)=K8;
% K(2)=(1-delta)*K(1)+S(1);
% K(3)=(1-delta)*K(2)+S(2);
% K(4)=(1-delta)*K(3)+S(3);
% K(5)=(1-delta)*K(4)+S(4);
% K(6)=(1-delta)*K(5)+S(5);
% K(7)=(1-delta)*K(6)+S(6);
% K(8)=(1-delta)*K(7)+S(7);
% K(9)=(1-delta)*K(8)+S(8);
% K(10)=(1-delta)*K(9)+S(9);
% K(11)=(1-delta)*K(10)+S(10);
% K(12)=(1-delta)*K(11)+S(11);
% K(13)=(1-delta)*K(12)+S(12);
% K(14)=(1-delta)*K(13)+S(13);




%S(7)=Kbar-(1-delta)*K(7);
Kcheck=(1-delta)*K(7*Weeks)+S(7*Weeks);


%N=[8 8 8 8 8 0 0];
%N=[10 10 10 10 0 0 0]
%N=[5.7 5.7 5.7 5.7 5.7 5.75 5.75  ]
%N=40/7*ones(1,7);





%L=24-N-S; 
L=s-a-N;

%K8=K1;
%z=2/pi*(acot(y).*(y>0) + (acot(y)+pi).*(y<0))-1; plot(y,z,'.')

%y=2/pi*((acot(x) + pi).*(x<0) + acot(x).*(x>=0))-1;
%H=2/pi*(acot(phi*(K-Kbar)+ pi).*((K-Kbar)<0) +  acot(phi*(K-Kbar)).*((K-Kbar)>=0))-1;

%H= 4./(1+exp((K-Kbar)/2))-1 ;

H=2*(1-cdf('normal',K-Kbar,mu,sigma2))-1-.7127;

%astar = 12-12/pi*acos(H(1:T-1)-beta./L);
%sstar = 12+12/pi*acos(H(1:T-1)-beta./L);

%U = sum(log(L)) + chi*(sum(48/pi*sin(S*pi/24) - H(1:T)'*(24-2*S)));



%U = sum(log(L)) + chi*(sum(48/pi*sin(S*pi/24) - H.*(24-2*S)));

%Hlag(1)=H(7);
Hlag(1)=.01;
Hlag(2:length(H))=H(1:length(H)-1);
slag(1)=0;
slag(2:length(H))=s(1:length(s)-1);

%%% zeroing out U(L)
U=0*sum(log(L)) + chi*sum(24/pi*(sin((a-C)*pi/12)-sin((s-C)*pi/12)) - H.*(2*s- a-24) + Hlag.*a);
%% Experimental
%U=sum(log(L)) + chi*sum(24/pi*(sin((a-C))*pi/12)-12/pi*sin((s-C)*pi/12)- 12/pi*sin(pi/12*(slag-C)) - H.*(s-a) - Hlag.*(slag-a));


%% TGIF: scale up leisure utility for Friday-Saturday, Sunday back to normal.
%U=sum(log(L(1:4))) + 1.3*sum(log(L(5:6))) + log(L(7)) + chi*sum(24/pi*(sin((a-C)*pi/12)-sin((s-C)*pi/12)) -H.*(2*s-2*a-24));

%%%    NB: scale=1.3 (or so) slightly changes a and s to offset 
%      scale=2 gives a fairly smooth a and s series over the week.
%%%    scale=3 means getting up earlier on and staying up later on
%%%    weekends. Weekend warrior


scale=1.0;
% Saturday only
SCALE=[1;1;1;1;1;scale;1]';
% F-Saturday scaled up
%SCALE=[1;1;1;1;scale;scale;1]';
% F-Sunday scaled up
%SCALE=[1;1;1;1;scale;scale;scale]';
% Sat-Sun scaled up
%SCALE=[1;1;1;1;1;scale;scale]';


kron(ones(1,Weeks),SCALE);

%U=sum(kron(ones(1,Weeks),SCALE).*log(L))+ chi*sum(24/pi*(sin((a-C)*pi/12)-sin((s-C)*pi/12)) -H.*(2*s-2*a-24));
%U=sum(kron(ones(1,Weeks),SCALE).*log(L)) + chi*sum(24/pi*(sin((a-C)*pi/12)-sin((s-C)*pi/12)) - H.*(2*s- a-24) + Hlag.*a);

% %% Experimental (7/5/2024) AM and PM leisure subutilities. HARD TO COMPARE, but this creates the SJL "shift". Scale=2 works to get a shift after choosing alpha=.3, and .91 for the overall scale parameter (so that K is flat with scale=1).
% 
% if N(1)==40/7
% Lam= kron(ones(1,Weeks),9*[1 1 1 1 1 1 1])   - a;
% Lpm= s- kron(ones(1,Weeks),(9+40/7)*[1 1 1 1 1 1 1]);
% 
% else 
%  Lam = kron(ones(1,Weeks),[9 9 9 9 9 12+C 12+C])   - a;
%  Lpm = s- kron(ones(1,Weeks),[17 17 17 17 17 12+C 12+C]);
% end
% 
% %%  1/Lpm is much larger than 1/L, so need to recalibrate chi. Not worth it.
% alpha=.3;
% U = .96135*(alpha*sum(log(Lam)) +   (1-alpha)*sum(kron(ones(1,Weeks),SCALE).*log(Lpm))) +  chi*sum(24/pi*(sin((a-C)*pi/12)-sin((s-C)*pi/12)) -H.*(2*s-a-24)+ Hlag.*a);
% 




%% TGIF: scale up leisure utility for Friday-Sunday.
 %U=sum(log(L(1:4))) + 1.3*sum(log(L(5:7))) + chi*sum(24/pi*(sin((a-C)*pi/12)-sin((s-C)*pi/12)) -H.*(2*s-2*a-24));

%% TGIF: scale up leisure utility for Saturday-Sunday.
 %U=sum(log(L(1:5))) + 1.5*sum(log(L(6:7))) + chi*sum(24/pi*(sin((a-C)*pi/12)-sin((s-C)*pi/12)) -H.*(2*s-2*a-24));



%S(7)=K8-(1-delta)*K(7)


%astar=THETA(1:7);
%sstar=THETA(8:14);

F=-U;
NSasKLH=[N' S' a' s' K' L' H' Kcheck*ones(size(S'))]
Nstar=N;
Sstar=S;
Aastar=a;
Ssstar=s;
Kstar=K;
Lstar=L;
Hstar=H;

sum(NSasKLH);







