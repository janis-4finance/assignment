class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :sign_in_user
  
  def sign_in_user
    if current_user.blank?
      user = User.new
      user.save( :validate => false )
      user.remember_me = true
      sign_in( :user, user )
    end
  end

end
