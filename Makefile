####
#### Task runner
####

.PHONY: all
all:
	@make torch

.PHONY: torch
torch:
	python check_torch.py

.PHONY: clean
clean:
	@echo Under construction
