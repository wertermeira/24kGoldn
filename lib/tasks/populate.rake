namespace :populate do
  desc "TODO"
  task user_scores: :environment do
    10.times do
      score = rand(1..1000)
      user = User.create
      UserScore.create(user: user, max_score: score)
    end
  end

end
