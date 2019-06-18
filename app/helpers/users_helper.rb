module UsersHelper
  def users_reference_collection
    User.pluck :name, :id
  end
end
