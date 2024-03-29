# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(0..10).each do |_i|
  List.create(
    name: Faker::Food.dish,
    items_attributes: (0..rand(1...5)).map do |_i|
      {
        title: Faker::Food.spice,
        description: Faker::Food.description
      }
    end
  )
end
