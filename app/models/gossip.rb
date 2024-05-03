class Gossip < ApplicationRecord
    validates :description, presence: true
    validates :title, presence: true
    belongs_to :user
    has_many :gossip_tags, dependent: :destroy
    has_many :tags, through: :gossip_tags
    has_many :comments, dependent: :destroy
    has_many :likes
    has_many :liking_users, through: :likes, source: :user
end
