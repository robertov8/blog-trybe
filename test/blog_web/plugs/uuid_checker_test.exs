defmodule BlogWeb.Plugs.UUIDCheckerTest do
  use BlogWeb.ConnCase, async: true

  alias BlogWeb.Plugs.UUIDChecker

  test "init" do
    assert UUIDChecker.init([]) == []
  end

  describe "call/2" do
    test "when token is invalid, return status 400 and error response", %{conn: conn} do
      params = Map.merge(conn.params, %{"uuid" => "accff382-6d49-4a2d-821c-aafd3399ccd91"})

      conn_plug_uuid = UUIDChecker.call(%{conn | params: params}, %{})

      assert %Plug.Conn{status: 400, resp_body: ~s({"messsage":"UUID inválido"})} = conn_plug_uuid
    end
  end
end
