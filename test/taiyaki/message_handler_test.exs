defmodule MessageHandlerTest do
  use ExUnit.Case

  setup do
    user_id = "<@UKBN393PY>"
    users = %{
      "UJY4BAA03" => %{
        deleted: false,
        name: "rabeagleissner",
        real_name: "Rabea",
        presence: "away",
      },
      "UKBN393PY" => %{
        name: "Sam.Smith",
        real_name: "Sam Smith",
        presence: "away",
      }
    }
    message = %{
      channel: "DKTLX8RMY",
      team: "TKBBY6QSK",
      text: "Where is #{user_id}",
      type: "message",
      user: "UJY4BAA03",
    }

    %{users: users, message: message, user_id: user_id}
  end

  test "returns message for correct command", %{users: users, message: message, user_id: user_id} do
    ret = Taiyaki.MessageHandler.handle_message(message, users)
    assert ret == {:ok, "UKBN393PY", "UJY4BAA03",  "I'll let you know when #{user_id} comes online"}
  end

  test "returns error message when command is not recognised", %{users: users, message: message} do
    message = Map.put(message, :text, "No valid command")
    ret = Taiyaki.MessageHandler.handle_message(message, users)
    assert ret == {:invalid, "", "This is beyond my capabilities!"}
  end
end
