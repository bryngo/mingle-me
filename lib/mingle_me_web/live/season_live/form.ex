defmodule MingleMeWeb.SeasonLive.Form do
  use MingleMeWeb, :live_view

  alias MingleMe.Seasons
  alias MingleMe.Seasons.Season

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage season records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="season-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:start_time]} type="datetime-local" label="Start date" />
        <.input field={@form[:end_time]} type="datetime-local" label="End date" />

        <.input field={@form[:max_participants]} type="number" label="Max participants" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Season</.button>
          <.button navigate={return_path(@return_to, @season)}>Cancel</.button>
        </footer>
      </.form>
    </Layouts.app>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(:return_to, return_to(params["return_to"]))
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp return_to("show"), do: "show"
  defp return_to(_), do: "index"

  defp apply_action(socket, :edit, %{"id" => id}) do
    season = Seasons.get_season!(id)

    socket
    |> assign(:page_title, "Edit Season")
    |> assign(:season, season)
    |> assign(:form, to_form(Seasons.change_season(season)))
  end

  defp apply_action(socket, :new, _params) do
    season = %Season{}

    socket
    |> assign(:page_title, "New Season")
    |> assign(:season, season)
    |> assign(:form, to_form(Seasons.change_season(season)))
  end

  @impl true
  def handle_event("validate", %{"season" => season_params}, socket) do
    changeset = Seasons.change_season(socket.assigns.season, season_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"season" => season_params}, socket) do
    save_season(socket, socket.assigns.live_action, season_params)
  end

  defp save_season(socket, :edit, season_params) do
    case Seasons.update_season(socket.assigns.season, season_params) do
      {:ok, season} ->
        {:noreply,
         socket
         |> put_flash(:info, "Season updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, season))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_season(socket, :new, season_params) do
    case Seasons.create_season(season_params) do
      {:ok, season} ->
        {:noreply,
         socket
         |> put_flash(:info, "Season created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, season))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _season), do: ~p"/seasons"
  defp return_path("show", season), do: ~p"/seasons/#{season}"
end
