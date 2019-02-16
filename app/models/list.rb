class List < ApplicationRecord
  include Concerns::SoftDelete

  has_many :items, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :items, allow_destroy: true
end
