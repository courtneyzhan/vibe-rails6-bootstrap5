class UsersController < SecureController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user, only: [:new, :create]

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)

    if @user.time_zone.nil?
      @user.time_zone = Time.zone.name # set by https://github.com/kbaum/browser-timezone-rails
    end
    
    if user_params[:password].blank? || user_params[:password_confirmation] != user_params[:password]        
      @user.errors.add(:password, "The two password fields didn’t match.")
      render :new
      return
    end
    
    flag_requires_activiation = false
    
    respond_to do |format|   
               
      if @user.save       
        
        if flag_requires_activiation
          @user.send_activation_email 
        else 
          @user.update_column(:activated, true)
        end
        
        flash[:notice] = I18n.t(:check_account_activiation_email);
        format.html { redirect_to "/sign-in" }
      else
        format.html { render :new}        
      end
    end        
    
  end
  
  
  def edit
    if current_user != @user
      flash[:notice] = t(:not_authorized)
      redirect_to "/"
      return
    end
  end
  
  
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    puts "---> user update --"
    if current_user != @user
      redirect_to "/", :alert =>  I18n.t(:not_authorized)
      return
    end
  
    respond_to do |format|
      if @user.update(user_params)

        format.html {
          flash[:notice] = I18n.t(:user_profile_updated_ok)
          if params[:refer_page] && !params[:refer_page].blank?
            redirect_to params[:refer_page]
          else
            redirect_to "/"
          end
         }
        format.json { render :show, status: :ok, location: @user }
        format.js { }
  
      else
        @error = @user.errors.full_messages.join(", ")
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js { }
      end
    end
    
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    
    

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:login, :email, :first_name, :last_name, :mobile, :gender, :birth_date, :password_digest, :password_reset_token, :password_reset_sent_at, :password, :password_confirmation, :avatar, :locale, :time_zone, :address, :country, :latitude, :longitude)
    end
    
end
