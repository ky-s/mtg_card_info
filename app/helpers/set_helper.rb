module SetHelper
  def booster_including_info(set)
    colors = ['success', 'info', 'primary', 'secondary', 'warning', 'danger']
    content_tag :div do
      set.booster_including.each do |rarity, count|
        concat(content_tag :div, "#{count} of #{rarity}", class: %w(m-2))
      end
    end
  end
end
