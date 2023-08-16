#include <iostream>
#include <math.h>

using namespace std;

double f(double x)
{
	return sin(x);
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
		printf(" h: %0.12lf\n", t);
		printf(" D+f: %0.12lf\n", dir(1, t));
		printf("|D+f - df/dx|: %0.12lf\n", fabs(dir(1, t) - cos(1)));
	}
}




