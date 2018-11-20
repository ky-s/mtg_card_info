class CreateMtgCards < ActiveRecord::Migration[5.2]
  def change
    create_table :mtg_cards do |t|
      t.integer :multiverse_id
      t.string :name
      t.string :jp_name
      t.string :img_url
      t.string :set
      t.string :rarity

      t.timestamps
    end
  end
end
