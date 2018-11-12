class HomeController < ApplicationController
  def index
    @cards = MTG::Set.generate_booster('grn')
  end
end
