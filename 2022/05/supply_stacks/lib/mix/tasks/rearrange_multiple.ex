defmodule Mix.Tasks.RearrangeMultiple do
  use Mix.Task

  @impl Mix.Task
  def run(args) do
    {result, [], []} =
      OptionParser.parse(
        args,
        strict: [path: :string]
      )

    path = Keyword.get(result, :path)

    result = SupplyStacks.rearrange_multiple(File.stream!(path))
    Mix.shell().info("#{result}")
  end
end
