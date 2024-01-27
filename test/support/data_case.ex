defmodule Blog.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Blog.Repo

      import Ecto
      import Ecto.Query
      import Blog.DataCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Blog.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Blog.Repo, {:shared, self()})
    end

    :ok
  end
end
