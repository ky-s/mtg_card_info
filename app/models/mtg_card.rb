class MtgCard < ApplicationRecord
  has_one_attached :image

  def title_label
    "#{jp_name} (#{rarity})"
  end
end
