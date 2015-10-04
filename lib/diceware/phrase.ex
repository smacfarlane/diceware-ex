defmodule Diceware.Phrase do
  @default_length 6
  @default_lang "en"

  @wordsfile "diceware.en.asc"
  @wordsmap @wordsfile |> File.stream!
                       |> Enum.map(&String.strip/1)
                       |> Enum.map(&String.split/1)
                       |> Enum.map(&List.to_tuple/1)
                       |> Enum.into(%{})

  def generate_phrase(_count) do
    generate_keys(@default_length)
      |> Enum.map(&(lookup_word(&1)))
      |> Enum.join(" ")
  end

  def print_word_list do
    @wordsmap |> IO.inspect
  end

  defp generate_keys(0), do: []
  defp generate_keys(count) do
    key = Diceware.Dice.roll(5,6)
          |> Enum.map(&(Integer.to_string(&1)))
          |> Enum.join
    [key | generate_keys(count - 1)]
  end

  def lookup_word(key) do
    @wordsmap[key]
  end
  #
  # defp lookup_words([]), do: []
  # defp lookup_words([key | remaining]) do
  #   [ @words[key] | lookup_words(remaining) ]
  # end
end