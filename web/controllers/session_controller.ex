defmodule Pxblog.SessionController do
  use Pxblog.Web, :controller
  def new(conn, _params) do
    render conn, "new.html"
  end
end