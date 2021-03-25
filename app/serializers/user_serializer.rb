class UserSerializer < ActiveModel::Serializer
  attributes :id, :product, :spotify

  def id
    object.name
  end

  def spotify
    object.credentials.present?
  end
end
