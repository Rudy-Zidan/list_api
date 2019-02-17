class List < ApplicationRecord
  default_scope -> { where(deleted_at: nil) }

  include Concerns::SoftDelete

  has_many :items, dependent: :delete_all

  validates :name, presence: true

  accepts_nested_attributes_for :items
end
