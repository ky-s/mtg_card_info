class SetController < ApplicationController
  def index
    @sets_by_types = MtgSet.all.sort_by(&:release_date).reverse.group_by(&:type)
  end

  def show
    @set = MtgSet.find_by(code: params[:set])
    @cards = MtgCard.where(set: params[:set])
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
    @set = MtgSet.find_by(code: params[:set])
    require 'rake'
    Rails.application.load_tasks
    Rake::Task["mtg:card:sync"].execute(set_code: params[:set])
    Rake::Task["mtg:card:sync"].clear
    # Rake::Task["mtg:card:fetch_image"].execute(set_code: params[:set])
    # Rake::Task["mtg:card:fetch_image"].clear
    flash[:notice] = 'Fetched.'
    respond_to do |format|
      format.js
    end
  end

  def fetch_cards_image
    @set = MtgSet.find_by(code: params[:set])
    require 'rake'
    Rails.application.load_tasks
    Rake::Task["mtg:card:fetch_image"].execute(set_code: params[:set])
    Rake::Task["mtg:card:fetch_image"].clear
    flash[:notice] = 'Fetched.'
    respond_to do |format|
      format.js
    end
  end
end
