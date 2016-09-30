defmodule Alice.Handlers.Deployment do
  use Alice.Router

  command ~r/deploy card /i, :deploy_card

  def deploy_card(conn) do
    ["Sorry, can't let you see that yet.",
     "I'm sorry Dave, I'm afraid I can't do that",
     "I am not a magician!",
     "Coming :soon:"]
    |> random_reply(conn)
  end
end
