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
        cond do
            length == 0
                -> track
            # Increments the value at the current cell by one:
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
            # Decrements the value at the current cell by one:
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
            # Moves the data pointer to the next cell (cell on the right):
            String.slice(command, 0..0) == ">"-> 
                if track == [] do
                    track = track ++ [ 0 ]
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
            # Moves the data pointer to the previous cell (cell on the left):
            String.slice(command, 0..0) == "<" ->
                if current_index == 0 do
                    track = [ 0 ] ++ track
                else
                    current_index = current_index - 1
                end
                track = execute(
                    String.slice(command, 1..String.length(command)), 
                    String.length(command) - 1,
                    current_index,
                    track)
                track
            # Prints the ASCII value at the current cell (i.e. 65 = 'A'):
            String.slice(command, 0..0) == "." ->
                IO.inspect "Current cell as ASCII: '#{[ Enum.at(track, current_index) ]}'"
                track = execute(
                    String.slice(command, 1..String.length(command)), 
                    String.length(command) - 1,
                    current_index,
                    track)
                track
            # Reads a single input character into the current cell:
            String.slice(command, 0..0) == "," ->
                { user_input, "\n" } = Integer.parse(IO.gets "Input for the current cell: ")
                track = delete_at(track, current_index)
                track = insert_at(track, current_index, user_input)
                track
            true 
                -> :error
        end
    end
end