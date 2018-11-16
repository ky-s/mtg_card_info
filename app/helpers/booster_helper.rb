module BoosterHelper
  def menu(set)
    content_tag :div do
      concat link_to('もう一度引く', booster_show_path(set: set.code), class: 'btn btn-success')
      concat link_to('セット一覧に戻る', set_index_path, class: 'btn btn-link')
    end
  end
end
