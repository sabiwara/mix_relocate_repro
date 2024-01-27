defmodule Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Comment

  schema "blog_posts" do
    field(:title, :string)

    has_many(:comments, Comment)

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title])
    |> cast_assoc(:comments)
    |> validate_required([:title])
  end
end
