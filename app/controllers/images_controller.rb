class ImagesController < ApplicationController
    skip_before_action :fetch_user, only: [:new,:create, :index]

    def index
        @user = User.find(session[:user_id])
        @image_for_user = Image.where("user_id = 10")        
        @image = Image.new
        @logged_in = true
    end

    def new
        @user = User.find(session[:user_id])
        @image = Image.new
    end

    def create
        byebug
        imageUploaded = Cloudinary::Uploader.upload("app/assets/flower.jpg")
        @image_uploaded = Image.create(user_id: session[:user_id], title: params[:image][:title], image_url: imageUploaded['url'],
                width: imageUploaded['width'],height: imageUploaded['height'],format: imageUploaded['format'],
                size_in_bytes: imageUploaded['bytes'])
        
        # tags = params[:image][:tags].split(',')
        # for tag in tags
        #     ImageTag.create(tag_name: tag, )
        # end
                
        
        redirect_to '/images'
    end
end
