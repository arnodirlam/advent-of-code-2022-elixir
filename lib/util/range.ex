defmodule Util.Range do
  @moduledoc """
  Collection of generic utility functions for working with `Range` structs.
  """

  @doc """
  Returns true if range1 contains range2, false otherwise.
  Both ranges must be ascending.

  ## Examples

      iex> contains?(1..4, 2..3)
      true

      iex> contains?(1..4, 2..5)
      false
  """
  def contains?(%Range{first: start1, last: end1}, %Range{first: start2, last: end2})
      when start1 < end1 and start2 < end2 do
    start1 <= start2 and end1 >= end2
  end
end
