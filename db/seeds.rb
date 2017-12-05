# 2 rails modules
require 'json'
require 'open-uri'

p 'Cleaning database...'


p 'Seeding database...'
url = 'http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
text = open(url).read
# .read extract the json file & accesses the text
ingredients = JSON.parse(text)
# .parse will transform from json to a hash

ingredients["drinks"].each do |ingredient|
  Ingredient.create(name: ingredient["strIngredient1"])
end
p 'Finished!'
