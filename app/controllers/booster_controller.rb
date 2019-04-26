class BoosterController < ApplicationController
  before_action :load_set

  def show
    @cards = GenerateBooster.new(@set).bulk_generate(params.fetch(:num, 1).to_i)
  end

  private

  def load_set
    @set = MtgSet.find_by(code: params[:set])
  end
end
