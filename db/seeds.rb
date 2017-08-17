# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 2 rails modules
require 'json'
require 'open-uri'

puts 'Seeding database...'
url = 'http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
text = open(url).read
# .read extract the json file & accesses the text
ingredients = JSON.parse(text)
# .parse will transform from json to a hash

ingredients["drinks"].each do |ingredient|
  Ingredient.create(name: ingredient["strIngredient1"])
end
puts 'Finished!'
