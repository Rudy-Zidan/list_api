class ItemsController < ApplicationController
  before_action :set_item, only: %i(delete)

  def trash
    render json: Item.only_deleted, include: :list, status: :ok
  end

  def delete
    @item.really_destroy!
    head :ok
  end

  private

  def set_item
    @item = Item.with_deleted.find(params[:id])
  end
end
