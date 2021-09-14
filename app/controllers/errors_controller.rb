class ErrorsController < ApplicationController

  # forbidden
  def error_403
    if current_user.nil?
      flash[:error] = "You have to be logged in to perform that action"
    else 
      flash[:error] = "You do not have permission to perform that action"
    end
    redirect_to "/"    
  end
  
  def error_404
    respond_to do |format|        
      format.html { 
        render template: '/errors/not_found', layout: 'layouts/error', status: 404 
        return
      }
      format.all  { head :ok, status: 404 }
    end
  end

  def error_500
    respond_to do |format|
      format.html { render template: '/errors/server_error', layout: 'layouts/error', status: 500 }
      format.all  { head :ok, status: 500}
    end
  end

end
