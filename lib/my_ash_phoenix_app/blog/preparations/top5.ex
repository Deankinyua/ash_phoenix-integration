defmodule MyAshPhoenixApp.Preparations.Top5 do
  use Ash.Resource.Preparation

  # transform and validate opts
  @impl true
  def init(opts) do
    if is_atom(opts[:attribute]) do
      {:ok, opts}
    else
      {:error, "attribute must be an atom!"}
    end
  end

  @impl true
  def prepare(query, opts, _context) do
    attribute = opts[:attribute]

    query
    |> Ash.Query.sort([{attribute, :desc}])
    |> Ash.Query.limit(5)
  end
end
