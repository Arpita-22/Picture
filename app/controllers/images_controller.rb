require_relative '../helpers/images_helper'

class ImagesController < ApplicationController
    skip_before_action :fetch_user, only: [:new,:create, :index, :show]

    #created class variables for respective class in helper module for create and show methods
    @@search_image = ImagesHelper::SearchImages.new
    @@cloudinary = ImagesHelper::CloudinaryAPI.new
    @@create_image = ImagesHelper::CreateUpdateImages.new

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
        uploaded_image_details = @@cloudinary.upload(params[:image][:photo])
        @@create_image.create(session[:user_id], params[:image][:title].strip, 
                        uploaded_image_details, params[:image][:tags].split(','));
        redirect_to '/images'
    end

    #shows the image selected in the index page
    def show
        @logged_in = true
        @user = User.find(session[:user_id])
        @image = Image.new
        @image_for_user = @@search_image.search(params, @user.id)
        
        render :index
    end

end
