defmodule MingleMeWeb.SeasonLive.Index do
  use MingleMeWeb, :live_view

  alias MingleMe.Seasons

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Seasons
        <:actions>
          <.button variant="primary" navigate={~p"/seasons/new"}>
            <.icon name="hero-plus" /> New Season
          </.button>
        </:actions>
      </.header>

      <.table
        id="seasons"
        rows={@streams.seasons}
        row_click={fn {_id, season} -> JS.navigate(~p"/seasons/#{season}") end}
      >
        <:col :let={{_id, season}} label="Name">{season.name}</:col>
        <:col :let={{_id, season}} label="Start time">{season.start_time}</:col>
        <:col :let={{_id, season}} label="End time">{season.end_time}</:col>
        <:col :let={{_id, season}} label="Max participants">{season.max_participants}</:col>
        <:action :let={{_id, season}}>
          <div class="sr-only">
            <.link navigate={~p"/seasons/#{season}"}>Show</.link>
          </div>
          <.link navigate={~p"/seasons/#{season}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, season}}>
          <.link
            phx-click={JS.push("delete", value: %{id: season.id}) |> hide("##{id}")}
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
     |> assign(:page_title, "Listing Seasons")
     |> stream(:seasons, list_seasons())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    season = Seasons.get_season!(id)
    {:ok, _} = Seasons.delete_season(season)

    {:noreply, stream_delete(socket, :seasons, season)}
  end

  defp list_seasons() do
    Seasons.list_seasons()
  end
end
