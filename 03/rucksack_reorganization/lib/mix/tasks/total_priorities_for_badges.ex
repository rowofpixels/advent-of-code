defmodule Mix.Tasks.TotalPrioritiesForBadges do
  @moduledoc "Finds the total priorities for badges that appear in three rucksacks"

  use Mix.Task

  @impl Mix.Task
  def run(args) do
    {result, [], []} =
      OptionParser.parse(
        args,
        strict: [path: :string]
      )

    path = Keyword.get(result, :path)

    Mix.shell().info("Calculating priorities for badges in #{path}")
    result = RucksackReorganization.total_priorities_for_badges(File.stream!(path))
    Mix.shell().info("#{result}")
  end
end
