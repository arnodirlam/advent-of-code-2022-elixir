defmodule Aoc.Day02 do
  def input do
    ["priv", "inputs", "day02.txt"]
    |> Path.join()
    |> Path.relative()
    |> File.read!()
    |> String.split("\n")
    |> List.delete("")
    |> Enum.map(&String.split(&1, " "))
  end

  @doc """
  Takes a list or other enumerable of strings.
  Each string has two parts, each representing either Rock, Paper or Scissors.
  A score is computed for each string, and the sum of all scores returned.

  ## Examples

      iex> answer([["A", "Y"], ["B", "X"], ["C", "Z"]])
      15

      iex> answer([["A", "Z"], ["C", "Y"], ["A", "X"]])
      3 + 0 + 2 + 0 + 1 + 3

      iex> answer([["A", "X"], ["B", "Z"], ["B", "Z"], ["C", "X"]])
      1 + 3 + 3 + 6 + 3 + 6 + 1 + 6
  """
  def answer(enum) do
    Enum.reduce(enum, 0, fn
      [left, right], total -> score(right) + score_result(left, right) + total
    end)
  end

  def score("X"), do: 1
  def score("Y"), do: 2
  def score("Z"), do: 3

  def score_result("A", "X"), do: 3
  def score_result("B", "Y"), do: 3
  def score_result("C", "Z"), do: 3

  def score_result("A", "Z"), do: 0
  def score_result("B", "X"), do: 0
  def score_result("C", "Y"), do: 0

  def score_result("A", "Y"), do: 6
  def score_result("B", "Z"), do: 6
  def score_result("C", "X"), do: 6

  def answer() do
    input()
    |> answer()
  end
end
