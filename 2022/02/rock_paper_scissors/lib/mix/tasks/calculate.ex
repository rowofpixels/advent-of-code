defmodule Mix.Tasks.Calculate do
  @moduledoc "Finds the total from a strategy guide"

  use Mix.Task

  @impl Mix.Task
  def run(args) do
    {result, [], []} =
      OptionParser.parse(
        args,
        strict: [path: :string]
      )

    path = Keyword.get(result, :path)

    Mix.shell().info("Calculating points from strategy in #{path}")
    result = RockPaperScissors.calculate(File.stream!(path))
    Mix.shell().info("#{result} points")
  end
end
