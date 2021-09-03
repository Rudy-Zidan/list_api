# frozen_string_literal: true

class Item < ApplicationRecord
  include Concerns::SoftDelete

  belongs_to :list

  validates :title, presence: true
end
