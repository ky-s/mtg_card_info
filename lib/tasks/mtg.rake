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

      MtgCard.where(set: args[:set_code]).all.each do |mtg_card|
        puts "loading #{mtg_card.jp_name}..."

        open(mtg_card.img_url) do |file|
          uploaded_file = ActionDispatch::Http::UploadedFile.new(
            filename: mtg_card.multiverse_id.to_s,
            type: 'image/jpeg',
            tempfile: file
          )
          mtg_card.image.attach(uploaded_file)
        end

        puts "completed #{mtg_card.jp_name}..."
      end
      puts 'done.'
    end
  end
end
