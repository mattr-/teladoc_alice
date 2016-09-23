defmodule Alice.JiraTest do
  use ExUnit.Case, async: true
  import Alice.Handlers.Jira

  setup do
    Application.put_env(:alice_jira, :jira_url, "http://example.com")
    Application.put_env(:alice_jira, :jira_basic_auth_token, "foo")
  end

  test "filters out duplicate issue numbers" do
    issues = ["CC-237", "CC-512", "CC-237"]
    assert filtered_issues(issues) == ["CC-237", "CC-512"]
  end

  test "creates a proper url for an issue" do
    assert url_for_issue("CC-123") == "http://example.com/browse/CC-123"
  end

  test "creates a proper authorization header" do
    assert authorization_header["Authorization"] == "Basic foo"
  end
end

#https://github.prod.env.teladoc.com/Teladoc/member/pull/1467\r\nhttps://github.prod.env.teladoc.com/Teladoc/client/pull/145\r\nhttps://github.prod.env.teladoc.com/Teladoc/provider/pull/908\r\nhttps://github.prod.env.teladoc.com/Teladoc/tas/pull/3214\r\nhttps://github.prod.env.teladoc.com/Teladoc/admin/pull/1262\r\nhttps://github.prod.env.teladoc.com/Teladoc/callcenter/pull/835\r\nhttps://github.prod.env.teladoc.com/Teladoc/teladoc_framework/pull/1164\r\nhttps://github.prod.env.teladoc.com/Teladoc/teladoc_constants_gem/pull/355\r\nhttps://github.prod.env.teladoc.com/TeladocMobile/mobile_api/pull/825\r\nThis code has a feature toggle function in Redis.  The feature will be deployed with the toggle in the disabled position.  Upon UAT approval the feature toggle will be switched to \"enable\".
