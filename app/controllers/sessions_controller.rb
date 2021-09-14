class SessionsController < ApplicationController
  
  def index
    redirect_to root_url
  end
  
  def new    
    if current_user
      @user = current_user
      redirect_to_dashboard  
      return    
    end
        
    render
  end
  
  
  def create    
    the_login = session_params[:login]
    @user = User.where(:login => the_login).first
    
    begin    
      if @user && @user.authenticate(session_params[:password]) && @user.activated
        session[:user_id] = @user.id

        if params[:session][:remember_me] == '1'
          remember(@user)
        else
          forget(@user)
        end

        redirect_to_dashboard

      elsif @user && @user.authenticate(session_params[:password]) 
        # not activated

        flash[:alert] = "The account is not activated yet, please check your activation email"   
        @login = the_login
        render "/sessions/new", :alert => "The account is not activated yet, please check your activation email"     
  
      else
        flash[:error] = "Please enter a correct username and password."
        @login = the_login
        render "/sessions/new", :alert => "Please enter a correct username and password."
      end
      
    rescue BCrypt::Errors::InvalidHash
      flash[:error] = 'Invalid password'
      redirect_to "/sign-in"
    end 
  
  end
   
  
  def destroy
    forget(current_user)
    session[:user_id] = nil
    reset_session
    @user = nil
    redirect_to "/", :notice => "You have been signed out successfully"     
  end
  
  private
  
  def redirect_to_dashboard
    redirect_to "/posts", :notice => "Logged in as #{current_user.login}"            
  end
   
  def session_params
    params.require(:session).permit(:login, :email, :password)
  end


  # Remembers a user in a persistent session.
  def remember(user)
    if user
      user.remember 
      cookies.permanent.signed[:user_id] = user.id
      cookies.permanent[:remember_token] = user.remember_token
    end
  end
    

  # Forgets a persistent session.
  def forget(user)
    user.forget if user
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  
end
