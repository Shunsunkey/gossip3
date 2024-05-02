# app/models/like.rb
class Like < ApplicationRecord
    belongs_to :user
    belongs_to :gossip
  
    validates :user_id, uniqueness: { scope: :gossip_id, message: "Vous ne pouvez aimer qu'une fois ce potin." }
  end
  