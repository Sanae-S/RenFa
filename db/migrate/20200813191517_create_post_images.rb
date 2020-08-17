class CreatePostImages < ActiveRecord::Migration[5.2]
  def change
    create_table :post_images do |t|
      t.string :animal_name, null: false, default: ""
      t.string :image_id, null: false, default: ""
      t.text :introduction, null: false, default: ""
      t.integer :user_id, null: false, default: ""

      t.timestamps
    end
  end
end
