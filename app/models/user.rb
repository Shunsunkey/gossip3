class User < ApplicationRecord
    has_many :gossips
    has_many :recipients
    has_many :messages, through: :recipients
    has_many :likes
    has_many :liked_gossips, through: :likes, source: :gossip
    has_many :comments
  
    belongs_to :city
  
    validates :first_name, :last_name, presence: true
    validates :age, numericality: { only_integer: true, greater_than: 0 }
    validates :city, presence: true
    validates :password, presence: true
  
    has_secure_password
    def name
        "#{first_name} #{last_name}"
    end
  end
  