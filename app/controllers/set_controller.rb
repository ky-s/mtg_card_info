class SetController < ApplicationController
  def index
    @sets_by_types = MtgSet.all.sort_by(&:release_date).reverse.group_by(&:type)
  end

  def show
    @set = MtgSet.find_by(code: params[:set])
    @cards = MtgCard.where(set: params[:set]).sort
    @cards = MTG::Card.where(set: params[:set]).all if @cards.blank?
  end

  def fetch
    require 'rake'
    Rails.application.load_tasks
    Rake::Task['mtg:set:sync'].execute
    Rake::Task['mtg:set:sync'].clear
    flash[:notice] = 'Fetched.'
    redirect_to set_index_path
  end

  def fetch_cards
    require 'rake'
    Rails.application.load_tasks
    Rake::Task["mtg:card:sync"].execute(set_code: params[:set])
    Rake::Task["mtg:card:sync"].clear
    @set = MtgSet.find_by(code: params[:set])
    respond_to do |format|
      format.js
    end
  end

  def fetch_cards_image
    require 'rake'
    Rails.application.load_tasks
    Rake::Task["mtg:card:fetch_image"].execute(set_code: params[:set])
    Rake::Task["mtg:card:fetch_image"].clear
    @set = MtgSet.find_by(code: params[:set])
    respond_to do |format|
      format.js { render 'fetch_cards.js' }
    end
  end

  # def fetch_cards_progress
  #   cards = MtgCard.where(set: params[:set])
  #   render json: { percent: cards.size / params[:max] }
  # end

  # def fetch_cards_image_progress
  #   cards = MtgCard.where(set: params[:set])
  #   #render json: { percent: cards.select { |card| card.image.attached? }.size / cards.size }
  #   render json: { percent: params[:percent].to_i + 1 }
  # end
end
