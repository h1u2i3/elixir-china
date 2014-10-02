defmodule ElixirChina.NotificationController do
  import Ecto.Query
  import ElixirChina.ControllerUtils
  use Phoenix.Controller
  alias ElixirChina.Notification

  def index(conn, %{"user_id" => user_id}) do
    current_user_id = get_user_id!(conn)
    if current_user_id !=  String.to_integer(user_id) do
      redirect conn, "/"
    else
      query = from n in Notification, where: n.user_id == ^String.to_integer(user_id), preload: :post
      render conn, "index", notifications: Repo.all(query),
                          user_id: get_session(conn, :user_id)
    end
  end
end