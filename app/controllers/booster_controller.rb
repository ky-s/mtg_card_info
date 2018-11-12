class BoosterController < ApplicationController
  before_action :fetch_set

  def index
    @cards = MTG::Set.generate_booster(params[:set])
  end

  def show
    @cards = MTG::Set.generate_booster(params[:set])
  end

  private

  def fetch_set
    @set = MTG::Set.find(params[:set])
  end
end
