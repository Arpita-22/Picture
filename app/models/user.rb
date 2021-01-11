class User < ApplicationRecord
    has_many :images
    has_many :image_tags, through: :images
    has_many :tags, through: :image_tags

    validates :username, uniqueness: { case_sensitive: false }
    validates :password, confirmation: { case_sensitive: true }

    has_secure_password
end
