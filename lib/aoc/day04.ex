defmodule Aoc.Day04 do
  @line_regex ~r/(\d+)\-(\d+),(\d+)\-(\d+)/

  @doc ~S"""
  Returns all pair-wise ranges from an input string.

  ## Examples

      iex> get_pair_ranges("1-3,2-4\n1-1,5-10")
      [[1..3, 2..4], [1..1, 5..10]]
  """
  def get_pair_ranges(str) do
    Regex.scan(@line_regex, str)
    |> Enum.map(fn [_, start1, end1, start2, end2] ->
      [
        String.to_integer(start1)..String.to_integer(end1),
        String.to_integer(start2)..String.to_integer(end2)
      ]
    end)
  end

  def input() do
    ["priv", "inputs", "day04.txt"]
    |> Path.join()
    |> Path.relative()
    |> File.read!()
    |> get_pair_ranges()
  end

  @doc """
  Takes a list or other enumerable of 2-element lists, where each element is a range of integers.
  Counts pairs for which one range contains the other, and returns the count.

  ## Examples

      iex> answer([[1..3, 2..3], [1..3, 2..4], [1..3, 1..1], [1..3, 4..6]])
      2
  """
  def answer(enum) do
    enum
    |> Enum.count(fn [range1, range2] ->
      Util.Range.contains?(range1, range2) or Util.Range.contains?(range2, range1)
    end)
  end

  def answer() do
    input()
    |> answer()
  end
end
