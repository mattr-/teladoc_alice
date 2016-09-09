defmodule Alice.JiraTest do
  use ExUnit.Case, async: true
  import Alice.Handlers.Jira

  test "filters out duplicate issue numbers" do
    issues = ["CC-237", "CC-512", "CC-237"]
    assert filtered_issues(issues) == ["CC-237", "CC-512"]
  end
end
