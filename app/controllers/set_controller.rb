class SetController < ApplicationController
  def index
    # @sets_by_types = MtgSet.all.sort_by(&:release_date).reverse.group_by(&:type)
    @sets_by_types = MtgSetLoader.load
  end

  def show
    @set = MtgSet.find_by(code: params[:set])
    @cards = MtgCard.where(set: params[:set]).sort
    @cards = MTG::Card.where(set: params[:set]).all if @cards.blank?
  end

  def fetch
    MTGDownloader::fetch_set
    flash[:notice] = 'Fetched.'
    redirect_to set_index_path
  end

  def fetch_cards
    MTGDownloader::fetch_card(params[:set])
    @set = MtgSet.find_by(code: params[:set])
    respond_to do |format|
      format.js
    end
  end

  def fetch_cards_image
    MTGDownloader::fetch_card_image(params[:set])
    @set = MtgSet.find_by(code: params[:set])
    respond_to do |format|
      format.js { render 'fetch_cards.js' }
    end
  end
end
