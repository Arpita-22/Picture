class ImagesController < ApplicationController
    skip_before_action :fetch_user, only: [:new,:create, :index, :show]

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
        imageUploaded = Cloudinary::Uploader.upload(params[:image][:photo], :type => :private, :sign_url => TRUE)
        image_uploaded = Image.create(user_id: session[:user_id], title: params[:image][:title].strip, 
                            image_url: imageUploaded['url'], width: imageUploaded['width'], 
                            height: imageUploaded['height'], format: imageUploaded['format'],
                            size_in_bytes: imageUploaded['bytes'])
        
        tags = params[:image][:tags].split(',')
        for tag in tags
            tag = tag.strip
            tag_created  = Tag.create(tag: tag)
            ImageTag.create(image_id: image_uploaded.id, tag_id: tag_created.id)
        end
        redirect_to '/images'
    end

    def show
        @logged_in = true
        @user = User.find(session[:user_id])
        @image = Image.new

        byebug
        tags = params[:image][:tags].split(',')
        image_ids = '';
        for tag in tags
            tag = tag.strip
            tag_found  = Tag.where(tag: "#{tag}")
            if tag_found != nil && tag_found != []
                image_tag = ImageTag.where(tag_id: tag_found.map{|tag| tag.id})
                image_ids = image_tag.map{|image| image.image_id}.join('|')
            end
        end
        
        @image_for_user =  Image.where(
            "user_id = ? AND 
            id::TEXT similar to ? AND
            title LIKE ? AND 
            width::TEXT LIKE ? AND 
            height::TEXT LIKE ? AND 
            format LIKE ? AND 
            size_in_bytes::TEXT LIKE ?", 
                session[:user_id],
                image_ids.blank? ? tags.blank? ? '%': 'null' : image_ids,
                params[:image][:title].blank? ? '%': params[:image][:title], 
                params[:image][:width].blank? ? '%': params[:image][:width], 
                params[:image][:height].blank? ? '%': params[:image][:height],
                params[:image][:format].blank? ? '%': params[:image][:format],
                params[:image][:size_in_bytes].blank? ? '%': params[:image][:size_in_bytes]);
        
        render :index
    end

end
