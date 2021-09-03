# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :set_item, only: %i[destroy restore delete]

  def trash
    render json: Item.only_deleted.includes(:list), include: :list, status: :ok
  end

  def destroy
    @item.soft_delete!

    render json: @item, include: :list, status: :ok
  end

  def restore
    @item.restore!

    render json: @item, include: :list, status: :ok
  end

  def delete
    @item.destroy

    head :ok
  end

  private

  def set_item
    @item = Item.with_deleted.includes(:list).find(params[:id])
  end
end
