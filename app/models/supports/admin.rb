class Supports::Admin
  def size model
    model.constantize.pluck(:id).size
  end
end
