# Deordinalize

A small package to "deordinalize" strings into the integers they reference. Ported from [Jeremy Ruppel's](https://github.com/jeremyruppel) [deordinalize](https://rubygems.org/gems/deordinalize) Ruby gem.

Installation:
-------------

The package can be installed by adding `deordinalize` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:deordinalize, "~> 0.1.1"}
  ]
end
```

Usage:
------

**Deordinalize**, for the time being, only supports ordinals from 1 to 100.

We can deordinalize numeric ordinals:

```elixir
	"1st" |> Deordinalize.to_integer   # => 1
	"11th" |> Deordinalize.to_integer  # => 11
	"99th" |> Deordinalize.to_integer  # => 99
```
Or we can deordinalize more verbose ordinals:

```elixir
	"first" |> Deordinalize.to_integer         # => 1
	"eleventh" |> Deordinalize.to_integer      # => 11
	"ninety-ninth" |> Deordinalize.to_integer  # => 99
```

Use `to_index` to get the zero-based index of your ordinal:

```elixir
	"first" |> Deordinalize.to_integer!         # => 0
	"eleventh" |> Deordinalize.to_integer!      # => 10
	"ninety-ninth" |> Deordinalize.to_integer!  # => 98
```

The docs can be found at [https://hexdocs.pm/deordinalize](https://hexdocs.pm/deordinalize).

To generate docs:

`ex_doc "Deordinalize" "VERSION" "_build/dev/lib/deordinalize/ebin" -u "https://github.com/neilberkman/deordinalize"`

