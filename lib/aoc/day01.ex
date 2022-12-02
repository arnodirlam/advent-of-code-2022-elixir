defmodule Aoc.Day01 do
  def input do
    ["priv", "inputs", "day01.txt"]
    |> Path.join()
    |> Path.relative()
    |> File.read!()
    |> String.split("\n")
  end

  def answer() do
    input()
    |> answer()
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
    enum
    |> Enum.reduce({0, 0}, fn
      "", {current_sum, overall_max} ->
        {0, max(current_sum, overall_max)}

      line, {current_sum, overall_max} ->
        {elem, ""} = Integer.parse(line)
        {current_sum + elem, overall_max}
    end)
    |> then(fn
      {current_sum, overall_max} -> max(current_sum, overall_max)
    end)
  end
end
