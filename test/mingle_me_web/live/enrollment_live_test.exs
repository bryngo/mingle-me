defmodule MingleMeWeb.EnrollmentLiveTest do
  use MingleMeWeb.ConnCase

  import Phoenix.LiveViewTest
  import MingleMe.EnrollmentsFixtures

  @create_attrs %{user_id: 42, season_id: 42}
  @update_attrs %{user_id: 43, season_id: 43}
  @invalid_attrs %{user_id: nil, season_id: nil}
  defp create_enrollment(_) do
    enrollment = enrollment_fixture()

    %{enrollment: enrollment}
  end

  describe "Index" do
    setup [:create_enrollment]

    test "lists all enrollments", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/enrollments")

      assert html =~ "Listing Enrollments"
    end

    test "saves new enrollment", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/enrollments")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Enrollment")
               |> render_click()
               |> follow_redirect(conn, ~p"/enrollments/new")

      assert render(form_live) =~ "New Enrollment"

      assert form_live
             |> form("#enrollment-form", enrollment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#enrollment-form", enrollment: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/enrollments")

      html = render(index_live)
      assert html =~ "Enrollment created successfully"
    end

    test "updates enrollment in listing", %{conn: conn, enrollment: enrollment} do
      {:ok, index_live, _html} = live(conn, ~p"/enrollments")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#enrollments-#{enrollment.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/enrollments/#{enrollment}/edit")

      assert render(form_live) =~ "Edit Enrollment"

      assert form_live
             |> form("#enrollment-form", enrollment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#enrollment-form", enrollment: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/enrollments")

      html = render(index_live)
      assert html =~ "Enrollment updated successfully"
    end

    test "deletes enrollment in listing", %{conn: conn, enrollment: enrollment} do
      {:ok, index_live, _html} = live(conn, ~p"/enrollments")

      assert index_live |> element("#enrollments-#{enrollment.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#enrollments-#{enrollment.id}")
    end
  end

  describe "Show" do
    setup [:create_enrollment]

    test "displays enrollment", %{conn: conn, enrollment: enrollment} do
      {:ok, _show_live, html} = live(conn, ~p"/enrollments/#{enrollment}")

      assert html =~ "Show Enrollment"
    end

    test "updates enrollment and returns to show", %{conn: conn, enrollment: enrollment} do
      {:ok, show_live, _html} = live(conn, ~p"/enrollments/#{enrollment}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/enrollments/#{enrollment}/edit?return_to=show")

      assert render(form_live) =~ "Edit Enrollment"

      assert form_live
             |> form("#enrollment-form", enrollment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#enrollment-form", enrollment: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/enrollments/#{enrollment}")

      html = render(show_live)
      assert html =~ "Enrollment updated successfully"
    end
  end
end
