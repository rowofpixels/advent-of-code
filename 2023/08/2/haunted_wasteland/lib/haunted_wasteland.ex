defmodule HauntedWasteland do
  alias HauntedWasteland.Parser

  def solve(input) do
    {directions, mappings} = Parser.parse(input)

    startings = mappings |> Map.keys() |> Enum.filter(&String.ends_with?(&1, "A"))

    # looking_for_count = length(startings)

    # directions
    # |> stream_repeatedly()
    # |> Enum.reduce_while({startings, 0}, fn({direction, _index}, {currents, step}) ->
    #   IO.inspect(currents)
    #   count = Enum.count(currents, &String.ends_with?(&1, "Z"))
    #   if count > 3 do
    #     IO.inspect(count, label: "Found this many with Z")
    #   end

    #   if count == looking_for_count do
    #     {:halt, step}
    #   else
    #     news = Enum.map(currents, fn(current) ->
    #       {left, right} = Map.get(mappings, current)

    #       case direction do
    #         :left ->
    #           left

    #         :right ->
    #           right
    #       end
    #     end)

    #     {:cont, {news, step + 1}}
    #   end
    # end)

    results = mappings
    |> Enum.filter(fn({node, value}) ->
      String.ends_with?(node, "A")
    end)
    |> Enum.map(fn({node, value}) ->
      resolved = (0..(length(directions) - 1))
      |> Enum.map(fn(index) ->
        steps = directions
        |> stream_repeatedly()
        |> Stream.drop(index)
        |> Enum.reduce_while({{node, %{}}, 0}, fn({direction, original_index}, {{current, seen}, step}) ->
          if Map.get(seen, {current, original_index}) do
            {:halt, nil}
          else
            if String.ends_with?(current, "Z") do
              {:halt, step}
            else
              {left, right} = Map.get(mappings, current)

              new =
                case direction do
                  :left ->
                    left

                  :right ->
                    right
                end

              {:cont, {{new, Map.put(seen, {current, original_index}, true)}, step + 1}}
            end
          end
        end)
      end)

      {node, resolved}
    end)
    |> Enum.into(%{})
    |> Map.values()
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.with_index()
    |> Enum.reject(fn({steps, _index}) ->
      IO.inspect(steps)
      Enum.any?(steps, &is_nil/1)
    end)
    |> IO.inspect(label: "Results!", limit: :infinity, charlists: :as_lists)
    |> Enum.map(fn({steps, index}) ->
      lcm = Enum.reduce(steps, 1, fn(step, acc) ->
        lcm(acc, step)
      end)
      lcm + index
      # Enum.product(steps) + index
    end)
    |> Enum.min()
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

        {[{direction, index}], {directions, index + 1}}
      end,
      fn _context -> nil end
    )
  end

  defp steps_to_solve(directions, mappings, starting_offset, node) do
    directions
    |> stream_repeatedly()
    |> Stream.drop(starting_offset)
    |> Enum.reduce_while({{node, %{}}, 0}, fn({direction, original_index}, {{current, seen}, step}) ->
      if Map.get(seen, {current, original_index}) do
        {:halt, nil}
      else
        if String.ends_with?(current, "Z") do
          {:halt, step}
        else
          {left, right} = Map.get(mappings, current)

          new =
            case direction do
              :left ->
                left

              :right ->
                right
            end

          {:cont, {{new, Map.put(seen, {current, original_index}, true)}, step + 1}}
        end
      end
    end)
  end

  # defp gcd(a, 0), do: a
	# defp gcd(0, b), do: b
	# defp gcd(a, b), do: gcd(b, rem(a,b))

	# defp lcm(0, 0), do: 0
	# defp lcm(a, b), do: (a*b)/gcd(a,b)

  def egcd(a, b) when is_integer(a) and is_integer(b), do: _egcd(abs(a), abs(b), 0, 1, 1, 0)

  defp _egcd(0, b, s, t, _u, _v), do: {b, s, t}

  defp _egcd(a, b, s, t, u, v) do
    q = div(b, a)
    r = rem(b, a)

    m = s - u * q
    n = t - v * q

    _egcd(r, a, u, v, m, n)
  end

  def gcd(a, b) when is_integer(a) and is_integer(b), do: egcd(a, b) |> elem(0)

  def lcm(a, b)

  def lcm(0, 0), do: 0

  def lcm(a, b) do
    abs(Kernel.div(a * b, gcd(a, b)))
  end
end
