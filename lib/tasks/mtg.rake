namespace :mtg do
  desc "MTG-APIと同期する"
  namespace :set do
    task :sync => :environment do
      MTGDownloader::fetch_set
    end
  end

  namespace :card do
    task :sync, ['set_code'] => :environment do |task, args|
      MTGDownloader::fetch_card(args[:set_code])
    end

    task :fetch_image, ['set_code'] => :environment do |task, args|
      MTGDownloader::fetch_card_image(args[:set_code])
    end
  end
end
