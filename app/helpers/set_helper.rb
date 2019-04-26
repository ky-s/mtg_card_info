module SetHelper
  def booster_including_info(set)
    content_tag :div do
      set.booster_including_info.map { |rarity, count| "#{count} of #{rarity}" }.join(',')
    end
  end

  def fetch(set)
    return link_to('Fetched', set_fetch_cards_path(set: set.code), remote: true, class: %w(btn btn-sm btn-secondary disabled m-2)) if set.fetched?
    link_to('Fetch', set_fetch_cards_path(set: set.code), remote: true, class: %w(btn btn-sm btn-danger m-2 not_fetched))
  end

  def fetch_image(set)
    return link_to('Not feched', set_fetch_cards_image_path(set: set.code), remote: true, class: %w(btn btn-sm btn-danger disabled m-2)) unless set.fetched?
    return link_to('Fetched', set_fetch_cards_image_path(set: set.code), remote: true, class: %w(btn btn-sm btn-secondary disabled m-2)) if set.image_fetched?
    link_to('Fetch', set_fetch_cards_image_path(set: set.code), remote: true, class: %w(btn btn-sm btn-danger m-2 not_fetched))
  end
end
