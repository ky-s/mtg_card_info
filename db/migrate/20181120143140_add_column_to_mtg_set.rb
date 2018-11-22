class AddColumnToMtgSet < ActiveRecord::Migration[5.2]
  def change
    add_column :mtg_sets, :fetched, :boolean, default: false, null: false
    add_column :mtg_sets, :image_fetched, :boolean, default: false, null: false
  end
end
