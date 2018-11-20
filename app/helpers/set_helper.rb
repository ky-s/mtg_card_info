module SetHelper
  def booster_including_info(set)
    content_tag :div do
      set.booster_including_info.map { |rarity, count| "#{count} of #{rarity}" }.join(',')
    end
  end

  def fetch(set)
    return link_to('Fetched', set_fetch_cards_path(set: set.code), remote: true, class: %w(btn btn-sm btn-secondary disabled)) if set.fetched?
    link_to('Fetch', set_fetch_cards_path(set: set.code), remote: true, class: %w(btn btn-sm btn-danger))
  end

  def fetch_image(set)
    return link_to('T.B.D.', set_fetch_cards_image_path(set: set.code), remote: true, class: %w(btn btn-sm btn-danger disabled)) # FIXME
    return link_to('Fetched', set_fetch_cards_image_path(set: set.code), remote: true, class: %w(btn btn-sm btn-secondary disabled)) if set.image_fetched?
    link_to('Fetch', set_fetch_cards_image_path(set: set.code), remote: true, class: %w(btn btn-sm btn-danger))
  end
end
