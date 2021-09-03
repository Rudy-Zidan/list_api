# frozen_string_literal: true

class CreateList < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.string :name
      t.datetime :deleted_at
      t.timestamps
    end

    add_index :lists, :deleted_at
  end
end
