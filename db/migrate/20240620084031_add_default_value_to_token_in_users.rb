class AddDefaultValueToTokenInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :token, 1
  end
end
