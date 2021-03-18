module Users
  class ScoresController < ApplicationController
    def index
      ids = Ranking.new(current_user.id).call
      @scores = UserScore.where(id: ids).order(max_score: :desc)
      render json: @scores, each_serializer: UserScoreSerializer
    end

    def create
      @score = UserScore.find_or_create_by(user: current_user).tap do |row|
        if score_params.dig(:max_score) > row.max_score
          row.max_score = score_params.dig(:max_score) 
        end
      end
      render json: @score, serializer: UserScoreSerializer
    end
  
    private
  
    def score_params
      params.require(:score).permit(:max_score)
    end
  end
end