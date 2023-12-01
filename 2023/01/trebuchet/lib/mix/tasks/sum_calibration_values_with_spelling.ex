defmodule Mix.Tasks.SumCalibrationValuesWithSpelling do
  use Mix.Task

  @impl Mix.Task
  def run(args) do
    {result, [], []} =
      OptionParser.parse(
        args,
        strict: [path: :string]
      )

    path = Keyword.get(result, :path)

    result = Trebuchet.sum_calibration_values_with_spelling(File.stream!(path))
    Mix.shell().info("#{result}")
  end
end
