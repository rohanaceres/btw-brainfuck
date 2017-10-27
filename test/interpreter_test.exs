defmodule InterpreterTest do
    use ExUnit.Case
    doctest Interpreter

    import Interpreter
  
    test ":ok returned if '<++>>--' brainfuck script and track [ 1, <2>, 3 ]" do
        cmd = "<++>>--"
        track = [ 1, 2, 3 ]
        assert execute(cmd, String.length(cmd), 1, track) == :ok
    end
  end