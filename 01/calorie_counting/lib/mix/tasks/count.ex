defmodule Mix.Tasks.Count do
  @moduledoc "Finds the highest group of calories in a file"

  use Mix.Task

  @impl Mix.Task
  def run(args) do
    {result, [], []} =
      OptionParser.parse(
        args,
        strict: [path: :string, groups: :integer]
      )
    path = Keyword.get(result, :path)
    groups = Keyword.get(result, :groups, 1)

    Mix.shell().info("Counting calories in #{path}")
    result = CalorieCounting.count(File.stream!(path), groups)
    Mix.shell().info("#{result} calories")
  end
end
