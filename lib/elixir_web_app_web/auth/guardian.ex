defmodule ElixirWebAppWeb.Guardian do
  use Guardian, otp_app: :elixir_web_app

  alias ElixirWebApp.Repo
  alias ElixirWebApp.User

  def subject_for_token(user = %User{}, _claims) do
    { :ok, "User:#{user.id}" }
  end

  def subject_for_token(_, _) do
    { :error, :unknown_resource }
  end

  def resource_from_claims(%{"sub" => "User:" <> uid_str}) do
    try do
      case Integer.parse(uid_str) do
        {id, ""} ->
          {:ok, Repo.get(User, id)}
        _ ->
          {:error, :invalid_id}
      end
      rescue
        Ecto.NoResultsError -> {:error, :no_result}
    end
  end

  def resource_from_claims(_) do
    {:error, :invalid_claims}
  end
end
