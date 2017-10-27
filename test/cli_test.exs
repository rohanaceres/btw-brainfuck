defmodule CliTest do
    use ExUnit.Case
    doctest BtwBrainfuck
  
    import BtwBrainfuck.CLI

    # parse_arguments tests
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

    # process tests
    test ":help returned if :help sent as argument" do
        assert process(:help) == :help
    end
    test ":error returned if command is invalid brainfuck script." do
        assert process("blabla") == :error
    end
    test ":ok returned if valid '++++++' brainfuck script" do
        assert process("++++++") == :ok
    end
    test ":ok returned if valid '------' brainfuck script" do
        assert process("------") == :ok
    end
  end