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

  def bulk_generate(n)
    n.times.each_with_object([]) { |_i, cards| cards.concat(generate) }
      .sort
      .group_by(&:rarity)
      .values_at('Mythic Rare', 'Mythic', 'Rare', 'Uncommon', 'Common').flatten.compact
  end

  def select_cards(potential_rarity, n)
    potential_rarity = Array(potential_rarity).map { |rarity| rarity.gsub('foil ', '') }
    puts potential_rarity
    if potential_rarity == %w(rare mythic\ rare)
      rares_or_mythic_rares(n)
    else
      MtgCard.where(set: @set.code, rarity: Array(potential_rarity)).sample(n)
    end
  end

  def rares_or_mythic_rares(n)
    rarity = 'rare'
    rarity = ['mythic rare', 'mythic'] if Random::rand(1..8) == 1
    n.times.map do
      MtgCard.where(set: @set.code, rarity: rarity).sample
    end
  end
end
