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
        #IO.puts("command '#{command}'")
        #IO.puts("length '#{length}'")
        #IO.puts("current_index '#{current_index}'")
        #IO.puts("track '#{Enum.join(track, ", ")}'")

        if length == 0 do
            track
        else
            cond do
                String.slice(command, 0..0) == "+" ->
                    old_value = Enum.at(track, current_index)
                    if old_value == nil do
                        old_value = 0
                    end
                    track = delete_at(track, current_index)
                    track = insert_at(track, current_index, old_value + 1)

                    track = execute(
                        String.slice(command, 1..String.length(command)), 
                        String.length(command) - 1,
                        current_index,
                        track)
                    track
                String.slice(command, 0..0) == "-" ->
                    old_value = Enum.at(track, current_index)
                    if old_value == nil do
                        old_value = 0
                    end

                    track = delete_at(track, current_index)
                    track = insert_at(track, current_index, old_value - 1)
                    track = execute(
                        String.slice(command, 1..String.length(command)), 
                        String.length(command) - 1,
                        current_index,
                        track)
                    track
                String.slice(command, 0..0) == ">"-> 
                    if track == [] do
                        track ++ [ 0 ]
                    end
                    if Enum.at(track, current_index + 1) == nil do
                        track = insert_at(track, current_index + 1, 0)
                    end
                    track = execute(
                        String.slice(command, 1..String.length(command)), 
                        String.length(command) - 1,
                        current_index + 1,
                        track)
                    track
                String.slice(command, 0..0) == "<" ->
                    if Enum.at(track, current_index - 1) == nil do
                        track = insert_at(track, current_index - 1, 0)
                    end
                    track = execute(
                        String.slice(command, 1..String.length(command)), 
                        String.length(command) - 1,
                        current_index - 1,
                        track)
                    track
                true 
                    -> :error
            end
        end
    end
end