defmodule Blog.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Post

  schema "blog_comments" do
    field(:text, :string)
    belongs_to(:post, Post)

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end
