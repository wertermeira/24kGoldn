class UserScoreSerializer < ActiveModel::Serializer
  attributes :id, :max_score
  has_one :user, serializer: UserSerializer
end
