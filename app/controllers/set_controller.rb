class SetController < ApplicationController
  def index
    @sets_by_types = MTG::Set.all.sort_by(&:release_date).group_by(&:type)
  end
end
