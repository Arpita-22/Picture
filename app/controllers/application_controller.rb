class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    before_action :fetch_user

    def fetch_user
        @logged_in = logged_in?
        if @logged_in
            @user = User.find(session[:user_id])
        else
            redirect_to new_login_path
        end
    end

    def logged_in?
        !!session[:user_id]
    end

end
