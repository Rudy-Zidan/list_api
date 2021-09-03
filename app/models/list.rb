# frozen_string_literal: true

class List < ApplicationRecord
  default_scope -> { where(deleted_at: nil) }

  include Concerns::Errors
  include Concerns::SoftDelete

  has_many :items, dependent: :delete_all
  has_many :active_items, -> { where(deleted_at: nil) }, class_name: 'Item'

  validates :name, presence: true

  accepts_nested_attributes_for :items
end
