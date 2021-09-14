class WelcomeController < ApplicationController
  
  def index
    if current_user
      redirect_to "/posts"
    else
      # guest go to posts as well
      redirect_to "/posts"
    end  
  end
  
end
