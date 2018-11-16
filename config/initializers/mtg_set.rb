class MTG::Set
  def has_booster?
    booster.present?
  end

  def booster_including
    return [] unless has_booster?
    booster.uniq.each_with_object({}) do |rarity, h|
      h[Array(rarity).join(' or ')] = booster.count(rarity)
    end
  end
end
