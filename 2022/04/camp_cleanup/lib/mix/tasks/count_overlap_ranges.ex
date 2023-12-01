defmodule Mix.Tasks.CountOverlapRanges do
  @moduledoc "Finds the count of ranges that are overlap within the paired range."

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
    result = CampCleanup.count_overlap_ranges(File.stream!(path))
    Mix.shell().info("#{result}")
  end
end
