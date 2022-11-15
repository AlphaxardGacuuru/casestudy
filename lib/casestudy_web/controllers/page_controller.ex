defmodule CasestudyWeb.PageController do
  use CasestudyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
