class SecureController < ApplicationController
  
  before_action :authenticate_user
  
  
  def authenticate_user        
    if session[:user_id].nil?
      
      if (user_id = cookies.signed[:user_id])      
        user = User.find_by(id: user_id)
        if user && user.authenticated?(:remember, cookies[:remember_token])
          session[:user_id] = user.id
          @current_user = user
        end
      end
      
      if session[:user_id].nil?         
          the_notice = flash[:notice] || I18n.t(:not_logged_in) 
          redirect_to :sign_in , :notice => the_notice
          return
      end
      
    end    
    
  end
  
  
end
