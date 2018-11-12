module MTGSDKUsable
  refine MTG::Card do
    def foregin_name(language)
      foreign_names.detect { |f| f.language == 'Japanese' }
    end

    def img_url
      foregin_name&.image_url || image_url
    end
  end
end
