defmodule Aoc.Day01 do
  def input do
    ["priv", "inputs", "day01.txt"]
    |> Path.join()
    |> Path.relative()
    |> File.read!()
    |> String.split("\n")
  end

  @doc """
  Takes a list or other enumerable of strings.
  Each string should either be empty or represent an integer.
  Consecutive integers are summed up and the greatest of these sums is returned.

  ## Examples

      iex> answer(["1", "2", "3"])
      6

      iex> answer(["1", "2", "3", "", "4", "", "5", "6"])
      11

      iex> answer(["11", "2", "3", "", "4", "", "5", "6"])
      16

      iex> answer(["11", "2", "3", "", "4", "", "5", "6", ""])
      16
  """
  def answer(enum) do
    iterate_sums(enum, 0, &max/2)
  end

  def answer() do
    input()
    |> answer()
  end

  @doc """
  Same as `answer/1` but computes the top 3 sums, and sums them up.

  ## Examples

      iex> answer2(["1", "2", "3"])
      6

      iex> answer2(["1", "2", "3", "", "4", "", "5", "6"])
      21

      iex> answer2(["11", "", "2", "3", "", "4", "", "5", "", "6"])
      22

      iex> answer2(["11", "", "2", "3", "", "4", "", "5", "", "6"])
      22
  """
  def answer2(enum) do
    iterate_sums(enum, [], &keep_top_n(&1, &2, 3))
    |> Enum.sum()
  end

  def answer2() do
    input()
    |> answer2()
  end

  def keep_top_n(elem, acc, limit) do
    [elem | acc]
    |> Enum.sort(:desc)
    |> Enum.take(limit)
  end

  def iterate_sums(enum, initial_acc, fun) do
    enum
    |> Enum.reduce({0, initial_acc}, fn
      "", {current_sum, overall_max} ->
        {0, fun.(current_sum, overall_max)}

      line, {current_sum, overall_max} ->
        {elem, ""} = Integer.parse(line)
        {current_sum + elem, overall_max}
    end)
    |> then(fn
      {current_sum, overall_max} -> fun.(current_sum, overall_max)
    end)
  end
end
