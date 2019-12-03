# Root
crumb :root do
  link "Главная", root_path
end

# Advertisements list
crumb :advertisements do
  link "Объявления", advertisements_path
end

# Category
crumb :category do |category|
  link category.name, category_path
  parent :advertisements
end

# Advertisement
crumb :advertisement do |advertisement|
  link advertisement.ad_title, advertisement_path
  parent advertisement.category
end
