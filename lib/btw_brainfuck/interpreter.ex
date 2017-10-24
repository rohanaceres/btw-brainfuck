defmodule Interpreter do
    @doc """
        Interprets an entire command line in brainfuck.
    """
    def execute(command) do
        IO.puts command
        :ok
    end
end