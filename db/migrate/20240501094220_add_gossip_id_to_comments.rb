class AddGossipIdToComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :gossip, null: false, foreign_key: true
  end
end
