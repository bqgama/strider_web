class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.date :date_joined, null: false

      t.timestamps
    end
  end
end
