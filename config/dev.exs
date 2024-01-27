import Config

config :blog, Blog.Repo,
  database: "blog_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
