class CreateSkills < ActiveRecord::Migration[7.1]
  def change
    create_table :skills do |t|
      t.string :name
      t.string :goal
      t.integer :experience_year
      t.references :user, null: false, foreign_key: true
      t.string :category

      t.timestamps
    end
  end
end
