defmodule Interpreter do
    @moduledoc """
        Module responsible for understand brainfuck scripts and perform the corresponding action. 
    """

    import List

    @doc """
        Interprets an entire command line in brainfuck.
    """
    def execute(command) do
        execute(command, String.length(command), 0, [ ])
    end
    @doc """
        Recursively interprets and executes an entire command line in brainfuck.
    """
    def execute(command, length, current_index, track) do
        IO.puts("command '#{command}'")
        IO.puts("length '#{length}'")
        IO.puts("current_index '#{current_index}'")
        IO.puts("track '#{Enum.join(track, ", ")}'")

        cond do
            String.slice(command, 0..0) == "+" ->
                old_value = Enum.at(track, current_index)
                if old_value == nil do
                    old_value = 0
                end
                track = delete_at(track, current_index)
                track = insert_at(track, current_index, old_value + 1)

                execute(
                    String.slice(command, 1..String.length(command)), 
                    String.length(command) - 1,
                    current_index,
                    track)
                :ok
            true 
                -> :error
        end
    end
end