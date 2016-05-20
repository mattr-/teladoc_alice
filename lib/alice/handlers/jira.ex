defmodule Alice.Handlers.Jira do
  use Alice.Router
  import Application, only: [get_env: 2]

  alias Alice.Conn

  route ~r/\b(\w+-\d+)\b/i, :jira


  @doc """
  Provide extra information about tickets in JIRA that Alice hears about in
  chat. Emulates HipChat's display of JIRA tickets
  """
  def jira(conn) do
    conn = indicate_typing(conn)
    issue = Conn.last_capture(conn)
    url = Enum.join([get_env(:alice_jira, :jira_url), "browse", issue], "/")
    headers = %{"Authorization" => "Basic #{get_env(:alice_jira, :jira_basic_auth_token)}"}
    case HTTPoison.head(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200}} -> url |> reply(conn)
      _ -> conn
    end
  end
end
