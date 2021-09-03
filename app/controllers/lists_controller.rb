# frozen_string_literal: true

class ListsController < ApplicationController
  before_action :set_list, only: %i[show update destroy restore delete]

  def index
    render json: List.all.includes(:active_items), include: :active_items, status: :ok
  end

  def trash
    render json: List.only_deleted.includes(:items), include: :items, status: :ok
  end

  def show
    render json: @list, include: :items, status: :ok
  end

  def create
    list = List.create(list_params)

    if list.errors.any?
      render json: list.pretty_validation_errors, status: :unprocessable_entity
    else
      render json: list, include: :items, status: :created
    end
  end

  def update
    @list.update(list_params)

    if @list.errors.any?
      render json: @list.errors.messages, status: :unprocessable_entity
    else
      render json: @list, include: :items, status: :ok
    end
  end

  def destroy
    @list.soft_delete!

    render json: @list, include: :items, status: :ok
  end

  def restore
    @list.restore!

    render json: @list, include: :items, status: :ok
  end

  def delete
    @list.destroy

    head :ok
  end

  private

  def set_list
    @list = List.with_deleted.includes(:items).find(params[:id])
  end

  def list_params
    params.permit(
      :id, :name, items_attributes: %i[id title description]
    )
  end
end
