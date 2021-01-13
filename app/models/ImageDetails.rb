class ImageDetails

    attr_accessor :image
    attr_accessor :tags

    def initialize(image, tags)
        @image = image
        @tags = tags
    end

end