class ApplicationController < ActionController::Base

  NotAuthorized = Class.new(StandardError)

  rescue_from ApplicationController::NotAuthorized do |exception|
    redirect_to "/errors/403" 
  end
  
  def verify_owner_or_admin(obj)
    authorized = false
    begin
      # only if match all
      authorized =  current_user &&  (current_user.is_admin? ||  current_user == obj.user)
    rescue 
      raise ApplicationController::NotAuthorized
    end
    raise ApplicationController::NotAuthorized unless authorized
  end
  
  
  private

   def current_user
      
 		 if (user_id = session[:user_id])
       if @current_user.nil?          
           @current_user = User.find_by(id: user_id)
       end
      
     elsif (user_id = cookies.signed[:user_id])
      
         user = User.find_by(id: user_id)
         if user && user.authenticated?(:remember, cookies[:remember_token])
         session[:user_id] = user.id
         @current_user = user
       end
      
     elsif cookies[:auth_token]
         user = User.where(:auth_token => cookies[:auth_token]).first 
    end
        
 		return @current_user
   end
   helper_method :current_user
   
end
