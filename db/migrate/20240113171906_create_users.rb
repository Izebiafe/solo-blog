class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :photo
      t.text :bio
      t.integer :posts_count, default: 0

      t.timestamps null: false
    end
  end
end
