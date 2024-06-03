class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :age, :integer
    add_column :users, :genre, :string
    add_column :users, :bio, :text
    add_column :users, :city, :string
    add_column :users, :area, :integer
    add_column :users, :token, :integer
  end
end
