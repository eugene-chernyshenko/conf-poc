all: clean
	./process-all-components.sh

demo: clean
	./process-component.sh demo

demostage: clean
	./process-component.sh demo stage

clean:
	rm -rf target
