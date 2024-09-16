defmodule KaffyWeb.CustomDashboardController do
  @moduledoc false

  use Phoenix.Controller, namespace: KaffyWeb

  def index(conn, %{"context" => context}) do
    my_dashboard = Kaffy.Utils.get_dashboard(conn, context)
    widgets = case !is_nil(my_dashboard) && Kaffy.Utils.has_function?(my_dashboard, :widgets) do
      true -> apply(my_dashboard, :widgets, [conn])
      false -> []
    end
    name = Kaffy.Utils.dashboard_context_name(conn, context)

    render(conn, "index.html",
      dashboard_context: context,
      widgets: widgets,
      name: name)
  end
end
