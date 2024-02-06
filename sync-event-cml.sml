open CML

fun prog () =
    let
	val c1 : string chan = channel ()
	val e1 = recvEvt c1 (* event *)
    in
	spawn (fn () => send (c1, "Hello, world"));
	spawn (fn () =>
		  let
		      val v = ref ""
		      fun server () = (
			  let
			      val value = sync e1 (* event -> value *)
			  in
			      v := value
			  end;
			  print ("value = " ^ !v ^ "\n");
			  server ()
		      )
		  in
		      server ()
		  end);
	()
    end

val _ =
    RunCML.doit (prog, NONE)
