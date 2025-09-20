defmodule MingleMeWeb.PageController do
  use MingleMeWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
