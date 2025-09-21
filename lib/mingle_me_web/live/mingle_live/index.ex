defmodule MingleMeWeb.MingleLive.Index do
  use MingleMeWeb, :live_view

  alias MingleMe.Seasons

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.table
        id="seasons"
        rows={@streams.seasons}
      >
        <:col :let={{_id, season}} label="Name">{season.name}</:col>
        <:col :let={{_id, season}} label="Start time">{season.start_time}</:col>
        <:col :let={{_id, season}} label="End time">{season.end_time}</:col>
        <:col :let={{_id, season}} label="Max participants">{season.max_participants}</:col>
        <:col :let={{_id, season}} label="Current participants">{season.current_participants}</:col>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Listing Seasons")
     |> stream(:seasons, list_season_with_enrollment_count())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    season = Seasons.get_season!(id)
    {:ok, _} = Seasons.delete_season(season)

    {:noreply, stream_delete(socket, :seasons, season)}
  end

  defp list_season_with_enrollment_count() do
    Seasons.list_seasons_with_enrollment_counts()
    |> Enum.map(fn {season, count} ->
      Map.put(season, :current_participants, count)
    end)
  end
end
