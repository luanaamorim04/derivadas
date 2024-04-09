## Laplaciana usando Paralelismo: 
### Vamos analisar a diferença de tempo no cálculo da laplaciana serial vs paralelo
* Função exemplo: f(x, y) = (x^4 + y^4)/3
* Laplaciana Exata: 4*(x^2 + y^2)

## Tempo de execução 

| N | Serial (μs)    | Paralelo (μs) |
| ----| -------- | ------- |
| 100| 1031 | $250    |
| 200| 4020 | $80     |
| 500| 24584 | $420    |
| 1000| 98164 | |
| 5000| 2455451 | | 
| 10000 | 9823968 | |

## Erro:
* n =

## Código: 
```cpp
#include <bits/stdc++.h>
#include <assert.h>
#define MAXN (int) 100 
#define DELTA 10.0/MAXN

using namespace std;
using namespace chrono;

inline cudaError_t checkCuda(cudaError_t result)                                                                              
{                                                                                                                             
	if (result != cudaSuccess) 
	{                                                                                                
		fprintf(stderr, "CUDA Runtime Error: %s\n", cudaGetErrorString(result));
		assert(result == cudaSuccess);                                                                
	}
	return result;                                                                                                         
} 
__global__ void ini_paralelo(float *u)
{
	int idx = blockIdx.x * blockDim.x + threadIdx.x;
	int i = idx/MAXN;
	int j = idx - (i*MAXN);
	if (i >= MAXN || j >= MAXN) return;
	u[idx] = (pow(-5 + i*DELTA, 4) + pow(-5 + j*DELTA, 4))/3.0;
}	

void ini_serial(float *u)
{
	for (int i = 0; i < MAXN; i++)
	{
		for (int j = 0; j < MAXN; j++)
			u[i*MAXN + j] = (pow(-5 + i*DELTA, 4) + pow(-5 + j*DELTA, 4))/3.0;
	}
}

__global__ void lap_paralelo(float *du, float *p)
{
	int idx = blockIdx.x * blockDim.x + threadIdx.x;
	int i = idx/MAXN;
	int j = idx - (i*MAXN);
	if (i >= MAXN - 1 || j >= MAXN - 1 || i <= 0 || j <= 0) return;
	du[idx] = (p[idx-1] + p[idx+1] + p[idx-MAXN] + p[idx+MAXN] - 4*p[idx])/(DELTA*DELTA); 
}

void lap_serial(float *du)
{
	for (int i = 0; i < MAXN; i++)
		for (int j = 0; j < MAXN; j++)
			du[i*MAXN + j] = (pow(-5 + i*DELTA, 2) + pow(-5 + j*DELTA, 2))*4;
}

int32_t main()
{
	float *u, *v, *p, *du, *ext, *dp;
	v = (float*)malloc(sizeof(float)*MAXN*MAXN);
	p = (float*)malloc(sizeof(float)*MAXN*MAXN);
	dp = (float*)malloc(sizeof(float)*MAXN*MAXN);
	ext = (float*)malloc(sizeof(float)*MAXN*MAXN);
	cudaMallocManaged(&u, sizeof(float)*MAXN*MAXN);
	cudaMallocManaged(&du, sizeof(float)*MAXN*MAXN);
	/*-----------*/
	auto beg = high_resolution_clock::now();
	ini_paralelo<<<MAXN*MAXN/16, 16>>>(u);
	checkCuda(cudaDeviceSynchronize());
	cudaMemcpy(p, u, MAXN*MAXN*sizeof(float), cudaMemcpyDeviceToHost);
	lap_paralelo<<<MAXN*MAXN/16, 16>>>(du, u);
	checkCuda(cudaDeviceSynchronize());
	cudaMemcpy(dp, du, MAXN*MAXN*sizeof(float), cudaMemcpyDeviceToHost);
	auto end = high_resolution_clock::now();
	/*-----------*/

	ini_serial(v);
	lap_serial(ext);
	auto duration = duration_cast<microseconds>(end - beg);
	cout << "tempo: " << duration.count() << endl;
	float erro = 0;

	for (int i = 0; i < MAXN*MAXN; i++)
	{
		int x = i/MAXN;
		int y = i-(x*MAXN);
		if (x <= 0 || y <= 0 || x >= MAXN - 1 || y >= MAXN - 1) continue;
		erro = max(erro, fabs(dp[i]-ext[i]));
	}

	cout << "erro: " << erro << endl;
	cudaFree(u);
	cudaFree(du);
	free(v);
	free(p);
	free(dp);
	free(ext);
}
```
