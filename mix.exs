defmodule Deordinalize.MixProject do
  use Mix.Project

  @version "0.1.1"
  @url "https://github.com/neilberkman/deordinalize"
  @maintainers [
    "Neil Berkman"
  ]

  def project do
    [
      name: "deordinalize",
      app: :deordinalize,
      version: @version,
      elixir: "~> 1.9",
      package: package(),
      source_url: @url,
      maintainers: @maintainers,
      description: "Convert strings representing ordinal numbers to the integers they reference.",
      homepage_url: @url,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: @maintainers,
      licenses: ["MIT"],
      links: %{github: @url},
      files: ~w(lib) ++ ~w(LICENSE mix.exs README.md)
    ]
  end
end
