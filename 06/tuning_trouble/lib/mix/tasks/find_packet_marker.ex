defmodule Mix.Tasks.FindPacketMarker do
  use Mix.Task

  @impl Mix.Task
  def run(args) do
    {result, [], []} =
      OptionParser.parse(
        args,
        strict: [path: :string]
      )

    path = Keyword.get(result, :path)

    data = path |> File.stream!() |> Enum.join()
    result = TuningTrouble.find_packet_marker(data)
    Mix.shell().info("#{result}")
  end
end
