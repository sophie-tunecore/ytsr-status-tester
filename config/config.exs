# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ytsr_status_tester,
  ecto_repos: [YtsrStatusTester.Repo]

# Configures the endpoint
config :ytsr_status_tester, YtsrStatusTester.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9G1sC+TAkGrwfaGyv7Vzx019IIRy5DDC/XdhBMcz4LPG/a9hJSm2gpj4PbrfvnKL",
  render_errors: [view: YtsrStatusTester.ErrorView, accepts: ~w(html json)],
  pubsub: [name: YtsrStatusTester.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure Goth for Google Auth
config :goth, json: System.get_env("GOOGLE_APPLICATION_CREDENTIALS") |> File.read!

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
