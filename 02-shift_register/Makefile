###########################################################
#Makefile básico para proyectos de Circuitos Digitales II.#
#Siéntanse en libertad de compartir :D			  #
#							  #
#Autor: Willy Villalobos				  #
###########################################################

SRC=files.txt
EXE=registro
YOS=yoscript.txt

all:
	iverilog -o ${EXE} -c ${SRC}

32:
	iverilog -o ${EXE}32 registro.v registro32_tb.v
	vvp ${EXE}32
	gtkwave ${EXE}32.vcd &

32v2:
	iverilog -o ${EXE}32v2 registro.v registro32v2_tb.v
	vvp ${EXE}32v2
	gtkwave ${EXE}32v2.vcd &

run:
	vvp ${EXE}

yosys:
	yosys -s ${YOS}

wave:
	gtkwave ${EXE}.vcd &

clean:
	rm -rf ${EXE} ${EXE}32 ${EXE}32.vcd ${EXE}.vcd synth.v
