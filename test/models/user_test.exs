defmodule Pxblog.UserTest do
  use Pxblog.ModelCase

  alias Pxblog.User

  @valid_attrs %{email: "foo@bar.com", username: "Foo Bar", password: "foobar", password_confirmation: "foobar"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
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
