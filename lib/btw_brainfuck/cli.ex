defmodule BtwBrainfuck.CLI do
    @moduledoc """
        Module responsible for handling the command line interface. 
    """

    @doc """
        TODO
    """
    def run(argv) do
        parse_arguments(argv)
    end
    @doc """
        TODO
    """
    def parse_arguments(argv) do
        parse = OptionParser.parse(argv, 
            switches: [ help: :boolean, cmd: :string ], 
            aliases: [ h: :help, c: :cmd ])

        case parse do
            { [ [ help: true ], _, _ ] }
                -> :help
            { [ [ command ], _, _ ] }
                -> { command }
            { [ nil, _, _ ] }
                -> :help
        end

        to_string parse        
    end
end