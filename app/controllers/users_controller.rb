class UsersController < ApplicationController
    skip_before_action :fetch_user, only: [:new,:create]
    def index
       @users = User.all
    end

    def show
        byebug
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def create
        @user = User.create(user_params)
        if @user.valid?
            session[:user_id] = @user.id
            redirect_to '/images'
        else
        #     flash[:errors] = @user.errors
            redirect_to new_user_path
        end
    end

    private

    # def get_user
    #     @user = User.find(params[:id])
    # end

    def user_params
        params.require(:user).permit(:username,:password,:password_confirmation)
    end
end
