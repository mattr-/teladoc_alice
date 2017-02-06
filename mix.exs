defmodule TeladocAlice.Mixfile do
  use Mix.Project

  def project do
    [app: :teladoc_alice,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :alice],
     mod: {
       Alice, %{ handlers: [
         Alice.Handlers.Utils,
         Alice.Handlers.GoogleImages,
         Alice.Handlers.Karma,
         Alice.Handlers.Personable,
         Alice.Handlers.CustomUtils,
         Alice.Handlers.Jira,
         Alice.Handlers.Random
       ]}
     }]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:poison, "~> 2.1"},
      # {:alice,                  "~> 0.3.0"},
      {:alice, github: "alice-bot/alice", override: true },
      {:alice_google_images, "~> 0.1"},
      {:alice_karma, "~> 0.1"},
      {:alice_personable, "0.0.2"},
    ]
  end
end
