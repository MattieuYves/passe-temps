class CreateSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :sessions do |t|
      t.integer :duration
      t.integer :token_cost
      t.string :session_format
      t.references :skill, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.text :content
      t.string :status

      t.timestamps
    end
  end
end
