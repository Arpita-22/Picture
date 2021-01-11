class Image < ApplicationRecord
  belongs_to :user
  has_many :image_tags
  has_many :tags, through: :image_tags

  # def primary_category
  #   @virtual_attribute
  # end
  
  # #setter
  # def primary_category=(value)
  #   @primary_categories = value
  # end

  # def primary_category
  #   @primary_categories
  # end
  
  # #setter
  # def primary_categories=(value)
  #   @primary_categories = value
  # end
end
