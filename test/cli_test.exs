defmodule CliTest do
    use ExUnit.Case
    doctest BtwBrainfuck
  
    import BtwBrainfuck.CLI

    test ":help returned by option parsing with -h and --help options" do
        assert parse_arguments([ "-h", "some_argument" ]) == :help
        assert parse_arguments([ "--help", "some_another_argument" ]) == :help
    end
    test ":help returned by null option" do
        assert parse_arguments([ ]) == :help
    end
    test "Arguments returned by option parsing with valid options" do
        assert parse_arguments([ "--cmd", "..-.-----." ]) == { :cmd, "..-.-----."  }
    end
  end