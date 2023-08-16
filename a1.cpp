#include <iostream>
#include <math.h>

using namespace std;

double f(double x)
{
	return (1 - (x*x))*exp(-x*x);
}

double dx(double x)
{
	return (-2*x*exp(-2)) + (2*x*exp(-2));
}

double dir(double x, double h)
{
	return (f(x + h) - f(x)) / h;
}

double esq(double x, double h)
{
	return (f(x) - f(x - h)) / h;
}

double mid(double x, double h)
{
	return (f(x + h) - f(x - h)) / h;
}

double teste[] = {1e-1, 1e-2, 1e-4, 1e-8, 1e-10, 1e-12};

int main()
{
	for (double t : teste)
	{
		printf(" h   : %0.12lf\n", t);
		printf(" D+f : %0.12lf\n", dir(sqrt(2), t));
		printf(" Erro: %0.12lf\n", fabs(dir(sqrt(2), t) - dx(sqrt(2))));
		printf(" D-f : %0.12lf\n", esq(sqrt(2), t));
		printf(" Erro: %0.12lf\n", fabs(esq(sqrt(2), t) - dx(sqrt(2))));
		printf(" D0f : %0.12lf\n", mid(sqrt(2), t));
		printf(" Erro: %0.12lf\n\n", fabs(mid(sqrt(2), t) - dx(sqrt(2))));
	}
}




