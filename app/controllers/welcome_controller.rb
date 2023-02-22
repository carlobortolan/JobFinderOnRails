class WelcomeController < ApplicationController
  def index
    if Current.user
      # flash.now[:notice] = "Logged in as #{Current.user.email}"
    else
      # flash.now[:alert] = "Currently not logged in!"
    end
  end

  def about
  end

  def privacy_policy
  end

  def api
  end

  def faq
  end

  def cookies
  end

  def help
  end
end
