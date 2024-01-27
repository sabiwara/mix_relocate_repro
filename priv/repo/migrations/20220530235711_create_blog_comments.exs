defmodule Repo.Migrations.CreateBlogComments do
  use Ecto.Migration

  def change do
    create table(:blog_comments) do
      add(:text, :string)
      add(:post_id, references(:blog_posts, on_delete: :nothing))

      timestamps()
    end

    create(index(:blog_comments, [:post_id]))
  end
end
