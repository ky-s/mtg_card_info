module MtgSetLoader
  module_function

  PRIORITY_ORDER = ['expansion', 'core', 'masterpiece', 'masters', 'funny', 'starter']

  def load
    sets = MtgSet.all.sort_by(&:release_date).reverse.group_by(&:type)
    PRIORITY_ORDER.map { |order| [order, sets.delete(order)] }.to_h.merge(sets)
  end
end
