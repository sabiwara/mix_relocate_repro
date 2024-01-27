defmodule Blog do
  alias Blog.Post
  alias Blog.Repo

  def create_post(params) do
    %Post{}
    |> Post.changeset(params)
    |> Repo.insert!()
  end
end
