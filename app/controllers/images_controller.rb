class ImagesController < ApplicationController
    def index
        @image = Cloudinary::Uploader.upload("https://res.cloudinary.com/dpjownedc/image/upload/v1610154645/njubhgvmagokcabutbgf.jpg")
    end
end
