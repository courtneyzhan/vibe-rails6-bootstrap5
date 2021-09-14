class ResetController < ApplicationController

  before_action :check_whether_is_allowed

  def index
    flash[:notice] = t(:database_reset)

    load_seed

    if current_user && (request.xhr? || params[:background])
      render :plain => "Reset OK"
    elsif current_user
      redirect_to '/'
    else
      redirect_to "/sign-in"
    end        
  end
  
  private
  
    
  def check_whether_is_allowed	
    resetable_envs = %w(development test local integration sandbox demo)
    raise I18n.t(:not_authorized) unless resetable_envs.include?(Rails.env)
    
    Rails.cache.clear      
  end
  
	def load_seed(filename = "seeds.rb")
	  start_time = Time.now    
    $RESET_IN_PROGRESS = true
    begin
      seed_file = File.expand_path(File.join(Rails.root, "db", filename))
      logger.info "About to load seed_file: #{seed_file}"
      load seed_file
    rescue => e
      puts "failed to seed: #{e}, #{e.backtrace}"
    ensure
      $RESET_IN_PROGRESS = false
    end		
    puts "Reset v2 took  #{Time.now - start_time} seconds"		
	end
  
  
end
