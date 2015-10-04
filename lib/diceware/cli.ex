defmodule Diceware.CLI do
  import Diceware.Phrase

  def main(argv) do
    argv
      |> parse_args
      |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean, print: :boolean],
                                     aliases:  [h: :help, p: :print])

    case parse do
      { [ help: true ], _, _} -> :help
      { [ print: true ], _, _ } -> :print
      { _, _, _ } -> {}
      _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    Usage: diceware
    """
    System.halt(0)
  end

  def process(:print) do
    print_word_list
  end

  def process _ do
    generate_phrase(5) |> print_phrase
  end

  def print_phrase phrase do
    IO.puts phrase
  end
end