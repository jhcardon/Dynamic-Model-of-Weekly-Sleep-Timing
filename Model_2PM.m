function F=Model_2PM(THETA)
global delta chi beta mu sigma2  chi  mu Kbar a8 Aeq beq b N ii KK Nstar Kstar Lstar Hstar Sstar Ssstar Aastar aa ss Weeks scale C

options=optimset('Tolfun',1e-15,'TolX',1e-15,'TolCon',1e-15);
delta=.75;
beta=0;

Kbar=8/delta;
K1=Kbar;

T=7*Weeks;
mu=0;



for i=1:Weeks
a((i-1)*7+1: i*7)=THETA((2*i-2)*7+1:(2*i-1)*7);
s((i-1)*7+1: i*7)=THETA((2*i-2)*7+8:(2*i-1)*7+7);   
end





S=zeros(size(a));
for j=1:(length(a)-1)
    S(j)=a(j+1)+ 24-s(j);
end;


 S(length(a))= 6.5+24-s(length(a));
  

K(1)=Kbar*(1-delta) +a(1)+24-22.5;

  for i=2:T
      K(i)=(1-delta)*K(i-1) + S(i-1);
  end

Kcheck=(1-delta)*K(7*Weeks)+S(7*Weeks);

L=s-a-N;

H=2*(1-cdf('normal',K-Kbar,mu,sigma2))-1-.7127;


Hlag(1)=.01;
Hlag(2:length(H))=H(1:length(H)-1);
slag(1)=0;
slag(2:length(H))=s(1:length(s)-1);

%%% zeroing out U(L)
U= chi*sum(24/pi*(sin((a-C)*pi/12)-sin((s-C)*pi/12)) - H.*(2*s- a-24) + Hlag.*a);






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







