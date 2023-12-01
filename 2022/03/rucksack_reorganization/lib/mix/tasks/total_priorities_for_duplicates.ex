defmodule Mix.Tasks.TotalPrioritiesForDuplicates do
  @moduledoc "Finds the total priorities for items that appear in both compartments"

  use Mix.Task

  @impl Mix.Task
  def run(args) do
    {result, [], []} =
      OptionParser.parse(
        args,
        strict: [path: :string]
      )

    path = Keyword.get(result, :path)

    Mix.shell().info("Calculating priorities for items in #{path}")
    result = RucksackReorganization.total_priorities_for_duplicates(File.stream!(path))
    Mix.shell().info("#{result}")
  end
end
