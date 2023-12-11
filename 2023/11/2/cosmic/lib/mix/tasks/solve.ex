defmodule Mix.Tasks.Solve do
  use Mix.Task

  @impl Mix.Task
  def run(args) do
    {result, [], []} =
      OptionParser.parse(
        args,
        strict: [path: :string]
      )

    path = Keyword.get(result, :path)

    result = Cosmic.solve(File.read!(path))
    Mix.shell().info("#{result}")
  end
end
