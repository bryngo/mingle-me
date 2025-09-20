defmodule MingleMeWeb.EnrollmentLive.Form do
  use MingleMeWeb, :live_view

  alias MingleMe.Enrollments
  alias MingleMe.Enrollments.Enrollment

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage enrollment records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="enrollment-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:user_id]} type="number" label="User" />
        <.input field={@form[:season_id]} type="number" label="Season" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Enrollment</.button>
          <.button navigate={return_path(@return_to, @enrollment)}>Cancel</.button>
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
    enrollment = Enrollments.get_enrollment!(id)

    socket
    |> assign(:page_title, "Edit Enrollment")
    |> assign(:enrollment, enrollment)
    |> assign(:form, to_form(Enrollments.change_enrollment(enrollment)))
  end

  defp apply_action(socket, :new, _params) do
    enrollment = %Enrollment{}

    socket
    |> assign(:page_title, "New Enrollment")
    |> assign(:enrollment, enrollment)
    |> assign(:form, to_form(Enrollments.change_enrollment(enrollment)))
  end

  @impl true
  def handle_event("validate", %{"enrollment" => enrollment_params}, socket) do
    changeset = Enrollments.change_enrollment(socket.assigns.enrollment, enrollment_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"enrollment" => enrollment_params}, socket) do
    save_enrollment(socket, socket.assigns.live_action, enrollment_params)
  end

  defp save_enrollment(socket, :edit, enrollment_params) do
    case Enrollments.update_enrollment(socket.assigns.enrollment, enrollment_params) do
      {:ok, enrollment} ->
        {:noreply,
         socket
         |> put_flash(:info, "Enrollment updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, enrollment))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_enrollment(socket, :new, enrollment_params) do
    case Enrollments.create_enrollment(enrollment_params) do
      {:ok, enrollment} ->
        {:noreply,
         socket
         |> put_flash(:info, "Enrollment created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, enrollment))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _enrollment), do: ~p"/enrollments"
  defp return_path("show", enrollment), do: ~p"/enrollments/#{enrollment}"
end
