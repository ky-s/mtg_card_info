class MTG::Card
  def foreign_name(language)
    foreign_names&.detect { |f| f.language == language }
  end

  def img_url
    foreign_name('Japanese')&.image_url || image_url
  end

  def jp_name
    foreign_name('Japanese')&.name || name
  end

  def title_label
    "#{jp_name} (#{rarity}) [#{number}]"
  end

  def <=>(other)
    number.to_i <=> other.number.to_i
  end

  def image_src
    img_url
  end
end
