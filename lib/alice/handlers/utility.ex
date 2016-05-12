defmodule Alice.Handlers.Utility do

  use Alice.Router

  alias Alice.Conn

  command ~r/\bwhere are you\b/, :where_are_you

  @doc """
  Ask Alice where she lives
  `@alice where are you`
  """
  def where_are_you(conn) do
    {:ok, data} = :inet.getif()
    List.to_tuple(data) |> elem(0) |> elem(0) |> :inet.ntoa() |> reply(conn)
  end

end
