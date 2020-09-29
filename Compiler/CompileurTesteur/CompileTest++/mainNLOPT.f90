program mainNLOPT
  implicit none
  include 'nlopt.f' 
  integer*8 opt
  integer, parameter:: n=2
  integer ires
  external rosenbrock
  double precision x(n), minf
  
  opt = 0
  call nlo_create(opt, NLOPT_LD_LBFGS, n)
  call nlo_set_min_objective(ires, opt, rosenbrock, 0)

   x(1)=0.;
   x(2)=0.;


   call nlo_optimize(ires, opt, x, minf)

    if (ires< 0) then
    
        write(*,*) "nlopt failed! Error code= ",ires
    
    else
    
       write(*,*) "found minimum at f(", x(1), ",", x(2), ")=",minf
    endif

   call nlo_destroy(opt)

end program mainNLOPT

subroutine rosenbrock(myResult,n,x,grad,need_gradient,f_data)
  integer need_gradient
  double precision myResult,x(n),grad(n)
  integer,parameter :: a=2
  integer,parameter :: b=100
  double precision aux, aux1
  
  if (needd_gradient.ne.0) then
    grad(1)=4*b*(x(1)**3)-4*b*x(2)+2*x(1)-2*a;
    grad(2)=2*b*(x(2)-x(1)*x(1))
  endif

    aux=a-x(1);
    aux1=x(2)-x(1)*x(1)
    myResult=aux*aux+b*aux1*aux1;
end
