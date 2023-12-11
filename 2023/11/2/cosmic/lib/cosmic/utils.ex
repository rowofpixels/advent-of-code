defmodule Cosmic.Utils do
  def get_empty_x_and_y([head | _tail] = universe) do
    width = length(head)
    height = length(universe)

    {empty_column_indexes, empty_row_indexes} =
      universe
      |> Enum.with_index()
      |> Enum.reduce({Enum.to_list(0..(width - 1)), Enum.to_list(0..(height - 1))}, fn {row,
                                                                                        row_index},
                                                                                       {empty_column_indexes,
                                                                                        empty_row_indexes} ->
        filled_column_indexes =
          row
          |> Enum.with_index()
          |> Enum.reject(fn {cell, _column_index} ->
            is_nil(cell)
          end)
          |> Enum.map(fn {_cell, column_index} ->
            column_index
          end)

        empty_column_indexes = empty_column_indexes -- filled_column_indexes

        empty_row_indexes =
          if Enum.all?(row, &is_nil/1) do
            empty_row_indexes
          else
            empty_row_indexes -- [row_index]
          end

        {empty_column_indexes, empty_row_indexes}
      end)

    {empty_column_indexes, empty_row_indexes}
  end

  def expand_universe([head | _tail] = universe) do
    width = length(head)
    height = length(universe)

    {empty_column_indexes, empty_row_indexes} =
      universe
      |> Enum.with_index()
      |> Enum.reduce({Enum.to_list(0..(width - 1)), Enum.to_list(0..(height - 1))}, fn {row,
                                                                                        row_index},
                                                                                       {empty_column_indexes,
                                                                                        empty_row_indexes} ->
        filled_column_indexes =
          row
          |> Enum.with_index()
          |> Enum.reject(fn {cell, _column_index} ->
            is_nil(cell)
          end)
          |> Enum.map(fn {_cell, column_index} ->
            column_index
          end)

        empty_column_indexes = empty_column_indexes -- filled_column_indexes

        empty_row_indexes =
          if Enum.all?(row, &is_nil/1) do
            empty_row_indexes
          else
            empty_row_indexes -- [row_index]
          end

        {empty_column_indexes, empty_row_indexes}
      end)

    universe
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, row_index} ->
      row =
        row
        |> Enum.with_index()
        |> Enum.flat_map(fn {cell, col_index} ->
          if Enum.member?(empty_column_indexes, col_index) do
            [nil, cell]
          else
            [cell]
          end
        end)

      if Enum.member?(empty_row_indexes, row_index) do
        [
          List.duplicate(nil, width + length(empty_column_indexes)),
          List.duplicate(nil, width + length(empty_column_indexes))
        ]
      else
        [row]
      end
    end)
  end

  def galaxy_coordinates(universe) do
    universe
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, row_index} ->
      row
      |> Enum.with_index()
      |> Enum.flat_map(fn {cell, col_index} ->
        if cell == :galaxy do
          [{col_index, row_index}]
        else
          []
        end
      end)
    end)
  end

  def pair_coordinates(coordinates) do
    coordinates
    |> Enum.flat_map(fn coordinate ->
      coordinates
      |> Enum.flat_map(fn other ->
        [{coordinate, other}]
      end)
    end)
    |> Enum.reject(fn {a, b} ->
      a == b
    end)
    |> Enum.uniq_by(fn {a, b} ->
      Enum.sort([a, b])
    end)
  end
end
