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

  @doc """
  Same as `answer/1`, except the second part of each string represents the outcome: lose, draw, win.
  A score is computed for each string, and the sum of all scores returned.

  ## Examples

      iex> answer2([["A", "Y"], ["B", "X"], ["C", "Z"]])
      12

      iex> answer2([["A", "Z"]])
      2 + 6

      iex> answer2([["A", "Z"], ["C", "Y"]])
      2 + 6 + 3 + 3

      iex> answer2([["A", "Z"], ["C", "Y"], ["A", "X"]])
      2 + 6 + 3 + 3 + 3 + 0

      iex> answer2([["A", "X"], ["B", "Z"], ["B", "Z"], ["C", "X"]])
      3 + 0 + 3 + 6 + 3 + 6 + 2 + 0
  """
  def answer2(enum) do
    Enum.reduce(enum, 0, fn
      [left, outcome], total -> score(response(left, outcome)) + score_result(outcome) + total
    end)
  end

  def score_result("X"), do: 0
  def score_result("Y"), do: 3
  def score_result("Z"), do: 6

  def response("A", "Y"), do: "X"
  def response("B", "Y"), do: "Y"
  def response("C", "Y"), do: "Z"

  def response("A", "X"), do: "Z"
  def response("B", "X"), do: "X"
  def response("C", "X"), do: "Y"

  def response("A", "Z"), do: "Y"
  def response("B", "Z"), do: "Z"
  def response("C", "Z"), do: "X"

  def answer2() do
    input()
    |> answer2()
  end
end
