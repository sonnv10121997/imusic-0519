class Supports::HomePage
  attr_reader :params

  def initialize params
    @params = params
  end

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

  def find_top model, limit = nil
    return model.constantize.top.limit limit if limit
    model.constantize.top.page(params[:page]).per Settings.track.list
  end

  def find_latest model, limit = nil
    return model.constantize.latest.limit limit if limit
    model.constantize.latest.page(params[:page]).per Settings.track.list
  end
end
