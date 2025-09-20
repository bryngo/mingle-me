defmodule MingleMeWeb.EnrollmentLive.Index do
  use MingleMeWeb, :live_view

  alias MingleMe.Enrollments

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Enrollments
        <:actions>
          <.button variant="primary" navigate={~p"/enrollments/new"}>
            <.icon name="hero-plus" /> New Enrollment
          </.button>
        </:actions>
      </.header>

      <.table
        id="enrollments"
        rows={@streams.enrollments}
        row_click={fn {_id, enrollment} -> JS.navigate(~p"/enrollments/#{enrollment}") end}
      >
        <:col :let={{_id, enrollment}} label="User">{enrollment.user_id}</:col>
        <:col :let={{_id, enrollment}} label="Season">{enrollment.season_id}</:col>
        <:action :let={{_id, enrollment}}>
          <div class="sr-only">
            <.link navigate={~p"/enrollments/#{enrollment}"}>Show</.link>
          </div>
          <.link navigate={~p"/enrollments/#{enrollment}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, enrollment}}>
          <.link
            phx-click={JS.push("delete", value: %{id: enrollment.id}) |> hide("##{id}")}
            data-confirm="Are you sure?"
          >
            Delete
          </.link>
        </:action>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Listing Enrollments")
     |> stream(:enrollments, list_enrollments())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    enrollment = Enrollments.get_enrollment!(id)
    {:ok, _} = Enrollments.delete_enrollment(enrollment)

    {:noreply, stream_delete(socket, :enrollments, enrollment)}
  end

  defp list_enrollments() do
    Enrollments.list_enrollments()
  end
end
