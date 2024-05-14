defmodule MyAshPhoenixApp.Blog do
  use Ash.Domain

  resources do
    resource MyAshPhoenixApp.Blog.Post do
      # Define an interface for calling resource actions.
      define :create_posts, action: :create
      define :list_posts, action: :read
      define :update_post, action: :update
      define :destroy_post, action: :destroy
      define :get_post, args: [:id], action: :by_id
    end

    resource MyAshPhoenixApp.Blog.Product do
      # Define an interface for calling resource actions.
      define :create_product, action: :create
      define :list_products, action: :read
      define :update_products, action: :update
      define :destroy_product, action: :destroy
      define :get_product, args: [:id], action: :by_id
    end
  end
end
