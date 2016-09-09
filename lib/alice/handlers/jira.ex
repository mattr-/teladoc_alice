defmodule Alice.Handlers.Jira do
  use Alice.Router
  import Application, only: [get_env: 2]

  alias Alice.Conn
  alias Alice.Router.Helpers

  route ~r/\b(\w+-\d+)\b/i, :jira


  @doc """
  Provide extra information about tickets in JIRA that Alice hears about in
  chat. Emulates HipChat's display of JIRA tickets
  """
  def jira(conn) do
    issues = ~r/\w+-\d+/ |> Regex.scan(conn.message.text) |> List.flatten
    Enum.reduce(filtered_issues(issues), conn, fn(issue, conn) -> get_issue_details(issue, conn) end)
  end

  def get_issue_details(issue, conn) do
    conn = indicate_typing(conn)
    url = Enum.join([get_env(:alice_jira, :jira_url), "browse", issue], "/")
    headers = %{"Authorization" => "Basic #{get_env(:alice_jira, :jira_basic_auth_token)}"}
    case HTTPoison.head(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200}} -> url |> reply(conn)
      _ -> conn
    end
  end

  def filtered_issues(issues) do
    Enum.uniq(issues)
  end
end
