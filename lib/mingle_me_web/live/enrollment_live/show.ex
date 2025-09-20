defmodule MingleMeWeb.EnrollmentLive.Show do
  use MingleMeWeb, :live_view

  alias MingleMe.Enrollments

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Enrollment {@enrollment.id}
        <:subtitle>This is a enrollment record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/enrollments"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/enrollments/#{@enrollment}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit enrollment
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="User">{@enrollment.user_id}</:item>
        <:item title="Season">{@enrollment.season_id}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Enrollment")
     |> assign(:enrollment, Enrollments.get_enrollment!(id))}
  end
end
