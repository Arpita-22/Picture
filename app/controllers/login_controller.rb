class LoginController < ApplicationController
    skip_before_action :fetch_user, only: [:new, :create]

    def new
        @user = User.new
    end

    def create
        @user = User.find_by(username: params[:username]) 
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to '/users'
        else
            flash[:message]= "User Not Found"
            redirect_to '/login/new'
        end
    end


    def destroy
        session.delete :user_id
        redirect_to new_user_path
    end
end
