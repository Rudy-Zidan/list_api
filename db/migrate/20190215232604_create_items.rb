# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :list
      t.string :title
      t.string :description
      t.datetime :deleted_at
      t.timestamps
    end

    add_index :items, :deleted_at
  end
end
