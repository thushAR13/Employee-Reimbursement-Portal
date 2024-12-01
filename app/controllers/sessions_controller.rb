class SessionsController < ApplicationController
    # skip_before_action :authenticate_user, only: [:new, :create]
  
    def new
      # Login page for unauthenticated users
    end
  
    def create
      auth = request.env['omniauth.auth']
      user = User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
        u.name = auth['info']['name']
        u.email = auth['info']['email']
      end
      session[:user_id] = user.id
      redirect_to companies_path, notice: 'Successfully signed in!'
    end
  
    def destroy
      session[:user_id] = nil
      redirect_to root_path, notice: 'Successfully signed out!'
    end
  end
  