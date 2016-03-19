defmodule Pxblog.LayoutViewTest do
  use Pxblog.ConnCase
  alias Pxblog.LayoutView
  alias Pxblog.User
  
  setup do
    User.changeset(%User{}, %{username: "Foo Bar", email: "foo@bar.com",
                              password: "foobar", password_confirmation: "foobar"})
    |> Repo.insert
    conn = conn()
    {:ok, conn: conn}
  end
  
  test "current user returns the user in the session", %{conn: conn} do
    conn = post conn, session_path(conn, :create),
                user: %{username: "Foo Bar", password: "foobar"}
    assert LayoutView.current_user(conn)
  end
  
  test "current user returns nothing if there is no user in the session", %{conn: conn} do
    user = Repo.get_by(User, %{username: "Foo Bar"})
    conn = delete conn, session_path(conn, :delete, user)
    refute LayoutView.current_user(conn)
  end
end