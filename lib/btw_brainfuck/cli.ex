defmodule BtwBrainfuck.CLI do
    @moduledoc """
        Module responsible for handling the command line interface. 
    """

    @doc """
        Parse command line arguments and process it.
    """
    def run(argv) do
        process parse_arguments argv
    end
    @doc """
        Parse arguments received by command line. It shows help if "--help" or "-h" and if the command
        is empty.
    """
    def parse_arguments(argv) do
        parse = OptionParser.parse(argv, 
            switches: [ help: :boolean, cmd: :string ], 
            aliases: [ h: :help, c: :cmd ])

        case parse do
            { [ help: true ], _, _ }
                -> :help
            { [ command ], _, _ }
                -> command
            { _, _, _ }
                -> :help
        end       
    end
    @doc """
        Run brainfuck command script received by command line.
    """
    def process(command) do
        cond do
            command == :help -> :help
            true -> Interpreter.execute command
        end
    end
end