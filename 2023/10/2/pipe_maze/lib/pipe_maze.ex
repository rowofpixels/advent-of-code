defmodule PipeMaze do
  alias PipeMaze.Parser
  alias PipeMaze.Utils

  def solve(input) do
    map = Parser.parse(input)
    {start_coordinates, map} = Utils.replace_start(map)
    Utils.file_write_map(map, "01-start-map.txt")
    loop = Utils.build_loop(map, start_coordinates)
    map = Utils.mark_superfluous(map, loop, :ground)
    Utils.file_write_map(map, "02-superfluous.txt")
    map = Utils.pad_map(map, :ground)
    Utils.file_write_map(map, "05-padded-map.txt")
    map = Utils.flood_map(map, Utils.outside_coordinates(map))
    Utils.file_write_map(map, "06-flooded-map.txt")
    Utils.count_tiles(map, :ground)
  end
end
