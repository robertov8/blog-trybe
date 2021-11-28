defmodule BlogWeb.HealthControllerTest do
  use BlogWeb.ConnCase, async: true

  describe "auth" do
    test "when you make a request, return ok", %{conn: conn} do
      conn = get(conn, Routes.health_path(conn, :check))

      assert response(conn, :ok) == "ok"
    end
  end
end
