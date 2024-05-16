defmodule MyAshPhoenixAppWeb.Streams do
  # * This Module Shows how to work with Streams to address large collections of data

  use MyAshPhoenixAppWeb, :live_view
  alias MyAshPhoenixApp.Blog

  def render(assigns) do
    ~H"""
    <div id="products" phx-update="stream">
      <div :for={{id, product} <- @streams.products} id={id}>
        <%= product.name %>
      </div>
    </div>
    """
  end

  def mount(_, _, socket) do
    products = Blog.list_products!()
    {:ok, stream(socket, :products, products)}
  end

  def handle_info({:user_added, new_product}, socket) do
    {:noreply, stream_insert(socket, :products, new_product)}
  end
end
