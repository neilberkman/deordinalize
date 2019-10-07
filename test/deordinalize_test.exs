defmodule DeordinalizeTest do
  use ExUnit.Case
  doctest Deordinalize

  describe "Deordinalize" do
    test "to_integer!" do
      assert "3rd" |> Deordinalize.to_integer!() == 3
      assert "11th" |> Deordinalize.to_integer!() == 11
      assert "18th" |> Deordinalize.to_integer!() == 18
      assert "20th" |> Deordinalize.to_integer!() == 20
      assert "21st" |> Deordinalize.to_integer!() == 21
      assert "99th" |> Deordinalize.to_integer!() == 99
      assert "first" |> Deordinalize.to_integer!() == 1
      assert "eleventh" |> Deordinalize.to_integer!() == 11
      assert "sixteenth" |> Deordinalize.to_integer!() == 16
      assert "twentieth" |> Deordinalize.to_integer!() == 20
      assert "twenty first" |> Deordinalize.to_integer!() == 21
      assert "twenty-first" |> Deordinalize.to_integer!() == 21
      assert "eighty-eighth" |> Deordinalize.to_integer!() == 88
      assert "ninety seventh" |> Deordinalize.to_integer!() == 97
    end
  end
end
