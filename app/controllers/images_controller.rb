class ImagesController < ApplicationController
    skip_before_action :fetch_user, only: [:new,:create, :index, :search]

    def index
        @user = User.find(session[:user_id])
        @image_for_user = Image.where("user_id = #{session[:user_id]}")        
        @image = Image.new
        @logged_in = true
    end

    def new
        @user = User.find(session[:user_id])
        @image = Image.new
    end

    def create
        imageUploaded = Cloudinary::Uploader.upload("app/assets/flower.jpg", :type => :private, :sign_url => TRUE)
        byebug
        image_uploaded = Image.create(user_id: session[:user_id], title: params[:image][:title], image_url: imageUploaded['url'],
                width: imageUploaded['width'],height: imageUploaded['height'],format: imageUploaded['format'],
                size_in_bytes: imageUploaded['bytes'])
        
        tags = params[:image][:tags].split(',')
        for tag in tags
            tag_created  = Tag.create(tag: tag)
            ImageTag.create(image_id: image_uploaded.id, tag_id: tag_created.id)
        end
        redirect_to '/images'
    end


    def search
        byebug
    end
end
