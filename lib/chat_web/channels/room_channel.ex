defmodule ChatWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end
  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast!(socket, "new_msg", %{body: body})
    {:noreply, socket}
  end

  intercept ["new_msg"]

  def handle_out("new_msg", %{body: body} = msg, socket) do
    case body == "troll" do
      true -> {:noreply, socket}
      _ -> push(socket, "new_msg", msg)
        {:noreply, socket}
    end
  end
end
