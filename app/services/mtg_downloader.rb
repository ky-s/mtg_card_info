module MTGDownloader
  module_function

  def fetch_set
    MTG::Set.all.sort_by(&:release_date).each do |set|
      mtg_set = MtgSet.find_or_initialize_by(code: set.code)
      mtg_set.update(
        name:         set.name,
        type:         set.type,
        border:       set.border,
        mkm_id:       set.mkm_id,
        booster:      set.booster,
        release_date: set.release_date,
        block:        set.block
      )
    end
  end

  def fetch_card(set_code)
    cards = MTG::Card.where(set: set_code).all

    cards.each.with_index(1) do |card, count|
      mtg_card = MtgCard.find_or_initialize_by(multiverse_id: card.multiverse_id)
      mtg_card.update(
        name:           card.name,
        jp_name:        card.jp_name,
        img_url:        card.img_url,
        set:            card.set,
        rarity:         card.rarity,
        colors:         card.colors&.join(','),
        color_identity: card.color_identity&.join(','),
        number:         card.number,
        artist:         card.artist
      )

      ActionCable.server.broadcast(
        'progress:1',
        percent: (count.to_f / cards.size.to_f * 100).to_i,
        set:     set_code,
        action:  'fetch'
      )
    end

    MtgSet.find_by(code: set_code).update(fetched: true)
  end

  def fetch_card_image(set_code)
    require 'open-uri'

    Rails.logger.info "---------------------------------------------------------"
    Rails.logger.info "mtg:card:fetch_image[#{set_code}] start."
    Rails.logger.info "---------------------------------------------------------"

    cards = MtgCard.where(set: set_code)

    cards.each.with_index(1) do |mtg_card, count|
      Rails.logger.info "loading and saving image #{mtg_card.jp_name}"

      if !mtg_card.image.attached? && mtg_card.img_url.present?

        open(mtg_card.img_url) do |file|
          uploaded_file = ActionDispatch::Http::UploadedFile.new(
            filename: mtg_card.multiverse_id.to_s,
            type:     'image/jpeg',
            tempfile: file
          )
          mtg_card.image.attach(uploaded_file)
        end

      end

      ActionCable.server.broadcast(
        'progress:1',
        percent: (count.to_f / cards.size.to_f * 100).to_i,
        set:     set_code,
        action:  'fetch_image'
      )

      Rails.logger.info "completed image #{mtg_card.jp_name}"
    end

    MtgSet.find_by(code: set_code).update(image_fetched: true)

    Rails.logger.info "---------------------------------------------------------"
    Rails.logger.info "mtg:card:fetch_image[#{set_code}] done."
    Rails.logger.info "---------------------------------------------------------"
  end
end
