class UserScoreSerializer < ActiveModel::Serializer
  attributes :id, :max_score, :position
  has_one :user, serializer: UserSerializer

  def position
    scope[:ids].index(object.id) if scope[:ids].present?
  end
end
