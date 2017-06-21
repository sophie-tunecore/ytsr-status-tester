defmodule YtsrStatusTester.PageController do
  use YtsrStatusTester.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
