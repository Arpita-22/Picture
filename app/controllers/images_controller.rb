class ImagesController < ApplicationController
    # skip_before_filter :verify_authenticity_token
    # protect_from_forgery prepend: true, with: :exception
    skip_before_action :fetch_user, only: [:new,:create]

    def index     
    end

    def new
    end

    def create
        # @user = User.find(session[:user_id])
        #@image = Cloudinary::Uploader.upload("https://res.cloudinary.com/dpjownedc/image/upload/v1610154645/njubhgvmagokcabutbgf.jpg")
    end

end
