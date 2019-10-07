defmodule Deordinalize do
  @explicits %{
    "first" => 1,
    "second" => 2,
    "third" => 3,
    "ninth" => 9,
    "eleventh" => 11,
    "twelfth" => 12,
    "twentieth" => 20,
    "thirtieth" => 30,
    "fortieth" => 40,
    "fiftieth" => 50,
    "sixtieth" => 60,
    "seventieth" => 70,
    "eightieth" => 80,
    "ninetieth" => 90,
    "one hundredth" => 100
  }

  @regulars %{
    "thir" => 3,
    "four" => 4,
    "fif" => 5,
    "six" => 6,
    "seven" => 7,
    "eigh" => 8,
    "nine" => 9,
    "ten" => 10
  }

  @tens %{
    "twenty" => 20,
    "thirty" => 30,
    "forty" => 40,
    "fifty" => 50,
    "sixty" => 60,
    "seventy" => 70,
    "eighty" => 80,
    "ninety" => 90
  }

  @tens_match Regex.compile!("(?<tens>#{@tens |> Map.keys() |> Enum.join("|")})(?:\\s|-)", "i")

  @ordinal ~r/^(?<ordinal>\d+)(?:st|nd|rd|th)$/i
  @teenth ~r/^(?<teenth_prefix>.+)teenth$/i
  @th ~r/^(?<th_prefix>.+)th$/i

  @invalid_argument "argument must be a valid ordinal"

  @moduledoc """
  "Deordinalizes" strings into the integers they reference.
  """

  @doc """
  "Deordinalize" a string into the integer it references.
  For the time being, only supports ordinals from 1 to 100.
  Raises an `ArgumentError` if the input is not a String
  representing a valid ordinal. Handles both hyphenated
  and non-hypenated orinals.

  ## Examples

      iex> "1st" |> Deordinalize.to_integer!
      1
      iex> "sixteenth" |> Deordinalize.to_integer!
      16
      iex> "sixty eighth" |> Deordinalize.to_integer!
      68
      iex> "ninety-ninth" |> Deordinalize.to_integer!
      99
  """
  def to_integer!(str) when is_binary(str) do
    try do
      s = str |> String.downcase()

      {sum, s} =
        if String.match?(s, @tens_match) do
          tens = s |> capture(@tens_match, "tens")
          {Map.get(@tens, tens), s |> String.replace(Regex.compile!("#{tens}(?:\\s|-)"), "")}
        else
          {0, s}
        end

      cond do
        String.match?(s, @ordinal) ->
          s |> capture_to_integer(@ordinal, "ordinal")

        Map.get(@explicits, s) ->
          sum + Map.get(@explicits, s)

        String.match?(s, @teenth) ->
          10 + Map.get(@regulars, s |> capture(@teenth, "teenth_prefix"))

        String.match?(s, @th) ->
          sum + Map.get(@regulars, s |> capture(@th, "th_prefix"))
      end
    rescue
      _ -> raise ArgumentError, message: @invalid_argument
    end
  end

  @doc """
  "Deordinalize" a string into the integer it references.
  For the time being, only supports ordinals from 1 to 100.

  ## Examples

      iex> "1st" |> Deordinalize.to_integer
      {:ok, 1}
      iex> "garbage" |> Deordinalize.to_integer
      {:error, "argument must be a valid ordinal"}
  """
  def to_integer(str) do
    try do
      {:ok, to_integer!(str)}
    rescue
      e in ArgumentError -> {:error, e.message}
    end
  end

  @doc """
  "Deordinalize" a string into the integer it references
  and converts to a zero-based index. For the time being,
  only supports ordinals from 1 to 100. Raises an `ArgumentError`
  if the input is not a String representing a valid ordinal.

  ## Examples

      iex> "1st" |> Deordinalize.to_index!
      0
      iex> "11th" |> Deordinalize.to_index!
      10
      iex> "first" |> Deordinalize.to_index!
      0
      iex> "ninety-ninth" |> Deordinalize.to_index!
      98
  """
  def to_index!(str) do
    to_integer!(str) - 1
  end

  @doc """
  "Deordinalize" a string into the integer it references
  and converts to a zero-based index. For the time being,
  only supports ordinals from 1 to 100.


    ## Examples

      iex> "1st" |> Deordinalize.to_index
      {:ok, 0}
      iex> "ninety-ninth" |> Deordinalize.to_index
      {:ok, 98}
      iex> "badnumth" |> Deordinalize.to_index
      {:error, "argument must be a valid ordinal"}
  """
  def to_index(str) do
    try do
      {:ok, to_index!(str)}
    rescue
      e in ArgumentError -> {:error, e.message}
    end
  end

  defp capture(s, regex, name), do: regex |> Regex.named_captures(s) |> Map.get(name)
  defp capture_to_integer(s, regex, name), do: capture(s, regex, name) |> String.to_integer()
end
