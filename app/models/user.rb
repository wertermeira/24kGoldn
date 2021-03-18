class User < ApplicationRecord
  before_create :generate_token, :generate_name

  private

  def generate_name
    self.name = loop do
      random_string = string_shuffle("#{[*('A'..'Z')].sample(3).join}#{rand(100..999)}")
      break random_string unless User.exists?(name: random_string)
    end
  end

  def generate_token
    self.token = loop do
      random_token = SecureRandom.alphanumeric(100)
      break random_token unless User.exists?(token: random_token)
    end
  end

  def string_shuffle(s)
    s.split('').shuffle.join
  end
end
