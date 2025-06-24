####
#### Task runner
####

.PHONY: all
all:
	make build
	make run

.PHONY: build
build:
	cmake -B build -S .
	@echo -----------------------------------------------------------------
	make -C build
	@echo -----------------------------------------------------------------

.PHONY: run
run:
	mpiexec -np 2 --allow-run-as-root --bind-to none --mca coll ^hcoll ./build/hello_mpi
	@echo -----------------------------------------------------------------
	./build/vector_add
	@echo -----------------------------------------------------------------

.PHONY: clean
clean:
	rm -rf build

