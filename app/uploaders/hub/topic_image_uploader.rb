module Hub
  class TopicImageUploader < Hub::BaseUploader
    def store_dir
      't/'
    end

    def extension_white_list
      %w(jpg jpeg gif png mp4)
    end

    def aliyun_bucket
      'hti'
    end
  end
end
