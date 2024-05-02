class AddDetailsToGossips < ActiveRecord::Migration[7.1]
  def change
    add_column :gossips, :first_name, :string
    add_column :gossips, :last_name, :string
    add_column :gossips, :age, :integer
  end
end
