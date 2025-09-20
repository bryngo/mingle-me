defmodule MingleMeWeb.SeasonLive.Show do
  use MingleMeWeb, :live_view

  alias MingleMe.Seasons

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Season {@season.id}
        <:subtitle>This is a season record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/seasons"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/seasons/#{@season}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit season
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Name">{@season.name}</:item>
        <:item title="Start date">{@season.start_time}</:item>
        <:item title="End date">{@season.end_time}</:item>
        <:item title="Max participants">{@season.max_participants}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Season")
     |> assign(:season, Seasons.get_season!(id))}
  end
end
