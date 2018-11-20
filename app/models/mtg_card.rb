class MtgCard < ApplicationRecord
  def title_label
    "#{jp_name} (#{rarity})"
  end
end
