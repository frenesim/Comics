class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :comic_id
      t.string :user_session
      t.boolean :vote

      t.timestamps
    end
  end
end
