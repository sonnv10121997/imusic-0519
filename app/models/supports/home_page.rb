class Supports::HomePage
  def class_method_helper model, method, list
    model.constantize.send method, list
  end
end
