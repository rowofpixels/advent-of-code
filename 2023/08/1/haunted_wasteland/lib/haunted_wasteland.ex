defmodule HauntedWasteland do
  alias HauntedWasteland.Parser

  def solve(input) do
    {directions, mappings} = Parser.parse(input)

    directions
    |> stream_repeatedly()
    |> Enum.reduce_while({"AAA", 0}, fn
      _direction, {"ZZZ", step} ->
        {:halt, step}

      direction, {current, step} ->
        {left, right} = Map.get(mappings, current)

        new =
          case direction do
            :left ->
              left

            :right ->
              right
          end

        {:cont, {new, step + 1}}
    end)
  end

  defp stream_repeatedly(directions) do
    Stream.resource(
      fn -> {directions, 0} end,
      fn {directions, index} ->
        index =
          if index > length(directions) - 1 do
            0
          else
            index
          end

        direction = Enum.at(directions, index)

        {[direction], {directions, index + 1}}
      end,
      fn _context -> nil end
    )
  end
end
