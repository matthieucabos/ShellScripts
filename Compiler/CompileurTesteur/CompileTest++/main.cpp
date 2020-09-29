#include <cstdio>
#include <math.h>
#include <nlopt.h>
//#include <libloaderapi.h >

using namespace std;

/* Rosenbrock function implementation defined as f(x,y)=(a-x)^2+b(y-x^2)^2 with a and b two given paramter*/

//Definition of a structure for function data (here parameters a and b)
typedef struct
{
    double a, b;
} my_func_data;

/* \briefRosenbrock function which return the value of the function evaluated in the given x ,and the gradient of the rosenbrock function if needed
\param[in] n integer representing the size of vector x
\param[in] double *x a vector of size n representing the point in which we evaluate the rosenbrock function
\param[inout] double *grad avector which ill contains the gradient of the rosenbrock function in x, if the gradient is not NULL
\param[in] user-defined structure which contains the constant parameter needed to evaluate the rosenbrock function
\return f(x)=(a-x[0])^2+b(x[1]-x[0]^2)^2
*/
double rosenbrock(unsigned n, const double *x, double *grad, void *data)
{
    //get function paameter
    my_func_data *d = (my_func_data *) data;
    double a,b;
    a=d->a;
    b=d->b;
//compute the gradient in x only if grad is not null
    if (grad)
    {
        grad[0]=4*b*pow(x[0],3)-4*b*x[0]*x[1]+2*x[0]-2*a;
        grad[1]=2*b*(x[1]-x[0]*x[0]);
    }
    double aux,aux1;
    aux=a-x[0];
    aux1=x[1]-x[0]*x[0];
    return aux*aux+b*aux1*aux1;
}

int main()
{

    //define the paramater
    my_func_data f_data= {2,100};
    //define an optimizer
    nlopt_opt opt;
    //create the optimizer
    opt = nlopt_create(NLOPT_LD_LBFGS,2);// algorithm (here LBFGS) and dimensionality
    //define the objective function
    nlopt_result result=nlopt_set_min_objective(opt, rosenbrock,&f_data);
    //printf("Return of nlopt_set_min_objective:%d\n",result);
    //set relative tolerance for convergence
   /* nlopt_set_xtol_rel(opt, 1e-8);
    //define the inital point : x will contains at the end of the optimization process the minimum x* */
    double x[2]= {0.,0.};

    double minf ; // `*`,xthe` `minimum` `objective` `value,` `upon` `return`*`
    result=nlopt_optimize(opt,x,&minf);
    if (result < 0)
    {
        printf("nlopt failed! Error code= %d\n",result);
    }
    else
    {
        printf("found minimum at f(%g,%g) = %0.10g\n", x[0], x[1], minf);
    }
    return 0;
}
