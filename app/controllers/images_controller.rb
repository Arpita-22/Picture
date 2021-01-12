class ImagesController < ApplicationController
    skip_before_action :fetch_user, only: [:new,:create, :index, :search, :show]

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
        # byebug
        imageUploaded = Cloudinary::Uploader.upload("app/assets/flower.jpg", :type => :private, :sign_url => TRUE)
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

    def show
        @user = User.find(session[:user_id])
        #  @images_with_specific_title =  Image.where(user_id: @user.id, title: params[:image][:title])
        @images_with_specific_title =  Image.where(user_id: @user.id, title: params[:image][:title]).where(height: params[:image][:height],
                                    width: params[:image][:width]).where(format: params[:image][:format],
                                    size_in_bytes: params[:image][:size_in_bytes])
        byebug
        # tag_id = Tag.where(tag:[params[:image][:tags]]).id
        # image_id = ImageTag.where(tag_id: [tag_id])[0].image.id
        # tag_id = ImageTag.where(image_id: [images_with_specific_title])[0].tag.id
        redirect_to '/images'
    end


    # def search
    #     @logged_in = true
    #     byebug
    # end
end
