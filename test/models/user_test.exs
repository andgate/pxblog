defmodule Pxblog.UserTest do
  use Pxblog.ModelCase

  alias Pxblog.User
  alias Pxblog.TestHelper

  @valid_attrs %{email: "foo@bar.com", username: "Foo Bar", password: "foobar", password_confirmation: "foobar"}
  @invalid_attrs %{}
  
  setup do
    {:ok, role} = TestHelper.create_role(%{name: "user", admin: false})
    {:ok, role: role}
  end
  
  defp valid_attrs(role) do
    Map.put(@valid_attrs, :role_id, role.id)
  end
  
  test "changeset with valid_attrs", %{role: role} do
    changeset = User.changeset(%User{}, valid_attrs(role))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
  
  test "password_digest value gets set to a hash" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert Comeonin.Bcrypt.checkpw(@valid_attrs.password,
      Ecto.Changeset.get_change(changeset, :password_digest))
  end
  
  test "password_digest value does not get set if password is nil" do
    changeset = User.changeset(%User{}, %{email: "foo@bar.com",
                                          username: "Foo Bar",
                                          password: nil,
                                          password_confirmation: nil})
    refute Ecto.Changeset.get_change(changeset, :password_digest)
  end
end
