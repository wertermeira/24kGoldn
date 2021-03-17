class AuthService
  attr_accessor :auth

  def initialize(auth)
    @auth = auth
  end

  def call
    user = User.find_by(uid: auth.uid)
    return user if user

    register
  end

  private

  def register
    data = {
      credentials: auth.credentials, uid: auth.uid, email: auth.info.email
    }
    user = User.new(data)
    return user if user.save

    raise ActiveRecord::RecordInvalid.new(user)
  end
end