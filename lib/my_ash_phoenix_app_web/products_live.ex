# lib/my_ash_phoenix_app_web/products_live.ex

defmodule MyAshPhoenixAppWeb.ProductsLive do
  use MyAshPhoenixAppWeb, :live_view
  alias MyAshPhoenixApp.Blog
  alias MyAshPhoenixApp.Blog.Product

  def render(assigns) do
    ~H"""
    <h2>Products</h2>
    <div>
      <div :for={product <- @products}>
        <div><%= product.name %></div>
        <div><%= if Map.get(product, :price), do: product.price, else: "" %></div>
        <button phx-click="delete_product" phx-value-product-id={product.id}>delete</button>
      </div>
    </div>
    <h2>Create Product</h2>
    <.my_component />
    <.form :let={f} for={@create_form} phx-submit="create_product">
      <.input type="text" field={f[:name]} placeholder="input the product name" />
      <.input type="number" field={f[:price]} placeholder="input product price" />
      <.button type="submit">create</.button>
    </.form>
    <h2>Update Product</h2>
    <.form :let={f} for={@update_form} phx-submit="update_product">
      <.label>Product Name</.label>
      <.input type="select" field={f[:product_id]} options={@product_selector} />
      <.input type="number" field={f[:price]} placeholder="input price" />
      <.button type="submit">Update</.button>
    </.form>
    """
  end

  def mount(_params, _session, socket) do
    products = Blog.list_products!()

    socket =
      assign(socket,
        products: products,
        product_selector: product_selector(products),
        create_form: AshPhoenix.Form.for_create(Product, :create) |> to_form(),
        update_form:
          AshPhoenix.Form.for_update(List.first(products, %Product{}), :update) |> to_form()
      )

    {:ok, socket}
  end

  def handle_event("delete_product", %{"product-id" => product_id}, socket) do
    product_id |> Blog.get_product!() |> Blog.destroy_product!()
    products = Blog.list_products!()

    {:noreply, assign(socket, products: products, product_selector: product_selector(products))}
  end

  def handle_event("create_product", %{"form" => %{"name" => name, "price" => price}}, socket) do
    Blog.create_product(%{name: name, price: price})
    products = Blog.list_products!()

    {:noreply, assign(socket, products: products, product_selector: product_selector(products))}
  end

  def handle_event("update_product", %{"form" => form_params}, socket) do
    %{"product_id" => product_id, "price" => price} = form_params
    product_id |> Blog.get_product!() |> Blog.update_products!(%{price: price})
    products = Blog.list_products!()

    {:noreply, assign(socket, products: products, product_selector: product_selector(products))}
  end

  defp product_selector(products) do
    for product <- products do
      {product.name, product.id}
    end
  end
end
