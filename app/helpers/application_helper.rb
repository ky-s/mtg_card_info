module ApplicationHelper
  def cards_view(cards, lightbox_group: 'card')
    content_tag :div, class: 'mx-auto', style: 'width: 100%' do
      cards.map do |card|
        concat card_view(card, lightbox_group: lightbox_group)
      end
    end
  end

  def card_view(card, lightbox_group: 'card')
    content_tag :span, class: 'mtg_card_container' do
      link_to(card_image_with_control_panel(card), card.image_src, { data: { lightbox: lightbox_group, title: card.title_label }, class: "mtg_card #{card.rarity.split.join}" })
    end
  end

  def card_image_with_control_panel(card)
    content_tag :span, class: 'control_panel' do
      concat image_tag(card.image_src, class: 'm-4')
      #concat link_to(content_tag(:i, '', class: 'fas fa-plus-square text-success'), add_favorites_path(card))
      #concat link_to(content_tag(:i, '', class: 'fas fa-plus-square text-success'), '#')
    end
  end
end
