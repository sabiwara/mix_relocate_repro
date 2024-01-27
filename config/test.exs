import Config

config :blog, Blog.Repo,
  database: "blog_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
