# 2 rails modules
require 'json'
require 'open-uri'

p 'Cleaning database...'
Cocktail.destroy_all
Ingredient.destroy_all

# Check the present keys from the API
def ing_key?(k, v)
  k.index("strIngredient") && v != ""
end

def dose_key?(k, v)
  k.index("strMeasure") && v != ""
end

p 'Creating ingredients...'
INGREDIENTS_URL = 'http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_json = open(INGREDIENTS_URL).read
# .read extract the json file & accesses the ingredients_json
ingredients_parsed = JSON.parse(ingredients_json)
# .parse will transform from json to a hash

ingredients = []

ingredients_parsed["drinks"].uniq.each do |ingredient|
  ingredients << Ingredient.create(name: ingredient.values.first)
end
p 'Ingredients have been successfully created!'

p 'Creating cocktails'
RANDOM_COCKTAIL_URL = "http://www.thecocktaildb.com/api/json/v1/1/random.php"

20.times do
  # Parsing from the API
  cocktail_json = open(RANDOM_COCKTAIL_URL).read
  cocktail_parsed = JSON.parse(cocktail_json)
  cocktail_data = cocktail_parsed["drinks"].first

  # To make sure we don't create twice the same cocktail
  next if Cocktail.find_by_name(cocktail_data["strDrink"])

  c = Cocktail.create(name: cocktail_data["strDrink"], picture: cocktail_data["strDrinkThumb"])
  ing = nil

  cocktail_data.select { |k, v| ing_key?(k, v)}.to_h.each_with_index do |(k, v), i|
    next if v.nil?
      ing = Ingredient.find_by_name(v) ? Ingredient.find_by_name(v) : Ingredient.create(name: v)
    next if c.ingredients.include?(ing)
    c.ingredients << ing

    dose = Dose.find_by_ingredient_id_and_cocktail_id(ing.id, c.id)
    dose.description = cocktail_data.select { |k, v| dose_key?(k, v)}.to_h.values[i].strip

    ing.doses << dose
  end
end
p 'Cocktails have been successfully created!'
