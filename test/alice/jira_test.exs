defmodule Alice.JiraTest do
  use ExUnit.Case, async: true
  import Alice.Handlers.Jira

  setup do
    Application.put_env(:alice_jira, :jira_url, "http://example.com")
  end

  test "filters out duplicate issue numbers" do
    issues = ["CC-237", "CC-512", "CC-237"]
    assert filtered_issues(issues) == ["CC-237", "CC-512"]
  end

  test "creates a proper url for an issue" do
    assert url_for_issue("CC-123") == "http://example.com/browse/CC-123"
  end
end
