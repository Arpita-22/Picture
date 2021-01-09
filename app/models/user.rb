class User < ApplicationRecord
    has_many :images
    has_many :image_tags, through: :images
    has_many :tags, through: :image_tags
    has_secure_password
end
