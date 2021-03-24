class UserSerializer < ActiveModel::Serializer
  attributes :id, :product

  def id
    object.name
  end
end
