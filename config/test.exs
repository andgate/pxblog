use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :pxblog, Pxblog.Endpoint,
  http: [port: 8081],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :pxblog, Pxblog.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "pxblog_test",
  hostname: "localhost",
  template: "template0",
  pool: Ecto.Adapters.SQL.Sandbox
