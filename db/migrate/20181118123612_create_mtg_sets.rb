class CreateMtgSets < ActiveRecord::Migration[5.2]
  def change
    create_table :mtg_sets do |t|
      t.string :code
      t.string :name
      t.string :type
      t.string :border
      t.integer :mkm_id
      t.text :booster
      t.date :release_date
      t.string :block

      t.timestamps
    end
  end
end
