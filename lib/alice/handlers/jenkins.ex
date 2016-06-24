defmodule Alice.Handlers.Jenkins do
  use Alice.Router
  import Application, only: [get_env: 2]

  alias Alice.Conn
  alias Alice.Router.Helpers

  command ~r/deploy (\S+)\/?(\S+)? to (\S+)/i, :deploy


  @doc """
  Adds the ability to deploy things
  """
  def deploy(conn) do
    deploy_parameters = ~r/deploy (\S+)\/(\S+) to (\S+)/i |> Regex.scan(conn.message.text) |> List.flatten
    application = Enum.at(deploy_parameters, 1)
    branch = Enum.at(deploy_parameters,2)
    server = Enum.at(deploy_parameters,3)
    case HTTPoison.post(create_url_for_deploy(application, branch, server), "", deploy_headers) do
      {:ok, _} -> "Deploying branch #{branch} of #{application} to #{server}" |> reply(conn)
      {:error, _} -> "Unable to deploy #{branch} of #{application} to #{server}" |> reply(conn)
    end
  end

  def create_url_for_deploy(application, branch, server) do
    jenkins_host = Application.get_env(:alice, :jenkins_host)
    job = Application.get_env(:alice, :jenkins_job)
    uri = "#{jenkins_host}/job/#{job}/buildWithParameters?DEPLOY_ENV=#{server}&DEPLOY_TARGET=#{application}&DEPLOY_BRANCH=#{branch}"
    URI.encode(uri)
  end

  def deploy_headers do
    [{"Authorization", "Basic #{Application.get_env(:alice, :jenkins_token)}"}]
  end
end
