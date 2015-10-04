defmodule Diceware.Dice do
  @on_load :seedrandom

  def roll(0, _), do: []
  def roll(count, sides) do
    seedrandom
    [:random.uniform(sides) | roll(count-1, sides) ]
  end

  # TODO
  #  seedrandom is called on every load of the program
  #  rand_bytes returns different values on every run
  #  roll always returns the same 30 values
  #  Temporary fix, seedrandom on every roll
  def seedrandom do
    << a::32, b::32, c::32 >>  = :crypto.rand_bytes(12)
    :random.seed(a,b,c)
    # :random.seed returns undefined
    :ok
  end

end