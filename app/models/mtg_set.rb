class MtgSet < ApplicationRecord
  self.inheritance_column = :_type_disabled

  def has_booster?
    booster.present?
  end

  def booster_array
    return [] unless has_booster?
    eval(booster)
  end

  def booster_including_info
    return {} unless has_booster?
    b = booster_array
    b.uniq.each_with_object({}) do |rarity, h|
      h[Array(rarity).join(' or ')] = b.count(rarity)
    end
  end
end
