class MessagesChangecolumnstypes < ActiveRecord::Migration[7.1]
  def change
    change_column :messages, :content, :string
  end
end
