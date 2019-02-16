class ListsController < ApplicationController
  def index
    render json: List.all, include: :items, status: :ok
  end

  def trash
    render json: List.only_deleted, include: :items, status: :ok
  end
end
