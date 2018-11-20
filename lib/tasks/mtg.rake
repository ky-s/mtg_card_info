namespace :mtg do
  desc "MTG-APIと同期する"
  namespace :set do
    task :sync => :environment do
      MTG::Set.all.sort_by(&:release_date).each do |set|
        mtg_set = MtgSet.find_or_initialize_by(code: set.code)
        mtg_set.update(
          name: set.name,
          type: set.type,
          border: set.border,
          mkm_id: set.mkm_id,
          booster: set.booster,
          release_date: set.release_date,
          block: set.block
        )
      end
    end
  end

  namespace :card do
    task :sync, ['set_code'] => :environment do |task, args|
      MTG::Card.where(set: args[:set_code]).all.each do |card|
        mtg_card = MtgCard.find_or_initialize_by(multiverse_id: card.multiverse_id)
        mtg_card.update(
          name: card.name,
          jp_name: card.jp_name,
          img_url: card.img_url,
          set: card.set,
          rarity: card.rarity
        )
      end
    end

    task :fetch_image, ['set_code'] => :environment do |task, args|
      require 'open-uri'
      path = Rails.root.join('card_images', args[:set_code])
      FileUtils.mkdir_p(path)

      MtgCard.where(set: args[:set_code]).all.each do |mtg_card|
        img_path = path.join(mtg_card.multiverse_id.to_s)
        open(img_path, 'wb') do |out|
          open(mtg_card.img_url) do |img|
            out.write(img.read)
          end
        end
        mtg_card.update(img_url: img_path)
      end
    end
  end
end
