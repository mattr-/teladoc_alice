defmodule Alice.Handlers.Random do
  use Alice.Router
  alias Alice.Conn

  route ~r/\bwat\b/i,                                      :wat

  @doc "`wat` - wat"
  def wat(conn), do: "http://i.imgur.com/IppKJ.jpg"   |> reply(conn)
end
