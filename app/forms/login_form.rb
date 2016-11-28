class LoginForm
  include ActiveModel::Model

  attr_accessor :email, :password, :request

  attr_reader :user

  validate :valid_user

  def valid_user
    if request.subdomain != 'backoffice' && request.subdomain.present?
      errors.add('This subdomain is invalid') unless club == Club.find_by(subdomain: request.subdomain)
      errors.add(:email, 'This email address could not be found') unless (@user == User.find_by(email: email, club_id: club.id))
    elsif request.subdomain == 'backoffice'
      errors.add(:email, 'This email address could not be found') unless (@user = User.find_by(email: email, club_id: nil, role: 'admin'))
    else
      errors.add(:email, 'This email address could not be found') unless (@user = User.find_by(email: email))
    end
  end

  def authenticated?
    return false if invalid?
    if @user.authenticate_field(:password, password)
      @user.unblocked? && @user.logged_in(request.remote_ip)
    elsif @user.authenticate_field(:recovery_code, password)
      if @user.recover(request.remote_ip)
        true
      else
        errors.add(:password, 'The recovery code has expired')
        false
      end
    else
      @user.failed_attempt
      errors.add(:password, 'The password is not correct')
      false
    end
  end

  def blocked?
    @user.present? && @user.blocked?
  end

  def blocked_until
    @user.present? && @user.blocked_until
  end
end
