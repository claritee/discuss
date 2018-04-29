defmodule Discuss.AuthController do
	use Discuss.Web, :controller
  plug Ueberauth

  alias Discuss.User

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}
    changeset = User.changeset(%User{}, user_params)
    signin(conn, changeset)
  end

  def signout(conn, _params) do
    IO.inspect(conn)
    conn
    |> configure_session(drop: true)
    |> redirect(to: topic_path(conn, :index))    
  end

  defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome Back!")
        |> put_session(:user_id, user.id) #add into cookie
        |> redirect(to: topic_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: topic_path(conn, :index))
    end    
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok, user} #TODO: should this call Repo.update??
    end
  end
end