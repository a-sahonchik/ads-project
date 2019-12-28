# frozen_string_literal: true

# Root
crumb :root do
  link I18n.t('navigation.main'), root_path
end

# Advertisements list
crumb :advertisements do
  link I18n.t('models.advertisements'), advertisements_path
end

# Categories list
crumb :categories do
  link I18n.t('models.categories'), categories_path
end

# Category
crumb :category do |category|
  link I18n.t("attributes.category.id.#{category.id}"), category
  parent :advertisements
end

# Advertisement
crumb :advertisement do |advertisement|
  link advertisement.ad_title, advertisement_path
  parent advertisement.category
end
