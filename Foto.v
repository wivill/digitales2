realtime Tdata_ev, Tref_ev, Tlimit, Tinicio_vent, Tfin_vent, Tsudat;
initial begin
	Tlimit = Tsu; // Definido por el usuario

end

//Registrar el tiempo de cualquier cambio en data (d)

always @ (d) begin
	Tdata_ev = $realtime;

end

//Registrar el tiempo del "timecheck event" para cualquier flanco

//Se cambia el estado la variable "notify" si hay violacion

always @ (posedge clk)

	begin

		tref_ev = $realtime;

		Tinicio_vent = Tref_ev - Tlimit;

		Tfin_vent = Tref_ev;

		if ((Tinicio_vent < Tdata_ev) && (Tdata_ev <= Tfin_vent))

			begin
				Tsudata = Tfin_vent - Tdata_ev;

				$display($realtime,, "ERROR SETUP (%n) Ref: %", Tlimit, Tsudata);

			end

	end


