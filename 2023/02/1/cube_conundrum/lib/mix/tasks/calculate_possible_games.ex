defmodule Mix.Tasks.CalculatePossibleGames do
  use Mix.Task

  @impl Mix.Task
  def run(args) do
    {result, [], []} =
      OptionParser.parse(
        args,
        strict: [path: :string]
      )

    path = Keyword.get(result, :path)

    result = CubeConundrum.calculate_possible_games(File.stream!(path))
    Mix.shell().info("#{result}")
  end
end
