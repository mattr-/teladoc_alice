defmodule Alice.Handlers.Jira do
  use Alice.Router
  import Application, only: [get_env: 2]

  route ~r/\b(\w+-\d+)\b/i, :jira


  @doc """
  Provide extra information about tickets in JIRA that Alice hears about in
  chat. Emulates HipChat's display of JIRA tickets
  """
  def jira(conn) do
    conn = indicate_typing(conn)
    issues = ~r/\w+-\d+/ |> Regex.scan(conn.message.text) |> List.flatten
    Enum.reduce(filtered_issues(issues), conn, fn(issue, conn) -> get_issue_details(issue, conn) end)
  end

  def get_issue_details(issue, conn) do
    case HTTPoison.get(url_for_issue(issue), authorization_header) do
      {:ok, %HTTPoison.Response{status_code: 200}} -> url_for_issue(issue) |> reply(conn)
      _ -> conn
    end
  end

  def filtered_issues(issues) do
    Enum.uniq(issues)
  end

  def url_for_issue(issue) do
    Enum.join([get_env(:alice_jira, :jira_url), "browse", issue], "/")
  end

  def authorization_header do
    %{"Authorization" => "Basic #{get_env(:alice_jira, :jira_basic_auth_token)}"}
  end
end
