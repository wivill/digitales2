###########################################################
#Makefile básico para proyectos de Circuitos Digitales II.#
#Siéntanse en libertad de compartir :D			  #
#							  #
#Autor: Willy Villalobos				  #
###########################################################

SRC=files.txt
EXE=library
YOS=yoscript.txt

all:
	iverilog -o -Ttyp -Tmin -Tmax ${EXE} -c ${SRC}

run:
	vvp ${EXE}

yosys:
	yosys -s ${YOS}

wave:
	gtkwave ${EXE}.vcd &

clean:
	rm -rf ${EXE} ${EXE}.vcd synth.v
