class Ranking
  attr_accessor :user_id, :ids
  def initialize(user_id)
    @user_id = user_id
    @ids = []
  end

  def call
    user_score = UserScore.find_by(user_id: user_id)
    return { ids: [], all_ids: [] } if user_score.blank?

    total = UserScore.count
    @ids = UserScore.order(max_score: :desc).pluck(:id)
    position = @ids.index(user_score.id)
    total = @ids.count
    @novos_ids = []
    case position
    when 0,1
      each_from_array([*0..4])
    when 2,3
      each_from_array([*1..5])
    else
      if total == (position + 1)
        to_up = position - 4
        to_down = position
      elsif total == (position + 2)
        to_up = position - 3
        to_down = position + 1
      else
        to_up = position - 2
        to_down = position + 2
      end
      each_from_array([*to_up..to_down])
    end
    { ids: @novos_ids, all_ids: @ids }
  end

  private

  def each_from_array(item)
    item.each do |id|
      @novos_ids.push(ids[id]) if ids[id].present?
    end
  end
end