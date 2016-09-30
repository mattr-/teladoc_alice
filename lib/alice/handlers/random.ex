defmodule Alice.Handlers.Random do
  use Alice.Router
  alias Alice.Conn

  route ~r/\bwat\b/i,                                      :wat
  route ~r/\bbusted\b/i,                                   :busted
  route ~r/\bthanks,? alice\b/i,                           :thanks
  command ~r/thanks/i,                                     :thanks
  route ~r/\b(mad|angry|rage)\b/i,                         :u_mad_bro
  route ~r/\bno+pe+\b/i,                                   :nope_nope_nope
  route ~r/\bdev[- ]?ops\b/i,                              :devops

  @doc "`wat` - wat"
  def wat(conn), do: "http://i.imgur.com/IppKJ.jpg"   |> reply(conn)

  @doc "`busted` - get busted by Mr. Biggs"
  def busted(conn), do: "http://i.imgur.com/MasM57I.png" |> reply(conn)

  @doc "Either `thanks alice` or `@alice thanks` - tell Alice thanks"
  def thanks(conn), do: "no prob, bob" |> reply(conn)

  @doc "`mad`/`angry`/`rage` - u mad bro?"
  def u_mad_bro(conn) do
    ~w[http://24.media.tumblr.com/e48acd4c34a62200a81df7259ab31d57/tumblr_n2kygg41US1rzgx44o1_400.gif
      http://i1248.photobucket.com/albums/hh490/Andrea2awesome/internet-memes-y-u-mad-tho.jpg
      http://i.imgur.com/KEh9WOT.png
      http://i.imgur.com/LupvkMH.jpg]
    |> random_reply(conn)
  end

  @doc "`nope` - nope nope nope"
  def nope_nope_nope(conn) do
    ~w[http://i.imgur.com/ZG8Y5XQ.gif
      http://i.imgur.com/Bebd11u.gif
      http://i.imgur.com/piqluC8.jpg
      http://i.imgur.com/UUoYZjM.jpg
      http://i.imgur.com/HIN4HrI.gif
      http://i.imgur.com/yBE4JbR.jpg]
    |> random_reply(conn)
  end

  @doc "`devops`/`dev-ops`/`dev ops` - ops problem now!"
  def devops(conn), do: "http://i.imgur.com/6sNQ3yt.jpg" |> reply(conn)
end
