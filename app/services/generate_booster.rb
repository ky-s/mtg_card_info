class GenerateBooster
  def initialize(mtg_set)
    @set = mtg_set
  end

  def generate
    return [] unless @set.has_booster?
    return MTG::Set.generate_booster(@set.code) unless @set.fetched?

    @set.booster_array
      .uniq
      .each_with_object([]) { |potential_rarity, res| res.push([potential_rarity, @set.booster_array.count(potential_rarity)]) }
      .each_with_object([]) { |(potential_rarity, n), cards| cards.concat(select_cards(potential_rarity, n)) }
      .compact
      .tap do |cards|
        Rails.logger.debug('GenerateBooster picked these cards.')
        Rails.logger.debug(cards.map(&:title_label))
    end
  end

  def select_cards(potential_rarity, n)
    if potential_rarity == %w(rare mythic\ rare)
      rares_or_mythic_rares(n)
    else
      MtgCard.where(set: @set.code, rarity: Array(potential_rarity)).sample(n)
    end
  end

  def rares_or_mythic_rares(n)
    n.times.map do
      MtgCard.where(set: @set.code, rarity: %w(mythic\ rare rare rare rare rare rare rare rare).sample).sample
    end
  end
end
