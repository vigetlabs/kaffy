ExUnit.start()

defmodule KaffyTest.Schemas.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "people" do
    field(:name, :string)
    field(:age, :integer)
    field(:married, :boolean, default: false)
    field(:birth_date, :date)
    field(:address, :string)
    has_many(:pets, KaffyTest.Schemas.Pet)
  end

  def changeset(person, params \\ %{}) do
    person
    |> cast(params, [:name, :age, :married, :birth_date, :address])
  end
end

defmodule KaffyTest.Admin.PersonAdmin do
  def index(_) do
    [
      name: nil,
      married: %{value: fn p -> if p.married, do: "yes", else: "no" end}
    ]
  end

  def form_fields(_schema) do
    [
      address: %{render_form: &render_form/5}
    ]
  end

  def render_form(_conn, _changeset, _form, _field, _options) do
    [
      {:safe, ~s(<div class="form-group">Custom Form Field Goes Here.</div>)}
    ]
  end
end

defmodule KaffyTest.Schemas.Pet do
  use Ecto.Schema

  schema "pets" do
    field(:name, :string)
    field(:type, :string, default: "feline")
    field(:weight, :decimal)
    belongs_to(:person, KaffyTest.Schemas.Person)
  end
end
