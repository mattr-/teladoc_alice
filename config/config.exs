# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :alice,
  adapter: Alice.Adapters.Slack,
  api_key: System.get_env("SLACK_API_TOKEN"),
  slack: [key: System.get_env("SLACK_API_TOKEN")],
  handlers: [
    Alice.Handlers.Utils,
    Alice.Handlers.GoogleImages,
    Alice.Handlers.Karma,
    Alice.Handlers.Personable,
    Alice.Handlers.CustomUtils,
    Alice.Handlers.Jira,
    Alice.Handlers.Jenkins
  ],
  state_backend: :redis,
  redis: System.get_env("REDISTOGO_URL"),
  jenkins_host: System.get_env("JENKINS_HOST"),
  jenkins_job: System.get_env("JENKINS_JOB"),
  jenkins_token: System.get_env("JENKINS_TOKEN")

config :alice_google_images,
  cse_id: System.get_env("GOOGLE_CSE_ID"),
  cse_token: System.get_env("GOOGLE_CSE_TOKEN"),
  safe_search_level: :medium

config :alice_jira,
  jira_url: System.get_env("JIRA_URL"),
  jira_basic_auth_token: System.get_env("JIRA_BASIC_AUTH_TOKEN")
