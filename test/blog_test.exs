defmodule BlogTest do
  use Blog.DataCase, async: true
  doctest Blog

  test "greets the world" do
    assert %{comments: [_]} = Blog.create_post(%{title: "foo", comments: [%{text: "yo"}]})
    assert %{title: "foo", comments: []} = Blog.create_post(%{title: "foo"})
  end
end
