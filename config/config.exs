# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :alice,
  api_key: System.get_env("SLACK_API_TOKEN"),
  state_backend: :redis,
  redis: System.get_env("REDISTOGO_URL")
