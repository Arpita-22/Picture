class Image < ApplicationRecord
  belongs_to :user
  has_many :image_tags
  has_many :tags, through: :image_tags

  
  #getter
  def tags
    @tags
  end
  
  #setter
  def tags=(value)
    @tags = value
  end
  
end
