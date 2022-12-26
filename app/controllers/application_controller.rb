class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_user_logged_in!
    if Current.user.nil?
      redirect_to sign_in_path, status: :unauthorized, alert: 'You must be signed in..'
      return false
    end
    true
  end

  def require_user_be_owner!
    if Current.user.nil? || @job.user_id != Current.user.id
      redirect_to sign_in_path, status: :unauthorized, alert: 'Not allowed'
      return false
    end
    true
  end
end