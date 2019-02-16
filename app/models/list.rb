class List < ApplicationRecord
  include Concerns::SoftDelete

  has_many :items, dependent: :destroy

  validates :name, presence: true
end
