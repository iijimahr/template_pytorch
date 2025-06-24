####
#### Task runner
####

.PHONY: all
all:
	@make check_torch

.PHONY: check_torch
check_torch:
	python check_torch.py

.PHONY: run_torch
run_torch:
	python torch_quickstart_tutorial.py

.PHONY: clean
clean:
	@echo Under construction
