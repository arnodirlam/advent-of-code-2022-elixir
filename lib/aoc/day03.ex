defmodule Aoc.Day03 do
  def input do
    ["priv", "inputs", "day03.txt"]
    |> Path.join()
    |> Path.relative()
    |> File.read!()
    |> String.split("\n")
    |> List.delete("")
    |> Enum.map(fn line ->
      [first_half, second_half] = halve(line)
      [to_priorities(first_half), to_priorities(second_half)]
    end)
  end

  @doc """
  Cuts the given string in two halves, returned as a list.

  ## Examples

      iex> halve("abcd")
      ["ab", "cd"]
  """
  def halve(line) do
    cutoff_index = (String.length(line) / 2) |> round()
    first_half = String.slice(line, 0..(cutoff_index - 1))
    second_half = String.slice(line, cutoff_index..-1)
    [first_half, second_half]
  end

  @doc """
  Converts a string to a list of priorities from 1 for `a` to 52 for `Z`.

  ## Examples

      iex> to_priorities("abzABZ")
      [1, 2, 26, 27, 28, 52]
  """
  def to_priorities(str) do
    str
    |> String.to_charlist()
    |> Enum.map(fn
      uppercase when uppercase <= ?Z -> uppercase - ?A + 27
      lowercase -> lowercase - ?a + 1
    end)
  end

  @doc """
  Takes a list or other enumerable of 2-element lists representing two compartments of a rucksack.
  Each inner list has numbers representing item priorities, which are also unique per item.
  For each rucksack, the one priority appearing in both compartments is identified.
  The sum of all such priorities is returned.

  ## Examples

      iex> answer([[[1, 2, 3], [3, 4, 5]]])
      3
  """
  def answer(enum) do
    enum
    |> Enum.reduce(0, fn [left, right], total ->
      [priority] = MapSet.intersection(MapSet.new(left), MapSet.new(right)) |> MapSet.to_list()
      priority + total
    end)
  end

  def answer() do
    input()
    |> answer()
  end

  def input2() do
    ["priv", "inputs", "day03b.txt"]
    |> Path.join()
    |> Path.relative()
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn
      "" -> ""
      line -> to_priorities(line)
    end)
    |> Enum.chunk_every(3)
  end

  @doc """
  Now we need to find the one common priority among each group of 3 rucksacks.
  The sum of each is returned.

  ## Examples

      iex> answer2([[[1, 2, 3], [3, 4, 5], [1, 3, 5]]])
      3
  """
  def answer2(enum) do
    Enum.reduce(enum, 0, fn rucksacks, total ->
      [priority] =
        rucksacks
        |> Enum.map(&MapSet.new/1)
        |> Enum.reduce(&MapSet.intersection/2)
        |> Enum.to_list()

      priority + total
    end)
  end

  def answer2() do
    input2()
    |> answer2()
  end
end
