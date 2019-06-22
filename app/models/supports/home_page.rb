class Supports::HomePage
  def class_method_helper model, method, list
    model.constantize.send method, list
  end

  def find_hot *models
    hot_arr = []
    models.each do |model|
      hot_arr += model.constantize.where(hot: true)
    end
    hot_arr
  end
end
