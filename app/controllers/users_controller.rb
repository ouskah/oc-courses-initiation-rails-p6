class UsersController < ApplicationController
  
  def index
    @users = User.all
    
      if @current_user && @current_user.role != "admin" or @current_user == nil
        flash[:error] = "Accès interdit ! (S'identifier en session: admin)"
        redirect_to request.referrer || root_path
      end
  end
  
  
  def home
  end

  def login
  end
  
  def delogin
    
    session[:user_id] = nil
    redirect_to "/users/home"
    
  end
  
  
  def check
    @current_user = User.where(name: params[:name], password: params[:password]).first
      if @current_user
        session[:user_id] = @current_user.id
        
        #flash[:info] = "Bienvenue #{@current_user.name} !"
        redirect_to "/users/home"
      else
        session[:user_id] = nil
        flash[:info] = "Échec de la connexion"
        redirect_to "/users/login"
      end
  end
  
  
  
  
end
