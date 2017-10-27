defmodule InterpreterTest do
    use ExUnit.Case
    doctest Interpreter

    import Interpreter
  
    test "[ 3, 2, 1 ] returned if '<++>>--' brainfuck script and track [ 1, <2>, 3 ]" do
        cmd = "<++>>--"
        track = [ 1, 2, 3 ]
        assert execute(cmd, String.length(cmd), 1, track) == [ 3, 2, 1]
    end
  end