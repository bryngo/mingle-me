defmodule MingleMeWeb.SeasonLiveTest do
  use MingleMeWeb.ConnCase

  import Phoenix.LiveViewTest
  import MingleMe.SeasonsFixtures

  @create_attrs %{
    name: "some name",
    start_time: "2025-09-06T05:37:00Z",
    end_time: "2025-09-06T05:37:00Z",
    max_participants: 42
  }
  @update_attrs %{
    name: "some updated name",
    start_time: "2025-09-07T05:37:00Z",
    end_time: "2025-09-07T05:37:00Z",
    max_participants: 43
  }
  @invalid_attrs %{name: nil, start_time: nil, end_time: nil, max_participants: nil}
  defp create_season(_) do
    season = season_fixture()

    %{season: season}
  end

  describe "Index" do
    setup [:create_season]

    test "lists all seasons", %{conn: conn, season: season} do
      {:ok, _index_live, html} = live(conn, ~p"/seasons")

      assert html =~ "Listing Seasons"
      assert html =~ season.name
    end

    test "saves new season", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/seasons")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Season")
               |> render_click()
               |> follow_redirect(conn, ~p"/seasons/new")

      assert render(form_live) =~ "New Season"

      assert form_live
             |> form("#season-form", season: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#season-form", season: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/seasons")

      html = render(index_live)
      assert html =~ "Season created successfully"
      assert html =~ "some name"
    end

    test "updates season in listing", %{conn: conn, season: season} do
      {:ok, index_live, _html} = live(conn, ~p"/seasons")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#seasons-#{season.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/seasons/#{season}/edit")

      assert render(form_live) =~ "Edit Season"

      assert form_live
             |> form("#season-form", season: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#season-form", season: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/seasons")

      html = render(index_live)
      assert html =~ "Season updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes season in listing", %{conn: conn, season: season} do
      {:ok, index_live, _html} = live(conn, ~p"/seasons")

      assert index_live |> element("#seasons-#{season.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#seasons-#{season.id}")
    end
  end

  describe "Show" do
    setup [:create_season]

    test "displays season", %{conn: conn, season: season} do
      {:ok, _show_live, html} = live(conn, ~p"/seasons/#{season}")

      assert html =~ "Show Season"
      assert html =~ season.name
    end

    test "updates season and returns to show", %{conn: conn, season: season} do
      {:ok, show_live, _html} = live(conn, ~p"/seasons/#{season}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/seasons/#{season}/edit?return_to=show")

      assert render(form_live) =~ "Edit Season"

      assert form_live
             |> form("#season-form", season: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#season-form", season: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/seasons/#{season}")

      html = render(show_live)
      assert html =~ "Season updated successfully"
      assert html =~ "some updated name"
    end
  end
end
