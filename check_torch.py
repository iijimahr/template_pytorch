"""
Check functionality of PyTorch
"""

import torch, time

print("PyTorch version:", torch.__version__)
print("CUDA available :", torch.cuda.is_available())
print("GPU count      :", torch.cuda.device_count())
if torch.cuda.is_available():
    print("Current device :", torch.cuda.current_device())
    print("Device name    :", torch.cuda.get_device_name(0))

size = 10000
for device in ["cpu", "cuda"]:
    t0 = time.time()
    torch.matmul(
        torch.rand(size, size, device=device),
        torch.rand(size, size, device=device)
    )
    t1 = time.time()
    print(f"Elapsed time on {device}:", t1 - t0, "seconds")
