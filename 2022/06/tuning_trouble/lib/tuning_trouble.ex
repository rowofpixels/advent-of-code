defmodule TuningTrouble do
  @packet_buffer_length 4
  @message_buffer_length 14

  def find_packet_marker(data) do
    data
    |> String.codepoints()
    |> Enum.with_index()
    |> Enum.reduce_while([], fn {character, index}, buffer ->
      buffer = Enum.take([character | buffer], @packet_buffer_length)

      if length(buffer) == @packet_buffer_length and
           length(Enum.uniq(buffer)) == @packet_buffer_length do
        {:halt, index + 1}
      else
        {:cont, buffer}
      end
    end)
  end

  def find_message_marker(data) do
    data
    |> String.codepoints()
    |> Enum.with_index()
    |> Enum.reduce_while([], fn {character, index}, buffer ->
      buffer = Enum.take([character | buffer], @message_buffer_length)

      if length(buffer) == @message_buffer_length and
           length(Enum.uniq(buffer)) == @message_buffer_length do
        {:halt, index + 1}
      else
        {:cont, buffer}
      end
    end)
  end
end
