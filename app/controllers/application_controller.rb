class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :store_location

  def store_location
  	session[:user_return_to] = request.fullpath unless (request.fullpath =~ /\/users/)
  end

  def after_sign_in_path_for(resource)

    if session[:user_return_to] =~ /\/e\//
      session[:user_return_to]
    else 
      dash_path
    end
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:warning] = 'Resource not found.'
    redirect_back_or root_path
  end
 
  def redirect_back_or(path)
    redirect_to request.referer || path
  end

end