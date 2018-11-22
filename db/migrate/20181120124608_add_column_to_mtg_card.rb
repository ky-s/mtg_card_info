class AddColumnToMtgCard < ActiveRecord::Migration[5.2]
  def change
    add_column :mtg_cards, :colors, :string
    add_column :mtg_cards, :color_identity, :string
    add_column :mtg_cards, :number, :string
    add_column :mtg_cards, :artist, :string
  end
end
