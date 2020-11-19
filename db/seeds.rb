# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'
require 'faker'

Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

buffer = open(url).read

ingredients = JSON.parse(buffer)

all_ingredients = []

ingredients["drinks"].each do |ingredient|
  ingredient_created = Ingredient.create(name: ingredient["strIngredient1"])
  all_ingredients << ingredient_created
end

8.times do
  attributes = {
    name: Faker::Coffee.blend_name,
    description: Faker::Coffee.notes,
    img_url: ['https://images.unsplash.com/photo-1546171753-97d7676e4602?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60', 'https://images.unsplash.com/photo-1563223771-5fe4038fbfc9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60', 'https://images.unsplash.com/photo-1558645836-e44122a743ee?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60', 'https://images.unsplash.com/photo-1601924381523-019b78541b95?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60', 'https://images.unsplash.com/photo-1486947799489-3fabdd7d32a6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60', 'https://images.unsplash.com/photo-1563223771-375783ee91ad?ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=60'].sample
  }

  cocktail = Cocktail.create!(attributes)

  5.times do
  one_ingredient = all_ingredients.sample

  doses_attributes = {
    description: "#{rand(1..5)} #{["handful", "part"].sample}",
    cocktail: cocktail,
    ingredient: one_ingredient
  }

  dose = Dose.create!(doses_attributes)

  puts "created #{cocktail.name} with #{dose.description} of #{one_ingredient.name}"
  end
end
