class Authentication::SessionsController < ApplicationController

    skip_before_action :protect_pages 
   
    def new
        
    end

    def create

        @user = User.find_by("email = :login OR username = :login", {login: params[:login]})

        if @user&.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to  products_path, notice: "Autenticación exitosa" 
        else
            redirect_to new_session_path, alert: "ususario o contraseña invalidos"
        end

    end

end
