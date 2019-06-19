class Supports::HomePage
  def take_helper model, list
    model.constantize.take list
  end
end
