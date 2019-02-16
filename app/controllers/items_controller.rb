class ItemsController < ApplicationController
  def trash
    render json: Item.only_deleted, include: :list, status: :ok
  end
end
