class AuthService
  attr_accessor :auth, :user

  def initialize(auth)
    @auth = auth
    @user = nil
  end

  def call
    @user = User.find_by(uid: auth.uid)
    return update_user if @user

    register
  end

  private

  def register
    user = User.new(attributes)
    return user if user.save

    build_error(user)
  end

  def attributes
    { credentials: auth.credentials, uid: auth.uid, email: auth.info.email, product: auth.info.product }
  end

  def update_user
    user.update(attributes)
    user
  end

  def build_error(user)
    raise ActiveRecord::RecordInvalid.new(user)
  end
end