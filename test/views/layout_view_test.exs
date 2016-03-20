defmodule Pxblog.LayoutViewTest do
  use Pxblog.ConnCase
  alias Pxblog.LayoutView
  alias Pxblog.User
  alias Pxblog.Role
  alias Pxblog.TestHelper
  
  setup do
    {:ok, role} = TestHelper.create_role(%{name: "User Role", admin: false})
    {:ok, user} = TestHelper.create_user(role, %{email: "foo@bar.com", 
                                                 username: "Foo Bar",
                                                 password: "foobar",
                                                 password_confirmation: "foobar"
                                               })
    conn = conn()
    {:ok, conn: conn, user: user}
  end
  
  test "current user returns the user in the session", %{conn: conn, user: user} do
    conn = post conn, session_path(conn, :create),
                user: %{username: user.username, password: user.password}
    assert LayoutView.current_user(conn)
  end
  
  test "current user returns nothing if there is no user in the session", %{user: user} do
    user = Repo.get_by(User, %{username: user.username})
    conn = delete conn, session_path(conn, :delete, user)
    refute LayoutView.current_user(conn)
  end
end