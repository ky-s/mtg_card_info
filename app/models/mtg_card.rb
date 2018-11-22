class MtgCard < ApplicationRecord
  has_one_attached :image

  def title_label
    "#{jp_name} (#{rarity}) [#{number}]"
  end

  def <=>(other)
    number.to_i <=> other.number.to_i
    # number.match(/(\d+)(\w+)/)[1..2] <=> other.number.match(/(\d+)(\w+)/)[1..2]
  end
end
