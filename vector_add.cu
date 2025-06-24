// vector_add.cu
#include <cstdio>
#include <cstdlib>

__global__ void vecAdd(const float *a, const float *b, float *c, int n)
{
  int i = blockIdx.x * blockDim.x + threadIdx.x;
  if (i < n)
    c[i] = a[i] + b[i];
}

int main()
{
  const int N = 1 << 20; // 1 M 要素
  const size_t bytes = N * sizeof(float);

  // ホスト側メモリ確保
  float *h_a = (float *)malloc(bytes);
  float *h_b = (float *)malloc(bytes);
  float *h_c = (float *)malloc(bytes);

  // データ初期化
  for (int i = 0; i < N; ++i)
  {
    h_a[i] = 1.0f;
    h_b[i] = 2.0f;
  }

  // デバイス側メモリ確保
  float *d_a, *d_b, *d_c;
  cudaMalloc(&d_a, bytes);
  cudaMalloc(&d_b, bytes);
  cudaMalloc(&d_c, bytes);

  // ホスト → デバイス
  cudaMemcpy(d_a, h_a, bytes, cudaMemcpyHostToDevice);
  cudaMemcpy(d_b, h_b, bytes, cudaMemcpyHostToDevice);

  // カーネル起動
  int threads = 256;
  int blocks = (N + threads - 1) / threads;
  vecAdd<<<blocks, threads>>>(d_a, d_b, d_c, N);

  // デバイス → ホスト
  cudaMemcpy(h_c, d_c, bytes, cudaMemcpyDeviceToHost);

  // 結果検証
  bool ok = true;
  for (int i = 0; i < N; ++i)
  {
    if (h_c[i] != 3.0f)
    {
      ok = false;
      break;
    }
  }
  printf("%s\n", ok ? "All good 🎉" : "Mismatch! ❌");

  // 後片付け
  cudaFree(d_a);
  cudaFree(d_b);
  cudaFree(d_c);
  free(h_a);
  free(h_b);
  free(h_c);
  return ok ? 0 : 1;
}
