module ImagesHelper

    class CreateUpdateImages
        
        def create (user_id, title, uploaded_image_details, tags)
            image_uploaded = Image.create(user_id: user_id, title: title, 
                            image_url: uploaded_image_details['url'], width: uploaded_image_details['width'], 
                            height: uploaded_image_details['height'], format: uploaded_image_details['format'],
                            size_in_bytes: uploaded_image_details['bytes'])
            for tag in tags
                tag = tag.strip
                tag_created  = Tag.create(tag: tag)
                ImageTag.create(image_id: image_uploaded.id, tag_id: tag_created.id)
            end
        end

    end

    class CloudinaryAPI
    
        def upload (image_url)
            return Cloudinary::Uploader.upload(image_url, :type => :private, :sign_url => TRUE)
        end
    end
    
    class SearchImages

        def search (params, user_id)
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
            
            image_for_user =  Image.where(
                "user_id = ? AND 
                id::TEXT similar to ? AND
                title LIKE ? AND 
                width::TEXT LIKE ? AND 
                height::TEXT LIKE ? AND 
                format LIKE ? AND 
                size_in_bytes::TEXT LIKE ?", 
                    user_id,
                    image_ids.blank? ? tags.blank? ? '%': 'null' : image_ids,
                    params[:image][:title].blank? ? '%': params[:image][:title], 
                    params[:image][:width].blank? ? '%': params[:image][:width], 
                    params[:image][:height].blank? ? '%': params[:image][:height],
                    params[:image][:format].blank? ? '%': params[:image][:format],
                    params[:image][:size_in_bytes].blank? ? '%': params[:image][:size_in_bytes]);
            
            return image_for_user
        end

    end

end
