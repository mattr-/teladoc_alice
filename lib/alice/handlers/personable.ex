defmodule Alice.Handlers.Personable do
  use Alice.Router

  alias Alice.Conn

  route ~r/\bI (love|:heart:) you,? alice\b/i,             :alice_love
  route ~r/\balice,? I (love|:heart:) you\b/i,             :alice_love
  command ~r/\bI (love|:heart:) you\b/i,                   :alice_love
  command ~r/\bsay hi\b/, :say_hi


  @doc """
  Express some love for Alice
  `I love you alice`
  `I `:heart:` you, alice`
  `alice, I love`/:heart:` you`
  `@alice I love`/:heart:` you`
  """
  def alice_love(conn) do
    [love|_rest] = conn.message.captures |> Enum.reverse
    emoji = Enum.random(~w[:wink: :heart_eyes: :kissing_heart: :hugging_face:])
    "aww, I #{love} you too, #{Conn.at_reply_user(conn)}! #{emoji}" |> reply(conn)
  end

  def say_hi(conn) do
    ~w[hi! hello!] |> random_reply(conn)
  end
end
