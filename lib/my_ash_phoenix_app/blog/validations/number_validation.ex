defmodule MyAshPhoenixApp.Blog.NumberValidation do
  # * Currently not using this File but it is here to remember Validations and how to write them
  use Ash.Resource.Validation

  def validate(changeset, opts) do
    case Ash.Changeset.fetch_argument_or_change(changeset, opts[:field]) do
      :error ->
        # in this case, they aren't changing the field
        :ok

      {:ok, value} ->
        if value < 5 do
          {:error,
           field: opts[:field], message: "the price must be greater or equal to 4 dollars"}
        else
          :ok
        end
    end
  end
end
