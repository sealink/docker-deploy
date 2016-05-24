require 'docker/dockerrun'

module Docker
  module Dockerrun
    class Tag
      def initialize(new_tag)
        @new_tag = new_tag
      end

      def call
        open
        read
        overwrite_with_new_tag
        close
      end

      private

      attr_reader :file, :original_json

      def open
        @file ||= File.open(FILE_NAME, 'r+')
      end

      def read
        @original_json ||= file.read
      end

      def original_hash
        @original_hash ||= JSON.parse(original_json)
      end

      def original_image_value
        original_hash.fetch 'Image'
      end

      def original_name_value
        original_image_value.fetch 'Name'
      end

      def name_without_tag
        original_name_value.sub /:.*/, ''
      end

      def updated_name
        "#{name_without_tag}:#{@new_tag}"
      end

      def updated_image_value
        original_image_value.merge 'Name' => updated_name
      end

      def updated_hash
        original_hash.merge 'Image' => updated_image_value
      end

      def updated_json
        JSON.pretty_generate updated_hash
      end

      def overwrite_with_new_tag
        file.rewind
        file.write updated_json
      end

      def close
        file.close
      end
    end
  end
end
