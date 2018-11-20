module BoosterHelper
  def menu(set)
    content_tag :div, class: 'p-4' do
      concat link_to('One More Chance', booster_show_path(set: set.code), class: 'btn btn-success m-2')
      concat link_to('Return to Top', set_index_path, class: 'btn btn-secondary m-2')
    end
  end
end
