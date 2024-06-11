class AddIconToSkill < ActiveRecord::Migration[7.1]
  def change
    add_column :skills, :icon, :string
  end
end
