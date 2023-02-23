class ApplicationController < ActionController::Base
  before_action :set_current_user
  # protect_from_forgery with::exception

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_user_logged_in!
    if Current.user.nil?
      redirect_to sign_in_path, alert: 'You must be signed in..'
      return false
    end
    true
  end

  def require_user_be_owner!
    if Current.user.nil? || @job.user_id != Current.user.id
      redirect_back(fallback_location: jobs_path, alert: 'Not allowed')
      # job_path(@job), status: :unauthorized, alert: 'Not allowed'
      return false
    end
    true
  end

  # rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  # rescue_from ::NameError, with: :error_occurred
  # rescue_from ::ActionController::RoutingError, with: :error_occurred
  # rescue_from ::AbstractController::DoubleRenderError, with: :error_occurred

  # Don't resuce from Exception as it will resuce from everything as mentioned here "http://stackoverflow.com/questions/10048173/why-is-it-bad-style-to-rescue-exception-e-in-ruby" Thanks for @Thibaut Barrère for mention that
  # rescue_from ::Exception, with: :error_occurred

  protected

  def record_not_found(exception)
    render json: {error: exception.message}.to_json, status: 404
  end

  def error_occurred(exception)
     render(:file => File.join(Rails.root, 'public/500.html'), :status => 500, :layout => false)
  end


  #  rescue_from ActionController::RoutingError, :with => :error_render_method
  #rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  #rescue_from ::ActionController::RoutingError, with: :routing_error



  #protected

  #def record_not_found(exception)
    #if Current.user && Current.user.role == 'Admin'
      #render json: { error: exception.message }.to_json, status: 404
      #else
      #render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
      #end
    #end

  #def routing_error(exception)
  #  render(:file => File.join(Rails.root, 'public/404.html'), :status => 404, :layout => false)
  #end

end