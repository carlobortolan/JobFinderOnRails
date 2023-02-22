class WelcomeController < ApplicationController
  def index
    if Current.user
      flash.now[:notice] = "Logged in as #{Current.user.email}"
    else
      flash.now[:alert] = "Currently not logged in!"
    end
  end

  def about
  end
end
